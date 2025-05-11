import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class GetTopHeadlineEvent extends NewsEvent {
  final String channelName;
  GetTopHeadlineEvent({required this.channelName});
  @override
  List<Object?> get props => [channelName];
}

class GetCategoryEvent extends NewsEvent {
  final String category;
  GetCategoryEvent({required this.category});
  @override
  List<Object?> get props => [category];
}
