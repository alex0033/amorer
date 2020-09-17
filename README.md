# アモリル
-[アモリルとは](#アモリルとは)
-[サンプルユーザーでログイン](#サンプルユーザーでログイン)
-[技術](#技術)
-[機能一覧](#機能一覧)
-[感想](#感想)
-[開発期間(現時点)](#開発期間(現時点))

## アモリルとは
### 基本情報
サービス名：アモリル

由来：アルバイト ＋ リモート

URL：https://amorer.herokuapp.com/

#### テーマ
地方と東京などの中心地をリモート案件(アルバイト)でつなげる

#### アプリでやること
リモート案件に特化した求人を載せる（特にエンジニアの案件に着目）

#### 誰のどんな課題か（2つの例）
* プログラミングをしたい地方の学生。アルバイト先で、プログラミングできるところが見つからない。
* 都会の学生。地方で働きたいと考えている。このとき、学生をやりながら地方の企業で働くことが物理的にできない。

#### アプリへの思い
僕がプログラミングを始めた経緯は、「なんとなく」です。この「なんとなく」は、抽象的なので、具体的にしていきたいと考えていました。

しかし、その手段を当時の僕は持ち合わせていませんでした。どのようにして、このプログラミングへの「なんとなく」の興味を強くしていくか、分からなかったのです。

現在、その方法は、大きく二つだと考えています。１つは、自分でアプリを作ること。二つ目は、エンジニアとして働いてみること。

このアプリは、二つ目の「エンジニアとして働いてみる」をサポートするものです。そして、その環境として、地域にとらわれず、どこからでも参画可能であることを目指します。

## サンプルユーザーでログイン
* URL：https://amorer.herokuapp.com/
* メールアドレス: sample@sample.com
* パスワード： sample

## 技術
* ruby2.7.1
* ruby on rails 6.0.3
* docker
* CircleCI
* Heroku
* MySQL8.0 (ローカル環境)
* JawｓDB (本番環境)

## 機能一覧
### Userモデル
* ユーザー作成
* ユーザー編集
* ユーザー削除
* ユーザー詳細の表示
* ユーザーログイン
* ユーザーログアウト

### Jobモデル
* 求人作成
* 求人編集
* 求人削除
* 求人検索
* 求人検索による結果の一覧表示
* 求人の詳細表示

### Entryモデル
* 応募する(AJax)
* 応募取り消し(AJax)
* モーダルで応募者一覧表示

### Messageモデル
* メッセージ作成
* メッセージ一覧表示(受信したもののみ)
* メッセージ詳細表示
* 未読メッセージの色付け
* メッセージ受信の通知(５分ごと確認、、リロードが必要)

### その他
* 利用規約(サンプル)

## 感想
### 苦労した点
* どんなアプリを作るかのアイデア出し
* dockerとCircleCIを使った環境構築

### 良かった点
* TDD開発の良さを感じることができた(特にmodel spec, request spec)
* モデル → コントローラー → ビューの流れ(MVC)を実感しながら、アプリを作成できた。
* 自分の過去使ったコード(このアプリも含め)を再利用しながら、効率よく開発できた。

### 反省点
* 他人のコードを上手く使えなかった。(gemをもっと活用していくべし)例えば、「応募する」ボタンや、求人の作成などは、よく使われているため、gemがあってもおかしくない。これらを調べることを怠ってしまった。
* 問題点や改善点が多々ある。具体的には、後の「改善点」に記述。

### 改善点(少しずつ修正します)
* メールによる認証を行うことで、セキュリティ強化すること。
* 外部APIとの連携ログインによるユーザーフレンドリーな設計。
* メッセージという一方通行のコミュニケーションのみしか行えないこと。その改善策として、チャットを使えるシステム構築。
* 上記の代替案として、チャットを使えるツール(Slackなど)への招待機能追加。
* ユーザー同士の信任の仕組みが未整備。対策として、プロフィールに写真を登録する機能追加。Facebookなど他SNSの連携により、本人確認や、発信内容を周知できる仕組みづくり。

### このアプリの好きなところ
* 「アモリル」というアプリ名
* 「アモリル」のヘッダロゴの色
* メッセージ受信の通知(５分ごと確認、リロードが必要)

## 開発期間(現時点)
環境構築(Docker, CircleCIの設定) ＋ アイデア出し：１週間半

開発自体：１週間
