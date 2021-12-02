class AddMaxNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :maxNumber, :integer, :default => 200
    #Ex:- :default =>''
  end
end
