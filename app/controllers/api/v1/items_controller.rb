class Api::V1::ItemsController < Api::V1::BaseController

  def index
    @items = current_user.items
    render json: @items
    # render json: @user
  end

  private

  def item_params
    params.require(:item).permit(:is_giveaway, :item_type, :remark, photos:[])
  end
end
