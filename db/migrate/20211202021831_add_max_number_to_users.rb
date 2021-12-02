class AddMaxNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :max_number, :integer, :default => 200
    #Ex:- :default =>''
  end
end
