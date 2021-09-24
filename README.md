# テーブル設計

## usersテーブル

| Column             | Type   | Option                      |
| ------------------ | -----  | ------------------------    |
| email              | string | null: false, unique: true   |
| encrypted_password | string | null: false                 |
| nickname           | string | null: false                 |
| last_name          | string | null: false                 |
| first_name         | string | null: false                 |
| last_name_reading  | string | null: false                 |
| first_name_reading | string | null: false                 |
| birthday           | date   | null: false                 |

## Association

- has_many  :items
- has_many  :orders


## itemsテーブル

| Column             | Type      | Option                          |
| -----------------  | --------  | ------------------------------  |
| item_name          | string    | null: false                     |
| text               | text      | null: false                     |
| category_id        | integer   | null: false                     |
| status_id          | integer   | null: false                     |
| delivery_fee_id    | integer   | null: false                     |
| prefectures_id     | integer   | null: false                     |
| sipping_days_id    | integer   | null: false                     |
| price              | integer   | null: false                     |
| user               | reference | null: false, foreign_key: true  |

## Association

- belongs_to :user
- has_one    :order


## ordersテーブル

| Column             | Type      | Option                          |
| -----------------  | --------  | ------------------------------  |
| user               | reference | null: false, foreign_key: true  |
| item               | reference | null: false, foreign_key: true  |

## Association

- belongs_to  :item
- has_one     :address

## addressテーブル

| Column             | Type      | Option                          |
| ----------         | --------- | -----------------------         |
| postal_code        | string    | null: false                     |
| prefectures_id     | integer   | null: false                     |
| municipalities     | string    | null: false                     |
| block_number       | string    | null: false                     |
| building           | string    |                                 |
| phone_number       | string    | null: false                     |
| order              | reference | null: false, foreign_key: true  |


## Association

belongs_to :order
