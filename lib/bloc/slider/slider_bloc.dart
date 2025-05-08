import 'package:bloc/bloc.dart';
import 'package:news_apps_bloc/bloc/slider/slider_event.dart';
import 'package:news_apps_bloc/bloc/slider/slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  SliderBloc() : super(SliderState()) {
    on<SliderIndexEvent>(_sliderIndexEvent);
  }

  void _sliderIndexEvent(SliderIndexEvent event, Emitter<SliderState> emit) {
    emit(state.copyWith(sliderIndex: event.index));
  }
}
