class Api::V1::UsersController < Api::V1::BaseController
  def update
    current_user.update(user_params)
    render json: current_user
  end

  def show
  end

  private

  def user_params
    # { user: { max_number: 50 } }
    params.require(:user).permit(:max_number)
  end
end
