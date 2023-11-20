# README

## usersテーブル

| Column             | Type       | Options                       |
| ------             | ---------- | ------------------------------|
|nickname            | string     | null: false                   |
| email              | string     | null: false   unique: true    |
|encrypted_password  | string     | null: false                   |
|name_kanji          | string     | null: false                   |
|name_kana           | string     | null: false                   |
| birthday           | string     | null: false                   |

### Association
- has_mane :user_comments
- has_mane :comments
- has_mane :items
- has_mane :user_item
- has_mane :purchases

## commentsテーブル

| Column   | Type       | Options                        |
| ------   | ---------- | ------------------------------ |
|  text    | text       | null: false                    |
| user_id  |            | null: false  foreign_key: true |
| item_id  |            | null: false  foreign_key: true |

### Association
- has_mane :users
- has_mane :user_comments
- has_mane :comments_item
- has_mane :items

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
- has_mane :comments_item
- has_mane :comments
- has_mane :users
- has_mane :user_item
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
- has_one    :Shipping _address

## Shipping _addressテーブル
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
- belongs_to :purchases
