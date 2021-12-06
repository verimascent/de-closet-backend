class ChangeMaxNumberOfUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :max_number, 0
  end
end
