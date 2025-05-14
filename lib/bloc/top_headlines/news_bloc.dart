import 'package:bloc/bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/news_event.dart';
import 'package:news_apps_bloc/data/response/api_response.dart';
import 'package:news_apps_bloc/model/category_news_model.dart';
import 'package:news_apps_bloc/repository/news_repository/news_repository.dart';
import 'package:news_apps_bloc/utils/enums.dart';
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
    on<GetMoreCategoryEvent>(_getMoreCategoryEvent);
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
        .getCategoryNews(category: event.category, page: state.page)
        .then((value) {
          emit(
            state.copyWith(
              apiResponseCategory: ApiResponse.completed(value),
              hasMore: value.articles!.isNotEmpty,
            ),
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

  void _getMoreCategoryEvent(
    GetMoreCategoryEvent event,
    Emitter<NewsState> emit,
  ) async {
    if (state.hasMore || state.apiResponseCategory.status == Status.loading) {
      return;
    }

    final nextPage = state.page + 1;

    try {
      final categoryNewsModel = await newsRepository.getCategoryNews(
        page: nextPage,
        category: event.category,
      );

      if (categoryNewsModel.articles!.isEmpty) {
        emit(state.copyWith(hasMore: false));
      } else {
        final currentData = state.apiResponseCategory.data;

        if (currentData != null) {
          final newData = [
            ...currentData.articles!,
            ...categoryNewsModel.articles!,
          ];

          emit(
            state.copyWith(
              apiResponseCategory: ApiResponse.completed(
                CategoryNewsModel(articles: newData),
              ),
              hasMore: true,
              page: nextPage,
            ),
          );
        }
      }
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseCategory: ApiResponse.error(e.toString()),
          hasMore: false,
        ),
      );
    }
  }
}
