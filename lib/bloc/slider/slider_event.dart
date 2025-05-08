import 'package:equatable/equatable.dart';

abstract class SliderEvent extends Equatable {}

class SliderIndexEvent extends SliderEvent {
  final int index;
  SliderIndexEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
