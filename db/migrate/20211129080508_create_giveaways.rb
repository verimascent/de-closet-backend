class CreateGiveaways < ActiveRecord::Migration[6.1]
  def change
    create_table :giveaways do |t|
      t.text :status
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
