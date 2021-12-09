class Api::V1::ItemsController < Api::V1::BaseController
  before_action :find_item, only: [:show, :update, :destroy, :upload]

  def index
    types = ['Tops', 'Bottoms', 'Coats', 'Shoes', 'Dresses', 'Bags', 'Accessories']
    arr_req = ['my_closet', 'giveaways']

    request = arr_req.include?(params[:req_type]) ? params[:req_type] : 'my_closet'
    info = send(request, types)
    info[:user_items] = filter(params[:tag_array], types) if params[:tag_array]
    render json: info
  end

  def show
    if @item.user == current_user
      render json: { item: @item.to_h }
    else
      render json: {
        :error => "You have no rights to access that item."
      }
    end
  end

  def create
    item = Item.new(item_params)
    item.user = current_user
    if item.save
      render json: { item: item.to_h, user: current_user.to_h }
    else
      puts "THIS IS ERROR MES, #{item.errors.full_messages}"
    end
  end

  def update
    if @item.update(item_params)
      render json: { item: @item.to_h, user: current_user.to_h }
    else
      puts "THIS IS ERROR MES, #{item.errors.full_messages}"
    end
  end

  def destroy
    if @item.destroy
      render json: {
        message: 'This item has been successfully deleted.',
        user: current_user.to_h
      }
    else
      puts "THIS IS ERROR MES, #{item.errors.full_messages}"
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

  def my_closet(array)
    items = current_user.items.closet #.where(is_giveaway: false, item_type: array)
    num = items.length
    arr = array.map do |type|
      { category: type, items: items.where(item_type: type).map {|item| item.to_h} }
    end
    return {
      user: current_user.to_h,
      number_of_items: num,
      user_items: arr
    }
  end

  def giveaways(array)
    user = current_user
    user = User.find(params[:user_id]) if params[:user_id].present?
    items = user.items.out # .where(is_giveaway: true, item_type: array)
    num = items.length
    items = items.map { |item| item.all_info }
    return {
      user: current_user.to_h,
      number_of_items: num,
      items: items
    }
  end

  def filter(tags, array)
    items = Item.tagged_with(tags)
    arr = array.map do |type|
      { category: type, items: items.where(item_type: type).map {|item| item.to_h} }
    end
    return arr
  end

  def item_params
    params.require(:item).permit(:is_giveaway, :item_type, :remark, :photo, tag_list: [])
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
