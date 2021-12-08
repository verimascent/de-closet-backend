class Api::V1::UsersController < Api::V1::BaseController
  def show
    render json: current_user
  end

  def update
    current_user.update(user_params)
    render json: current_user
  end

  private

  def user_params
    params.require(:user).permit(:max_number)
  end
end
