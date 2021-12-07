class ChangeDefaultValueAgainForGivewayStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_default :giveaways, :status, 'free'
  end
end
