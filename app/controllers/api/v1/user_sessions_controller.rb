class Api::V1::UserSessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: [:create], raise: false
  skip_before_action :verify_authenticity_token
  def create
    user = get_user
    # generate the token for API authentication
    token = Tiddle.create_and_return_token(user, request)
    render json: {
      user: user,
      headers: {
        "X-USER-EMAIL"=> user.email,
        "X-USER-TOKEN"=> token
      }
    }
  end

  private

  def get_user
    open_id = fetch_wx_open_id(params[:code])["openid"]
    user = User.find_by(open_id: openid)
    if user.blank
      user = User.create!(
        open_id: open_id,
        email: "#{openid.downcase}_#{SecureRandom.hex(3)}@wx.com", # create some random email
        password: Devise.friendly_token(20)
      )
    end

    return user
  end

  def fetch_wx_open_id(code)
    # change accordingly if you're using ENV variables instead
    app_id = Rails.application.credentials.dig(:wechat, :app_id)
    app_secret = Rails.application.credentials.dig(:wechat, :app_secret)
    url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{app_id}&secret=#{app_secret}&js_code=#{code}&grant_type=authorization_code"

    response = RestClient.get(url)
    JSON.parse(response.body)
  end

  def render_error(object)
    render json: { status: 'fail', res: 'fail', errors: object.errors.full_messages }, status: 422
  end
end