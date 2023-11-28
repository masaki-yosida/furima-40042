class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string     :title        , null: false
      t.text       :text         , null: false
      t.integer    :category_id     , null: false
      t.integer    :situation_id     , null: false
      t.integer    :postage_id     , null: false
      t.integer    :prefecture_id     , null: false
      t.integer    :deliveryday_id     , null: false

      t.timestamps
    end
  end
end
