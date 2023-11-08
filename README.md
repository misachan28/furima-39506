## users

|Column         |Type  |Options                 |
|---------------|------|------------------------|
|nickname       |string|null: false,unique: true|
|email          |string|null: false,unique: true|
|password       |string|null: false,unique: true|
|first_name     |string|null: false             |
|last_name      |string|null: false             |
|first_name_kana|string|null: false             |
|last_name_kana |string|null: false             |
|birthday       |date  |null: false             |

### Association
has_many :items
has_many :purchases


## items

|Column       |Type      |Options                      |
|-------------|----------|-----------------------------|
|name         |string    |null: false                  |
|explanation  |text      |null: false                  |
|category     |integer   |null: false                  |
|condition    |integer   |null: false                  |
|postage      |integer   |null: false                  |
|region       |integer   |null: false                  |
|shipping_date|integer   |null: false                  |
|price        |integer   |null: false                  |
|user         |references|null: false,foreign_key: true|

### Association
belongs_to :user
has_one :purchases

## purchases

|Column|Type      |Options                      |
|------|----------|-----------------------------|
|user  |references|null: false,foreign_key: true|
|item  |references|null: false,foreign_key: true|


### Association
belongs_to :user
belongs_to :item

## mailings

|Column|Type|Options|
|------|----|-------|
|postcode     |string    |null: false                  |
|phone_number |string    |null: false                  |
|prefecture_id|integer   |null: false                  |
|city         |string    |null: false                  |
|block        |string    |null: false                  |
|building     |string    |null: false                  |
|purchase     |references|null: false,foreign_key: true|

### Association
belongs_to :purchase