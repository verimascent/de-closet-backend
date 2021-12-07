class ChangeDefaultValueForGivewayStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_default :giveaways, :status, 'pending'
  end
end
