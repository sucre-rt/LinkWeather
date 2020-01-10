# Link Weather
ポートフォリオとして作成しました。  
This is my portfolio.  

URL：http://18.177.170.210/  
**テストアカウント**  
Eメール　：　linkweather@test.com  
password：　111111

## Description
LinkWeatherは、リアルタイムの天気情報を取得することをコンセプトにしたお天気アプリケーションです。  
地名で検索することで、その場所の天気予報の表示はもちろん、その場所に実際にいる人の投稿を閲覧できるため、万が一天気予報が外れていてもその場にいるユーザーからリアルタイムの天気情報を取得することができます。  
※天気予報の検索は日本語のみ対応。地域も日本のみ対応しております。  
反対に、自分自身が情報の発信源にもなれます。あなたが今いる場所と天気を投稿して、他のユーザーにリアルタイムの天気を教えてあげてください。  
投稿に画像を添付することもできるので、綺麗な青空や夕日、虹などの写真が撮れた際にはみんなに自慢しちゃいましょう。  
Twitterからも同時に検索結果を取得し表示するため、アプリケーション内で情報が不足していてもリアルタイムの情報を得られます。  

LinkWeather is a weather application as the name suggests.  
You can search the weather forecast by place name.  
At the same time, you can get the weather information posted by other users who are there.  
Therefore, even if the weather forecast is off, it's OK!
Conversely, you can provide weather information.  
Please post your location and current weather and let others know the real-time weather.  
※Searchable only in Japanese and Japan area name.  
You can also attach images to your posts, so take photos of beautiful blue sky, sunsets, rainbows and more to show off everyone.  
Since information is also obtained from Twitter, sufficient information can be obtained even if information is insufficient in the application.  

## Features
- 天気予報の表示  
- 不快指数の計算  
- テキスト投稿・編集機能  
- 複数画像の投稿・編集機能  
- 非同期エリア登録機能  
- スマホに対するレスポンシブ対応

  - View weather forecast  
  - Calculation of discomfort index  
  - Posting function of weather information (multiple images / text)  
  - Area registration function  

## Demo
地域名検索による、天気予報・不快指数・アプリ内投稿・Twitter検索結果表示  
![linkweatherdemo](https://user-images.githubusercontent.com/56216409/71810685-418a8680-30b6-11ea-978e-510cc678d842.gif)  
画像投稿機能  
![postimages](https://user-images.githubusercontent.com/56216409/71811943-47ce3200-30b9-11ea-95d1-e2107a994fc5.gif)  
投稿済み画像編集機能  
![editimages](https://user-images.githubusercontent.com/56216409/71812176-db9ffe00-30b9-11ea-9ba1-c98f38be2e6f.gif) レスポンシブ対応
![responsive](https://user-images.githubusercontent.com/56216409/72152911-bc71db00-33ef-11ea-9d6b-3b3711cb77b1.gif)

## Intention
室内にいてすぐに外を確認できない状態にある時、今まさに雨が降っているのかどうか確認したいと思ったことが何度もあり、リアルタイムのその場の天気がすぐにわかるサービスがあればいいなと思ったため、作成しました。 

また、プログラミングスクールの最終課題であるチーム開発において、複数画像の取り扱いにつまずいている人が多く、私も挑戦してみたいと思いましたが、課題中は他の人がその箇所を担当したため、今回のアプリケーションに複数画像の投稿・編集機能を実装しました。  
  
I wanted a service that could tell you the weather at this moment.  
Because I often want to check if it is raining now when I stay indoors.

## environment
  Rails 5.2.4   
  ruby 2.5.1  
  Mysql  
  HTML  
  Sass  
  js / jQuery  
  AWS / EC2, S3 

**API**  
  Yahoo!developer / https://developer.yahoo.co.jp/  
  OpenWeather / https://openweathermap.org/  
  TwitterDeveloper / https://developer.twitter.com/  

## DB
<img width="679" alt="LinkWeatherER" src="https://user-images.githubusercontent.com/56216409/71810687-43ece080-30b6-11ea-85f9-f904e8f3ee79.png">

