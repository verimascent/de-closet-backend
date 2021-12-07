class AddAvatarAndNicknameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar, :string
    add_column :users, :nickname, :string
  end
end
