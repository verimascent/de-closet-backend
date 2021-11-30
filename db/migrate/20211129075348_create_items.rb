class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :is_giveaway, :default => false
      #Ex:- :default =>''
      t.text :item_type
      t.text :remark

      t.timestamps
    end
  end
end
