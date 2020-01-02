# Link Weather

## Overview
A weather application based on the concept of obtaining real-time weather information.  
リアルタイムの天気情報の取得をコンセプトにしたお天気アプリケーションです。

## Description
LinkWeather is, as the name suggests, a weather application.  
You can search the weather forecast by place name.  
At the same time, you can view the weather information posted by those who are there.  
Therefore, even if the weather forecast is off, it's OK!  
Conversely, you can provide weather information.  
Please post your location and current weather and let others know the real-time weather.   
※Searchable only in Japanese and Japan area name.   
You can also attach images to your posts, so take photos of beautiful blue sky, sunsets, rainbows and more to show off everyone.  
Since information is also obtained from Twitter, sufficient information can be obtained even if information is insufficient in the application.

LinkWeatherはその名の通り、お天気アプリケーションです。  
地名で検索することで、その場所の天気予報の表示はもちろん、その場所に実際にいる人の投稿を閲覧できるため、万が一天気予報が外れていてもその場にいる人からリアルタイムの天気情報を取得することができます。  
※天気予報の検索は日本語のみ対応。地域も日本のみ対応しております。  
反対に、自分自身が情報の発信源にもなれます。あなたが今いる場所と天気を投稿して、他のユーザーにリアルタイムの天気を教えてあげてください。  
投稿に画像を添付することもできるので、綺麗な青空や夕日、虹などの写真が撮れた際にはみんなに自慢しちゃいましょう。  
Twitterからも同時に検索結果を取得し表示するため、アプリケーション内で情報が不足していてもリアルタイムの情報を得られます。  

## Features
・View weather forecast  
・Calculation of discomfort index  
・Posting function of weather information (multiple images / text)  
・Area registration function  

・天気予報の表示  
・不快指数の計算  
・投稿機能（複数画像・文章）  
・エリア登録機能  

## environment
  Rails 5.2.4   
  ruby 2.5.1  
  Mysql  

API  
  Yahoo!developer / https://developer.yahoo.co.jp/  
  OpenWeather / https://openweathermap.org/  
  TwitterDeveloper / https://developer.twitter.com/  

## Installation
$ git clone https://github.com/sucre-rt/LinkWeather.git  
$ cd LinkWeather  
$ bundle install  
$ bundle ex rake db:create  
$ bundle ex rake db:migrate  
$ rails s