# RegionInterceptor

地域系(Region)のデータを用意してあげることで、開発成長直・曲線の切片(Interceptor)となるgem。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'region_interceptor', :git => 'git@github.com:PORT-INC/region_interceptor.git'
```

And then execute:

    $ bundle

## Usage
### seed投入時
下記コマンドで必要なファイルを生成する。

    $ bundle exec rails g region_interceptor:install
    
生成されるファイル
- model
    - region.rb
    - prefecture.rb
    - area.rb
    - city.rb
    
- migration
    - 上記4ファイルのmigrationファイル
    
- seedデータ（csv）
    - region, prefecture, area, cityそれぞれのseedデータ
    

migrationファイルを適宜修正した後

    $ bundle exec rails db:migrate
    
して

    $ bundle exec rails region_interceptor:seed
    
でデータがインポートされる

### データ更新時
下記コマンドで必要なファイルの更新。

    $ bundle exec rails g region_interceptor:update
    
後に下記コマンドデータの更新。
    
    $ bundle exec rails region_interceptor:update
## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
