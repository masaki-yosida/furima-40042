class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :item_name,         null: false
      t.text :item_explanation,    null: false
      t.integer :category_id,      null: false
      t.integer :situation_id,     null: false
      t.integer :postage_id,       null: false
      t.integer :prefecture_id,    null: false
      t.integer :deliveryday_id,   null: false
      t.integer :price,            null: false
      t.references :user,          null: false, foreign_key: true
      # 上記があるからこいつのファイル名を変えて先にUserが来るようにするデプロイ時にエラーが出る前の名前を探すから

      t.timestamps
    end
  end
end
