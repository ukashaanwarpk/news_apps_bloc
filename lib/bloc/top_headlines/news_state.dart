import 'package:equatable/equatable.dart';
import 'package:news_apps_bloc/data/response/api_response.dart';
import 'package:news_apps_bloc/model/category_news_model.dart';
import 'package:news_apps_bloc/model/top_headline_news_model.dart';

class NewsState extends Equatable {
  final ApiResponse<TopHeadlineNewsModel> apiResponseChannel;
  final ApiResponse<CategoryNewsModel> apiResponseCategory;

  final bool hasMore;
  final int page;

  final bool isFetchingMore;

  const NewsState({
    required this.apiResponseChannel,
    required this.apiResponseCategory,
    this.page = 1,
    this.hasMore = true,
    this.isFetchingMore = false,
  });

  @override
  List<Object?> get props => [
    apiResponseChannel,
    apiResponseCategory,
    hasMore,
    page,
    isFetchingMore,
  ];

  NewsState copyWith({
    ApiResponse<TopHeadlineNewsModel>? apiResponseChannel,
    ApiResponse<CategoryNewsModel>? apiResponseCategory,
    bool? hasMore,
    int? page,
    bool? isFetchingMore,
  }) {
    return NewsState(
      apiResponseChannel: apiResponseChannel ?? this.apiResponseChannel,
      apiResponseCategory: apiResponseCategory ?? this.apiResponseCategory,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}
