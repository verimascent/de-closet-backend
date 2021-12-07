class Api::V1::GiveawaysController < Api::V1::BaseController

  # The giveaway shall be created by the user who claims that item
  def create
    @item = Item.find(params[:item_id])
    @giveaway = Giveaway.new
    @giveaway.user = current_user
    @giveaway.item = @item
    if @giveaway.save
      render json: @giveaway
    else
      puts "THIS IS ERROR MES, #{@giveaway.errors.full_messages}"
    end
  end

  def update
    @giveaway = Giveaway.find(params[:id])
  end

  private

  def giveaway_params
    params.require(:giveaway).permit(:status, :item_id)
  end
end
