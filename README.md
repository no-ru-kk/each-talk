# Each Talk	

## アプリケーション概要	
- 話を聞来たい人、話を聞いて欲しい人をマッチングするアプリケーション。話を聞いて欲しい人は時間と日程と価格を設定し、話す場を提供し、それを話を聞いて欲しい人が購入するというもの。

## URL	
  https://each-talk.herokuapp.com/

## テスト用アカウント
### Basic認証
- ID: admin
- pass: 1982


### 出品者用アカウント
- ID: sample@gmail.com
- pass:2021tech

### 購入者用
- ID: test@gmail.com
- pass: 2021tech

## 利用方法	
- 話を聞きたい人がルームを作り、それを話を聞いて欲しい人が購入し、マイページに表示される購入した履歴、出品した履歴からtalk-roomに入り、メッセージのやりとりをする。

## 目指した課題解決	
- 多くの人が自分の悩みを100％話ができる人がたくさんいるわけでなく、日々話せない悩みがあると感じている。そうした人たちが気軽に悩みを話せる場を作れないかと思い作成に至った。

## 洗い出した要件	
- ウィザード式ユーザー管理機能
- クレジットカード機能
- 出品機能
- room詳細機能
- 購入機能
- room作成機能
- 出品・購入roomの一覧表示機能
- メッセージ機能

## 実装予定の機能	
- スマートフォン用の表示機能。
- ユーザー評価機能。
- 要望投稿機能。
- ユーザー or room 検索機能。
- メッセージの即時に更新機能。

## データベース設計	ER図等を添付。
[![Image from Gyazo](https://i.gyazo.com/91d00ffed7565262fb4c55e021321ac4.png)](https://gyazo.com/91d00ffed7565262fb4c55e021321ac4)
## ローカルでの動作方法
- 新規登録からユーザーを登録。
- 話を聞きたい人はトークルームを作成。
- 話を聞いて欲しい人は出品されたトークルームの中から自分が話したいルームを購入。
- マイページから購入したルームに入り、メッセージを送り合う（出品した人は出品したルームからルームにはいる）


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