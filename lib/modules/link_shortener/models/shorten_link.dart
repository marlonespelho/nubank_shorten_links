class ShortenLink {
  ShortenLink({required this.alias, required this.originalUrl, required this.shortUrl});

  factory ShortenLink.fromJson(Map<String, dynamic> json) {
    final links = json['_links'] as Map<String, dynamic>? ?? {};
    return ShortenLink(
      alias: json['alias'] as String? ?? '',
      originalUrl: links['self'] as String? ?? '',
      shortUrl: links['short'] as String? ?? '',
    );
  }
  final String alias;
  final String originalUrl;
  final String shortUrl;
}
