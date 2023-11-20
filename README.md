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
- has_many :user_comments
- has_many :comments
- has_many :items
- has_many :user_item
- has_many :purchases

## commentsテーブル

| Column   | Type       | Options                        |
| ------   | ---------- | ------------------------------ |
|  text    | text       | null: false                    |
| user_id  |            | null: false  foreign_key: true |
| item_id  |            | null: false  foreign_key: true |

### Association
- has_many :users
- has_many :user_comments
- has_many :comments_item
- has_many :items

## user_commentsテーブル

| Column    | Type       | Options                        |
| ------    | ---------- | ------------------------------ |
| user_id   |            | null: false  foreign_key: true |
|comment_id |            | null: false  foreign_key: true |

### Association
- belongs_to :users
- belongs_to :comments

## itemsテーブル

| Column         | Type       | Options                        |
| ------         | ---------- | ------------------------------ |
|item_image      | references | null: false                    |
|item_name       | string     | null: false                    |
|item_explanation| string     | null: false                    |
|item_detail     | string     | null: false                    |
|item_delivery   | string     | null: false                    |
|item_price      | string     | null: false                    |
|user_id         | string     | null: false  foreign_key: true |


### Association
- has_many :comments_item
- has_many :comments
- has_many :users
- has_many :user_item
- has_one  :purchases

## comments_itemテーブル
| Column          | Type       | Options                        |
| ------          | ---------- | ------------------------------ |
|comments_id      |            | null: false  foreign_key: true |
|item_id          |            | null: false  foreign_key: true |

### Association
- belongs_to :comments
- belongs_to :items

## user_itemテーブル
| Column          | Type       | Options                        |
| ------          | ---------- | ------------------------------ |
|user_id          |            | null: false  foreign_key: true |
|item_id          |            | null: false foreign_key: true |

### Association
- belongs_to :group
- belongs_to :user

## purchasesテーブル
| Column          | Type       | Options                        |
| ------          | ---------- | ------------------------------ |
|user_id          |            | null: false  foreign_key: true |
|item_id          |            | null: false  foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items
- has_one    :articles

## shipping_addressesテーブル
| Column          | Type       | Options                        |
| ------          | ---------- | ------------------------------ |
|post_code        | string     | null: false                    |
|prefectures      | string     | null: false                    |
|municipalities   | string     | null: false                    |
|street_address   | string     | null: false                    |
|Building_name    | string     |                                |
|telephone_number | string     | null: false                    |
|purchases_id     | references | null: false  foreign_key: true |

### Association
- belongs_to :genre
