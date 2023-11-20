# README

## usersテーブル

| Column             | Type       | Options                       |
| ------             | ---------- | ------------------------------|
|nickname            | string     | null: false                   |
| email              | string     | null: false   unique: true    |
|encrypted_password  | string     | null: false                   |
|firstname_kanji     | string     | null: false                   |
|lastname_kanji      | string     | null: false                   |
|firstname_kana      | string     | null: false                   |
|lastname_kana       | string     | null: false                   |
| birthday           | date       | null: false                   |

### Association
- has_many :comments
- has_many :items
- has_many :purchases

## commentsテーブル

| Column| Type       | Options                        |
| ------| ---------- | ------------------------------ |
|  text | text       | null: false                    |
| user  |references  | null: false  foreign_key: true |
| item  |references  | null: false  foreign_key: true |

### Association
- has_many :users
- has_many :items

## itemsテーブル

| Column            | Type       | Options                        |
| ------            | ---------- | ------------------------------ |
|item_name          | string     | null: false                    |
|item_explanation   | text       | null: false                    |
|category_id        | integer    | null: false                    |
|situation_id       | integer    | null: false                    |
|postage_id         | integer    | null: false                    |
|prefecture_id      | integer    | null: false                    |
|deliveryday_id    | integer    | null: false                    |
|price              | integer    | null: false                    |
|user               | references | null: false  foreign_key: true |


### Association
- has_many :comments
- belongs_to :user
- has_one  :shipping_address

## purchasesテーブル
| Column  | Type       | Options                        |
| ------  | ---------- | ------------------------------ |
|user     | references | null: false  foreign_key: true |
|item     | references | null: false  foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :shipping_address

## shipping_addressesテーブル
| Column          | Type       | Options                        |
| ------          | ---------- | ------------------------------ |
|post_code        | string     | null: false                    |
|prefecture_id    | integer    | null: false                    |
|municipalities   | string     | null: false                    |
|street_address   | string     | null: false                    |
|building_name    | string     |                                |
|telephone_number | string     | null: false                    |
|purchase         | references | null: false  foreign_key: true |

### Association
- belongs_to :purchase
