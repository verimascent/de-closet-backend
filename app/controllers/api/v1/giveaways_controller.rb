class Api::V1::GiveawaysController < Api::V1::BaseController

  # The giveaway shall be created by the user who claims that item
  def create
    @array = params[:selected]
    @arr_gas = []
    @array.each do |num|
      @item = Item.find(num)
      @giveaway = Giveaway.new
      @giveaway.user = current_user
      @giveaway.item = @item
      if @giveaway.save
        @arr_gas << @giveaway
      else
        puts "THIS IS ERROR MES, #{@giveaway.errors.full_messages}"
        return
      end
    end
    render json: @arr_gas
  end

  # This update action can only be invoked by the owner!
  def update
    @giveaway = Giveaway.find(giveaway_params[:id])
    @item = @giveaway.item

    unless current_user == @giveaway.item.user
      render json: { message: 'You are not permitted to change the status of this giveaway.' }
      return
    end

    p 'THIS IS giveaway_params'
    p giveaway_params
    p 'We use KEY'
    p giveaway_params[:user_id]
    p giveaway_params[:user_id].class
    p 'We use quotes'
    p giveaway_params['user_id']
    p giveaway_params['user_id'].class
    return

    @giveaways_all = @item.giveaways





    @ga_accept = @giveaways_all.select { |ga| ga.status == 'gone' }

    if params[:status] == 'gone'

    end

    if @ga_accept.empty? && @giveaway.update(giveaway_params)
      # render json:
    else

    end
  end

  private

  def giveaway_params
    params.require(:giveaway).permit(:id, :user_id)
  end
end
