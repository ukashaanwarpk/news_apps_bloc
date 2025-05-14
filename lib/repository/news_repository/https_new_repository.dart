import 'package:news_apps_bloc/config/app_url.dart';
import 'package:news_apps_bloc/model/category_news_model.dart';
import 'package:news_apps_bloc/model/top_headline_news_model.dart';
import '../../data/network/network_api_service.dart';
import 'news_repository.dart';

class HttpsNewsRepository extends NewsRepository {
  final _api = NetworkApiService();
  @override
  Future<CategoryNewsModel> getCategoryNews({
    required String category,
    required int page,
  }) async {
    final response = await _api.getApi(AppUrl.getCategoryUrl(page, category));
    return CategoryNewsModel.fromJson(response);
  }

  @override
  Future<TopHeadlineNewsModel> getTopHeadlineNews(String channelName) async {
    final response = await _api.getApi(AppUrl.getTopHeadlinesUrl(channelName));
    return TopHeadlineNewsModel.fromJson(response);
  }
}
