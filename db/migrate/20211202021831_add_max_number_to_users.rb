class AddMaxNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :maxNumber, :integer
  end
end
