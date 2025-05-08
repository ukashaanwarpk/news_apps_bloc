import 'package:equatable/equatable.dart';

class SliderState extends Equatable {
  final int sliderIndex;

  const SliderState({this.sliderIndex = 0});

  @override
  List<Object?> get props => [sliderIndex];

  SliderState copyWith({int? sliderIndex}) {
    return SliderState(sliderIndex: sliderIndex ?? this.sliderIndex);
  }
}
