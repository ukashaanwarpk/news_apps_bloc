import 'package:bloc/bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_event.dart';
import 'package:news_apps_bloc/data/response/api_response.dart';
import 'package:news_apps_bloc/repository/news_repository/news_repository.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository newsRepository;
  NewsBloc({required this.newsRepository})
    : super(
        NewsState(
          apiResponseChannel: ApiResponse.loading(),
          apiResponseCategory: ApiResponse.loading(),
        ),
      ) {
    on<GetTopHeadlineEvent>(_getTopHeadlineEvent);

    on<GetCategoryEvent>(_getCategoryEvent);
  }

  void _getTopHeadlineEvent(
    GetTopHeadlineEvent event,
    Emitter<NewsState> emit,
  ) async {
    await newsRepository
        .getTopHeadlineNews(event.channelName)
        .then((value) {
          emit(
            state.copyWith(apiResponseChannel: ApiResponse.completed(value)),
          );
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              apiResponseChannel: ApiResponse.error(error.toString()),
            ),
          );
        });
  }

  void _getCategoryEvent(
    GetCategoryEvent event,
    Emitter<NewsState> emit,
  ) async {
    await newsRepository
        .getCategoryNews(event.category)
        .then((value) {
          emit(
            state.copyWith(apiResponseCategory: ApiResponse.completed(value)),
          );
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              apiResponseCategory: ApiResponse.error(error.toString()),
            ),
          );
        });
  }
}
