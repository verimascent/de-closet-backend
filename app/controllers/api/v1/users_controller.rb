class Api::V1::UsersController < Api::V1::BaseController
  def user
    current_user.update(maxNumber: params[:maxNumber])
    render ison: current_user
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:maxNumber)
  end
end
