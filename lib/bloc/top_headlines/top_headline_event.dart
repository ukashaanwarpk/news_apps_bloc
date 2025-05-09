import 'package:equatable/equatable.dart';

abstract class TopHeadlineEvent extends Equatable {}

class GetTopHeadlineEvent extends TopHeadlineEvent {
  final String channelName;
  GetTopHeadlineEvent({required this.channelName});
  @override
  List<Object?> get props => [channelName];
}

class SliderIndexEvent extends TopHeadlineEvent {
  final int index;
  SliderIndexEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
