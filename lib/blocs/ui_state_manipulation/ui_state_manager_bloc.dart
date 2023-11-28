import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ui_state_manager_event.dart';
part 'ui_state_manager_state.dart';

class UiStateManagerBloc
    extends Bloc<UiStateManagerEvent, UiStateManagerState> {
  UiStateManagerBloc() : super(UiStateManagerInitial()) {
    on<UiStateManagerEvent>((event, emit) {});
    on<ObscureTextEvent>(
      (event, emit) {
        emit(ObscureTextState(event.isObscureTextEnable));
      },
    );
    on<WaterToggleButtonEvent>(
      (event, emit) {
        emit(WaterButtonState(event.isWaterButtonEnabled));
      },
    );
    on<BrushToggleButtonEvent>(
      (event, emit) {
        emit(BrushButtonState(event.isBrushButtonEnabled));
      },
    );
    on<StartStopButtonEvent>(
      (event, emit) {
        emit(StartStopButtonState(event.value));
      },
    );
    on<SliderEvent>(
      (event, emit) {
        emit(SliderState(event.sliderValue));
      },
    );
  }
}
