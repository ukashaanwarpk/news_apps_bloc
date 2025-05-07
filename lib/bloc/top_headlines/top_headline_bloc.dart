import 'package:bloc/bloc.dart';
import 'package:news_apps_bloc/bloc/top_headlines/top_headline_event.dart';
import 'package:news_apps_bloc/data/response/api_response.dart';
import 'package:news_apps_bloc/repository/news_repository/news_repository.dart';
import 'top_headline_state.dart';

class TopHeadlineBloc extends Bloc<TopHeadlineEvent, TopHeadlineState> {
  NewsRepository newsRepository;
  TopHeadlineBloc({required this.newsRepository})
    : super(TopHeadlineState(apiResponse: ApiResponse.loading())) {
    on<GetTopHeadlineEvent>(_getTopHeadlineEvent);
  }

  void _getTopHeadlineEvent(
    GetTopHeadlineEvent event,
    Emitter<TopHeadlineState> emit,
  ) async {
    await newsRepository
        .getTopHeadlineNews(event.channelName)
        .then((value) {
          emit(TopHeadlineState(apiResponse: ApiResponse.completed(value)));
        })
        .onError((error, stackTrace) {
          emit(
            TopHeadlineState(apiResponse: ApiResponse.error(error.toString())),
          );
        });
  }
}
