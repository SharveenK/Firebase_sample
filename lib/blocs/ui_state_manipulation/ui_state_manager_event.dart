part of 'ui_state_manager_bloc.dart';

class UiStateManagerEvent extends Equatable {
  const UiStateManagerEvent();

  @override
  List<Object> get props => [];
}

class ObscureTextEvent extends UiStateManagerEvent {
  final bool isObscureTextEnable;

  const ObscureTextEvent({required this.isObscureTextEnable});
  @override
  List<Object> get props => [
        isObscureTextEnable,
      ];
}

class WaterToggleButtonEvent extends UiStateManagerEvent {
  final bool isWaterButtonEnabled;

  const WaterToggleButtonEvent(this.isWaterButtonEnabled);
  @override
  List<Object> get props => [
        isWaterButtonEnabled,
      ];
}

class BrushToggleButtonEvent extends UiStateManagerEvent {
  final bool isBrushButtonEnabled;

  const BrushToggleButtonEvent(this.isBrushButtonEnabled);
  @override
  List<Object> get props => [
        isBrushButtonEnabled,
      ];
}

class StartStopButtonEvent extends UiStateManagerEvent {
  final String value;

  const StartStopButtonEvent(this.value);
  @override
  List<Object> get props => [
        value,
      ];
}

class SliderEvent extends UiStateManagerEvent {
  final double sliderValue;

  const SliderEvent(this.sliderValue);
  @override
  List<Object> get props => [
        sliderValue,
      ];
}
