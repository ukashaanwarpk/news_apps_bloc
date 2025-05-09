import 'package:equatable/equatable.dart';
import 'package:news_apps_bloc/data/response/api_response.dart';
import 'package:news_apps_bloc/model/top_headline_news_model.dart';

class TopHeadlineState extends Equatable {
  final ApiResponse<TopHeadlineNewsModel> apiResponse;

  final int sliderIndex;

  const TopHeadlineState({required this.apiResponse, this.sliderIndex = 0});

  @override
  List<Object?> get props => [apiResponse, sliderIndex];

  TopHeadlineState copyWith({
    ApiResponse<TopHeadlineNewsModel>? apiResponse,
    int? sliderIndex,
  }) {
    return TopHeadlineState(
      apiResponse: apiResponse ?? this.apiResponse,
      sliderIndex: sliderIndex ?? this.sliderIndex,
    );
  }
}
