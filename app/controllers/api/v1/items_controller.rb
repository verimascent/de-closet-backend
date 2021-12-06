class Api::V1::ItemsController < Api::V1::BaseController
  before_action :find_item, only: [:show, :update, :destroy, :upload]

  def index
    @items = current_user.items
    @types = ['Top', 'Bottom', 'Coat', 'Shoes', 'Dress']
    @arr = []
    @types.map! do |type|
       { category: type, items: @items.where(item_type: type).map{|item| item.to_h} }
    end
    render json: {
      user: current_user,
      user_items: @types
    }
  end

  def show
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
      puts "THIS IS ERROR MES, #{@item.errors.full_messages}"
    end
  end

  def update
    if @item.update(item_params)
      render json: @item
    else
      puts "THIS IS ERROR MES, #{@item.errors.full_messages}"
    end
  end

  def destroy
    if @item.destroy
      render json: {
        messege: 'This item has been successfully deleted.'
      }
    else
      puts "THIS IS ERROR MES, #{@item.errors.full_messages}"
    end
  end

  def upload
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

  def find_item
    @item = Item.find(params[:id])
  end
end
