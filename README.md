# テーブル設計

## users テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| name         | string | null: false |
| introduction | text   | null: false |
| email        | string | null: false |
| password     | string | null: false |

### Association

- has_many :room_users
- has_many :rooms, through: room_users
- has_many :messages
- has_one  :card, dependent: :destroy
- has_many :records


## cards テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| card_token     | string     | null: false                    |
| customer_token | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user, optional: true


## rooms テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| image    |            |                                |
| name     | string     | null: false                    |
| explain  | text       | null: false                    |
| rtime_id | integer    | null: false                    |
| price    | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### Association

extend ActiveHash::Associations::ActiveRecordExtensions
- has_many :room_users
- has_many :users, through: room_users
- has_many :messages
- has_one_attached :image
- belongs_to :rtime


## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user


## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user


## records テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | -------------------------------|
| user       | references | null: false, foreign_key: true |
| room       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :room


## rtime テーブル

### Association
include ActiveHash::Associations
- has_many :rooms