class Api::V1::UsersController < Api::V1::BaseController
  def show
    render json: current_user.to_h
  end

  def update
    current_user.update(user_params)
    render json: current_user.to_h
  end

  private

  def user_params
    params.require(:user).permit(:max_number, :nickname, :avatar)
  end
end
