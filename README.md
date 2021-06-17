# Each Talk	
[![Image from Gyazo](https://i.gyazo.com/cec6870e0d2cbf74d781abb4a6250da3.jpg)](https://gyazo.com/cec6870e0d2cbf74d781abb4a6250da3)


## アプリケーション概要	
- 人事時代メンタルを病んでしまう人が多くどうにかできないかと考えていたが、カウンセリングは価格も高く敷居も高いため、気軽に自分の話をきいてもらえるような場所があればと考えていた。それを踏まえ今回簡単に話ができる場ということをコンセプトにアプリケーション開発を行った。
Each Talkは話を聞きたい人、話を聞いて欲しい人をマッチングするアプリケーション。話を聞いて欲しい人は時間と日程と価格を設定し、話す場を提供し、それを話を聞いて欲しい人が購入するというもの。

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
| 機能          | 目的    | 詳細         | ストーリー(ユースケース) |
| ------------ | ------- | ----------- | -------------------- |
| ウィザード式ユーザー管理機能 | ウィザードを利用し、購入時にいちいちクレジットカード情報を入れなくとも済むようにするため。 | ウイザード形式のユーザー管理機能にクレジットカード機能導入し、マイページで表示できるようにする。 |	ユーザーアカウントの登録方法ユーザー情報を登録後、クレジットカード機能を登録する。 |
| 出品機能 | 話すためのトークルームを出品する必要があるため。 | トークルームの名前、説明、曜日、始める時間、何分話すのか、それがいくらなのかを設定し、出品することができるようにする。 |トップ画面のroom作成ボタンから、出品ページにいき、名前、説明、曜日、始める時間、何分話すのか、その価格はいくらなのか、を設定し出品する。|
| room詳細機能 | 出品したルームの詳細を表示し、編集、削除をできるようにするため。| 出品したルームの詳細を表示し、編集、削除することをできるようにするため。 |トップ画面に表示されている一覧の写真をクリックするとroomの詳細画面に行くことができる。|
| 購入機能 | PAY.JPを利用したroom購入機能の実装方法を習得するため。 | 購入したいroomをクリックしたら購入が完了する |roomは数点出品されていることが前提。「購入ボタン」をクリックしたら、DB及びPAY.JPサイトに購入した商品情報が更新される。購入済みの商品は、「購入ボタン」を押せないようにする。作成しているものであれば、編集・削除、がうつり、そのほかのユーザーであれば、購入が表示されている。|
| room作成機能 | 購入と同時にトークルームが作成され、購入者と作成者をユーザーとして登録するため。 | 購入と同時に、troomと中間テーブルに保存される、マイページに飛ぶようにする。 |購入ボタンを押す。|
| 出品・購入roomの一覧表示機能 | マイページに出品したroomと購入したroomを表示させ、そこからトークルームに入らせるため。 | ユーザーによって違う購入と出品情報をそれぞれマイページに表示させる。 |購入後に送られるマイページに購入したroomが表示される。出品者も出品後にマイページで出品済みのroomを確認できる。購入履歴がないものについては、クリックするとマイページに飛ぶようにする。|
| メッセージ機能 | 購入したまたは出品したroomから入り、トークルーム(troom)でメッセージのやりとりができるようにするため。| 日本時間で表示され、互いの名前が表示され、画像も添付することができるようにする。 |購入者は購入roomから、出品者は出品roomからそれぞれ入り、メッセージのやりとりができる。マイページボタンから戻ることができ、メッセージのやりとりは保存され、あとからでも確認することができる。|
| メッセージの即時更新機能 | トークルームでのやりとりに時間がかからないようにするため。 | メッセージの即時更新機能を実装し、ルーム内のコメントのやりとりをスムーズにさせる。 |メッセージのやり取りの際に、いちいち保存に時間がかからずスムーズに行うことができる。|
| スマートフォン用の表示機能 | スマートフォンで利用する際は、スマートフォン用のビューで表示できるようにするため。 | スマートフォン用のビューで表示できるようにする。 |スマートフォンでサイトに入ると、スマートフォン用のビューに変わり表示される。|
| ユーザー検索 | 今どんなユーザーが出品しているのか？検索出来るようにするため。 | 現在出品されているroomを条件によって検索することができる。 |roomは数点出品されていることが前提。room名/時間/価格/値段などの検索条件を指定する欄を儲ける。条件に該当する商品のroom結果のページで表示する。|
| ユーザー評価機能 | お気に入りのユーザーに評価をつけることができるようにするため。 | メッセージを完了したユーザーに限り、一度だけ評価をすることができる。|メッセージルームにおいて、ユーザー評価の星を表示し、それを押すと評価がカウントされるようにする。|
| 要望投稿機能 | 出品者もしくは登録者に対しての利用時の不満を伝え、サービスの工場をはかるため。 | トップページにフォームを作り、メッセージを送信できるようにする。 |seedを使い、管理者権限をユーザーに付与し、その人のみ閲覧できるページを作る|

## 実装済の機能	
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

## DEMO
- ウィザード式ユーザー管理機能
- クレジットカード機能
[![Image from Gyazo](https://i.gyazo.com/93316895b427b3facc717028a69e0bfb.gif)](https://gyazo.com/93316895b427b3facc717028a69e0bfb)
[![Image from Gyazo](https://i.gyazo.com/ff9f5911bf5653410183fddaec652885.gif)](https://gyazo.com/ff9f5911bf5653410183fddaec652885)
- 出品機能
[![Image from Gyazo](https://i.gyazo.com/3e1947dcaad11c8be1ab55b30223bd63.gif)](https://gyazo.com/3e1947dcaad11c8be1ab55b30223bd63)
- room詳細機能
[![Image from Gyazo](https://i.gyazo.com/2a4448bb7d833ba80826bc0ec1c33ede.gif)](https://gyazo.com/2a4448bb7d833ba80826bc0ec1c33ede)
- 購入機能
- room作成機能
- 出品・購入roomの一覧表示機能
[![Image from Gyazo](https://i.gyazo.com/b5f10f673db5d361712e1e041d4be530.gif)](https://gyazo.com/b5f10f673db5d361712e1e041d4be530)
- メッセージ機能
[![Image from Gyazo](https://i.gyazo.com/fa29d58acbc2114eda205ab758197909.gif)](https://gyazo.com/fa29d58acbc2114eda205ab758197909)

## データベース設計	ER図
[![Image from Gyazo](https://i.gyazo.com/91d00ffed7565262fb4c55e021321ac4.png)](https://gyazo.com/91d00ffed7565262fb4c55e021321ac4)

## 工夫したところ
- 外部APIであるPayjpをウィザード式でユーザー登録をできるように行った。
- 購入すると同時にトークルームを作成するため、購入とルーム作成を同時処理を行えるようにした。
- マイページに購入したroomの履歴、出品したものがそのユーザーに紐づいて表示できるようにした。

## ローカルでの動作方法
- % git clone https://github.com/no-ru-kk/each-talk.git  
- % cd each-talk
- % bundle install
- % rails db:create
- % rails db:migrate
- % yarn install
- % rails s
→　http://localhost:3000


## 開発環境
- フロントエンド：HTML5/CSS(Bootstrap)/JavaScript/jQuery/Ajax
- バックエンド：Ruby on Rails(6.0.0)/Ruby(2.6.5)/JavaScript
- テスト：RSpec(結合テスについては外部API実装によるmockの関係でまだ途中です)
- Linter：Rubocop
- データベース：MySQL(5.6.50)/Sequel Pro
- インフラ：Heroku
- タスク管理：GitHub/Trello


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