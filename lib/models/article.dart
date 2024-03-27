class Article {
  final int slipId;
  final String adviceContent;

  Article({required this.slipId, required this.adviceContent});

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      slipId: map['id'],
      adviceContent: map['advice'],
    );
  }
}
