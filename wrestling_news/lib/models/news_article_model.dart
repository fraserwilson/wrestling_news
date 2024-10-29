class NewsArticleModel {
  final String articleTitle;
  final String articleDescription;
  final String articleLink;
  final String articleImage;

  // Constructor
  NewsArticleModel({
    required this.articleTitle,
    required this.articleDescription,
    required this.articleLink,
    required this.articleImage,
  });

  // Factory method to create a NewsArticle from JSON
  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      articleTitle: json['articleTitle'] ?? 'No title',
      articleDescription: json['articleDescription'] ?? 'No description',
      articleLink: json['articleLink'] ?? 'No link',
      articleImage: json['articleImage'] ?? 'No image url',
    );
  }

  // Method to convert a NewsArticle instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'articleTitle': articleTitle,
      'articleDescription': articleDescription,
      'articleLink': articleLink,
      'articleImage': articleImage,
    };
  }
}
