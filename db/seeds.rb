# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

likes = ["日本", "日本文化", "お寺", "猫", "犬", "ペット", "教育", "子供", "スポーツ",
         "野球", "サッカー", "映画", "農業", "野菜", "食料", "宇宙"]
sentences = [
  "に興味のある方募集",
  "好き集まれ",
  "に憧れをいだいている方welcome!!",
  "が好きなエンジニア募集",
  "好き求む！！！",
  "のためにアプリを作ろう",
  "の未来を変えたい方募集",
  "で世界を変えたい人募集",
  "の未来を変えるアルバイト",
  "好きにとって最高のアルバイト",
  "に関われるアルバイト",
  "を変えるアルバイト募集！！",
  "に関わりたいエンジニア募集！！"
]
languages = [
  "HTML/CSS/JavaScipt",
  "Ruby on Rails",
  "Java",
  "PHP",
  "golang",
  "swift/kotlin",
  "swift",
  "kotlin",
  "C/C++"
]

sample_user = User.create!(name: "amorer", email: "amorer@amorer.com", password: "ilikeamorer")

u = []

15.times do |n|
  u.push User.create!(name: Faker::Name.name, email: "sample#{n}.exe@example.com", password: "password")
end

10.times do |n|
  like = likes.sample
  sentence = sentences.sample
  money_part = (12..20).to_a.sample
  plus = (0..10).to_a.sample
  min_amount = money_part * 100
  max_amount = min_amount + plus * 100
  language = languages.sample
  u[n].jobs.create!(
    title: like + sentence,
    reward_type: 1,
    reward_min_amount: min_amount,
    reward_max_amount: max_amount,
    explanation: "【仕事内容】
      ・#{language}を用いた開発、保守・運用をしていただきます。
      ・#{like}の未来を一緒に考えましょう。
      ・その他雑務もお願いすることがあります。\n
      【求める人物像】
      ・#{language}によるアプリ開発経験がある方。
      ・#{like}が好きな方。
      ・ビジョンに共感してくださる方。"
  )
end

mains = ["仕事", "手続き", "納品", "不具合", "課題", "課題解決", "問題発見"]
subjects = ["お願い申し上げ", "お願い", "お知らせ", "発注", "相談"]

10.times do |n|
  main = mains.sample
  subject = subjects.sample
  u[n].sending_messages.create!(
    title: "#{main}の#{subject}",
    receiver: sample_user,
    content: "こんにちは、#{sample_user.name}様。\n
      お世話になっております。\n
      本日の要件は#{main}の#{subject}です。詳細は下記の通りです。
      ・#{Faker::Lorem.words[0]}。
      ・#{Faker::Lorem.words[1]}をお願いします。
      ・#{Faker::Lorem.words[0]}が重要です。\n
      お手数ですが、よろしくお願いします。"
  )
end

like = likes.sample
sentence = sentences.sample
money_part = (12..25).to_a.sample
language = languages.sample
sample_job = sample_user.jobs.create!(
  title: like + sentence,
  reward_type: 1,
  reward_min_amount: 1500,
  reward_max_amount: 2000,
  explanation: "【仕事内容】
    ・#{language}を用いた開発、保守・運用をしていただきます。
    ・#{like}の未来を一緒に考えましょう。
    ・その他雑務もお願いすることがあります。\n
    【求める人物像】
    ・#{language}によるアプリ開発経験がある方。
    ・#{like}が好きな方。
    ・ビジョンに共感してくださる方。"
)

15.times do |n|
  u[n].entries.create!(job: sample_job)
end
