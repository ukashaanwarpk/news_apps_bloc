import 'package:news_apps_bloc/model/top_headline_news_model.dart';
import '../../model/category_news_model.dart';

abstract class NewsRepository {
  Future<TopHeadlineNewsModel> getTopHeadlineNews(String channelName);
  Future<CategoryNewsModel> getCategoryNews(String category);
}
