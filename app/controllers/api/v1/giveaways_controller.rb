class Api::V1::GiveawaysController < Api::V1::BaseController

  # The giveaway shall be created by the user who claims that item
  def create
    item = Item.find(params[:item_id])
    giveaway = Giveaway.new
    giveaway.user = current_user
    giveaway.item = item

    unless giveaway.save
      puts "THIS IS ERROR MES, #{giveaway.errors.full_messages}"
    end

    if current_user.update(update_user_params)
      render json: {
        giveaway: giveaway
      }
    else
      puts "THIS IS ERROR MES, #{current_user.errors.full_messages}"
    end
  end

  # This update action can only be invoked by the owner!
  def update
    giveaway = Giveaway.find(giveaway_params[:id])

    unless current_user == giveaway.item.user
      render json: { message: 'You are not permitted to change the status of this giveaway.' }
      return
    end

    item = giveaway.item
    giveaways_all = item.giveaways
    giveaways_all.each do |ga|
      if ga.user.id == giveaway_params[:user_id]
        ga.update(status: 'accepted')
      else
        ga.update(status: 'gone')
      end
    end

    item.user = User.find(giveaway_params[:user_id])

    render json: {
      item: item.all_info
    }
  end

  private

  def update_user_params
    params.require(:user).permit(:avatar, :nickname)
  end
end
