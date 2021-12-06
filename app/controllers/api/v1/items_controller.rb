class Api::V1::ItemsController < Api::V1::BaseController
  def index
    @items = current_user.items
    @types = ['Top', 'Bottom', 'Coat', 'Shoes', 'Dress']
    @arr = []
    @types.map! do |type|
       { category: type, items: @items.where(item_type: type).map{|item| item.to_h} }
    end
    # render json: @arr
    render json: @types
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

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      render json: @item
    else
      puts "THIS IS ERROR MES,#{@item.errors.full_messages}"
    end
  end

  def update
  end

  def upload
    @item = Item.find(params[:id])
    if @item.photo.attach(params.require(:file))
      render json: { msg: 'photo uploaded' }
    else
      render json: { err: 'fail to upload' }
    end
  end

  private

  def item_params
    params.require(:item).permit(:is_giveaway, :item_type, :remark, :photo, tag_list: [])
  end
end
