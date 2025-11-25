class Tweet {
  final String emoji;
  final String userName;
  final String text;
  final String createdAt;
  Tweet(this.emoji, this.userName, this.text, this.createdAt);
}

final tweets = [
  Tweet('🦁', 'ルフィ', '海賊王におれはなる！', '2022/1/1'),
  Tweet('🐯', 'ゾロ', 'おれはもう！二度と敗けねェから！', '2022/1/2'),
  Tweet('🐱', 'ナミ', 'もう背中向けられないじゃないっ！', '2022/1/3'),
];