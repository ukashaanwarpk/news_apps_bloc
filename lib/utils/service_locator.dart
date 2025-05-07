import 'package:get_it/get_it.dart';
import 'package:news_apps_bloc/repository/news_repository/https_new_repository.dart';
import 'package:news_apps_bloc/repository/news_repository/news_repository.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  void initializeLocator() {
    getIt.registerLazySingleton<NewsRepository>(() => HttpsNewsRepository());
  }
}
