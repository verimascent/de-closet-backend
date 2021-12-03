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
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      render json: @item
    else
      puts "THIS IS ERROR MES,#{@item.errors.full_messages}"
    end

  end

  def upload
    @item = Item.find(params[:id])
    # params[:file]
    if @item.photo.attach(params.require(:file))
      render json: { msg: 'photo uploaded' }
    else
      render json: { err: 'fail to upload' }
    end
  end

  def

  end

  private

  def item_params
    params.require(:item).permit(:is_giveaway, :item_type, :remark, :photos)
  end
end
