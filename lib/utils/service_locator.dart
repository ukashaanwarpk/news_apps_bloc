import 'package:get_it/get_it.dart';
import 'package:news_apps_bloc/repository/news_repository/https_new_repository.dart';

class ServiceLocator {
  static void initializeLocator() {
    GetIt getIt = GetIt.instance;
    getIt.registerLazySingleton<HttpsNewsRepository>(
      () => HttpsNewsRepository(),
    );
  }
}
