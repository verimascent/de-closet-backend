class Api::V1::GiveawaysController < Api::V1::BaseController
  # see this link for api tutorial, https://tomkadwill.com/rails-api-tutorial-part-1-create-rails-api-project-and-routing
  before_action :find_giveaway, only: %i[show]

  def index
    @giveaways = current_user.giveaways
  end

  def show
    # @items
  end

  def create
    @giveaway = Giveaway.new(giveaway_params)
    # @giveaway.item =
  end

  private

  def find_giveaway
    @giveaway = Giveaway.find(params[:id])
  end

  def giveaway_params
    params.require(:giveaway).permit(:status)
  end

  def items
    @items = Item.find(is_giveaway=true)
  end
end
