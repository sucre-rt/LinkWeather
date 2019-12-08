# DB設計

##  usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|image|string||
|my_area|string||
|password|string|null: false|
### Association
- has_many :sub_areas
- has_many :valuers, class_name: 'Trust', foreign_key: 'valuer_id'
- has_many :good_users, class_name: 'Trust', foreign_key: 'good_user_id'
- has_many :tweets

## Sub_areasテーブル
|Column|Type|Options|
|------|----|-------|
|area|string||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## Trustsテーブル
|Column|Type|Options|
|------|----|-------|
|valuer|references|null: false, foreign_key: { to_table: :users }|
|good_user|references|null: false, foreign_key: { to_table: :users }|
### Association
- belongs_to :valuer, class_name: 'User', foreign_key: 'valuer_id'
- belongs_to :good_user, class_name: 'User', foreign_key: 'good_user_id'

## Tweetsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|user|references|null: false, foreign_key: true|
### Assosiation
- belongs_to :user

## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string||
|tweet|references|null: false, foreign_key: true|