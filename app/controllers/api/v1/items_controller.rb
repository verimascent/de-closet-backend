class Api::V1::ItemsController < Api::V1::BaseController
  def index
    @items = current_user.items
    render json: @items
  end

  def show
    @item = Item.find(params[:id])
    if current_user.items.include?(@item)
      render json: @item
    else
      render json: {
        :error => "You have no rights to access that photo."
      }
    end
  end

  def new
  end

  def create
    @item = Item.create!(item_params)
    redirect_to @item
  end

  private

  def item_params
    params.require(:item).permit(:is_giveaway, :item_type, :remark, photos:[])
  end
end
