class ChangeTextToStringDetails < ActiveRecord::Migration[6.1]
  def change
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
    change_column :giveaways, :status, :string
    change_column :items, :item_type, :string
  end
end
