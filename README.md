# テーブル設計

## users テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| name         | string | null: false |
| introduction | text   | null: false |
| email        | string | null: false |
| password     | string | null: false |

### Association

- has_many :rooms
- has_many :room_users
- has_many :trooms, through: troom_users
- has_many :messages
- has_one  :card, dependent: :destroy
- has_many :room_orders


## cards テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| card_token     | string     | null: false                    |
| customer_token | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user, optional: true


## rooms テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| image     |            |                                |
| name      | string     | null: false                    |
| explain   | text       | null: false                    |
| dayotw_id | integer    | null: false                    |
| rtime_id  | integer    | null: false                    |
| htime_id  | integer    | null: false                    |
| mtime_id  | integer    | null: false                    |
| price     | integer    | null: false                    |
| user      | references | null: false, foreign_key: true |

### Association

extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to :user
- has_one  :troom
- has_many :room_users
- belongs_to :dayotw
- belongs_to :rtime
- belongs_to :htime
- belongs_to :mtime
- has_one_attached :image


## room_orders テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | -------------------------------|
| user       | references | null: false, foreign_key: true |
| room       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :room


## trooms テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| room   | references | null: false, foreign_key: true |

### Association

- has_many :troom_users
- has_many :users, through: troom_users
- has_many :messages
- belongs_to :room


## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     |                                |
| troom   | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :troom
- belongs_to :user
- has_one_attached :image


## troom_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| troom  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :troom


## dayotw テーブル

### Association
include ActiveHash::Associations
- has_many :rooms


## rtime テーブル

### Association
include ActiveHash::Associations
- has_many :rooms


## htime テーブル

### Association
include ActiveHash::Associations
- has_many :rooms


## mtime テーブル

### Association
include ActiveHash::Associations
- has_many :rooms