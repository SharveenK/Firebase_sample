part of 'ui_state_manager_bloc.dart';

class UiStateManagerState extends Equatable {
  const UiStateManagerState();

  @override
  List<Object> get props => [];
}

class UiStateManagerInitial extends UiStateManagerState {}

class ObscureTextState extends UiStateManagerState {
  final bool isObscureTextEnable;

  const ObscureTextState(this.isObscureTextEnable);

  @override
  List<Object> get props => [
        isObscureTextEnable,
      ];
}

class WaterButtonState extends UiStateManagerState {
  final bool isWaterButtonEnabled;

  const WaterButtonState(this.isWaterButtonEnabled);
  @override
  List<Object> get props => [
        isWaterButtonEnabled,
      ];
}

class BrushButtonState extends UiStateManagerState {
  final bool isBrushButtonEnabled;

  const BrushButtonState(this.isBrushButtonEnabled);
  @override
  List<Object> get props => [
        isBrushButtonEnabled,
      ];
}

class StartStopButtonState extends UiStateManagerState {
  final String value;

  const StartStopButtonState(this.value);
  @override
  List<Object> get props => [
        value,
      ];
}

class SliderState extends UiStateManagerState {
  final double sliderValue;

  const SliderState(this.sliderValue);
  @override
  List<Object> get props => [
        sliderValue,
      ];
}
