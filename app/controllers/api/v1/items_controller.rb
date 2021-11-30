class Api::V1::ItemsController < Api::V1::BaseController
  before_action :find_user

  def index
    @items = Item.where(user: @user)
    render json: @items
    render json: @user
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end