import 'package:equatable/equatable.dart';
import 'package:news_apps_bloc/data/response/api_response.dart';
import 'package:news_apps_bloc/model/top_headline_news_model.dart';

class TopHeadlineState extends Equatable {
  final ApiResponse<TopHeadlineNewsModel> apiResponse;

  const TopHeadlineState({required this.apiResponse});

  @override
  List<Object?> get props => [apiResponse];

  TopHeadlineState copyWith(ApiResponse<TopHeadlineNewsModel>? apiResponse) {
    return TopHeadlineState(apiResponse: apiResponse ?? this.apiResponse);
  }
}
