class AppUrl {
  static const String apiKey = '25d769bc88954cca96717d7e1f00585c';

  static const String baseUrl = 'https://newsapi.org/v2/';

  static const String topHeadlines = 'top-headlines';
  static const String everything = 'everything';

  static const String sources = 'sources';
  static const String q = 'q';

  static const String pageSize = 'pagesize';

  static const int count = 10;

  static String getTopHeadlinesUrl(String channelName) {
    return '$baseUrl$topHeadlines?$sources=$channelName&apiKey=$apiKey';
  }

  static String getCategoryUrl(int page, String category) {
    return '$baseUrl$everything?$q=$category&$pageSize=$count&page=$page&apiKey=$apiKey';
  }
}
