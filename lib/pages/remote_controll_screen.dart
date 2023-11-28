import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:lionsbotremotecontroller/blocs/ui_state_manipulation/ui_state_manager_bloc.dart';

class RemoteControllScreen extends StatefulWidget {
  static const String routeName = '/remoteControllScreen';
  const RemoteControllScreen({super.key});

  @override
  State<RemoteControllScreen> createState() => _RemoteControllScreenState();
}

class _RemoteControllScreenState extends State<RemoteControllScreen> {
  bool _isWaterButtonEnabled = true;
  bool _isBrushButtonEnabled = false;
  String _startAndStopButtonValue = 'START';
  double _sliderValue = 10;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppbar(),
          body: _buildRemoteScreenContent(context),
        )),
        DraggableScrollableSheet(
          maxChildSize: 0.25,
          minChildSize: 0.085,
          initialChildSize: 0.085,
          builder: (context, scrollController) {
            return Material(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.blue.shade600,
                        Colors.blue.shade900,
                      ]),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 3,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              )),
                        ),
                        const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                        const Text(
                          'SETTINGS',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        BlocBuilder<UiStateManagerBloc, UiStateManagerState>(
                          buildWhen: (previous, current) {
                            if (current is SliderState) {
                              _sliderValue = current.sliderValue;
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            return SliderTheme(
                              data: SliderThemeData(
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 18),
                                trackHeight: 12,
                                tickMarkShape: SliderTickMarkShape.noTickMark,
                              ),
                              child: Slider(
                                max: 100,
                                min: 0,
                                divisions: 5,
                                inactiveColor: Colors.white,
                                thumbColor: Colors.white,
                                activeColor:
                                    const Color.fromARGB(255, 14, 107, 227),
                                value: _sliderValue,
                                onChanged: (value) {
                                  context
                                      .read<UiStateManagerBloc>()
                                      .add(SliderEvent(value));
                                },
                              ),
                            );
                          },
                        )
                      ]),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildRemoteScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 1,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white12,
                Colors.white24,
                Colors.white30,
                Colors.white60,
                Colors.white60,
                Colors.white30,
                Colors.white24,
                Colors.white12,
                Colors.transparent
              ],
            )),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: const TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.water_drop_outlined,
                          size: 18,
                          color: Colors.white,
                        )),
                        TextSpan(text: ' Water', style: TextStyle(fontSize: 18))
                      ]),
                    ),
                    BlocBuilder<UiStateManagerBloc, UiStateManagerState>(
                      buildWhen: (previous, current) {
                        if (current is WaterButtonState) {
                          _isWaterButtonEnabled = current.isWaterButtonEnabled;
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: FlutterSwitch(
                            height: 25,
                            width: 50,
                            toggleSize: 20,
                            inactiveSwitchBorder:
                                Border.all(width: 1, color: Colors.white),
                            activeSwitchBorder:
                                Border.all(width: 1, color: Colors.white),
                            activeColor: Colors.blue,
                            inactiveColor: Colors.transparent,
                            value: _isWaterButtonEnabled,
                            onToggle: (value) {
                              final bool toggledValue = !_isWaterButtonEnabled;
                              context
                                  .read<UiStateManagerBloc>()
                                  .add(WaterToggleButtonEvent(toggledValue));
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: const TextSpan(children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.wifi_tethering,
                            size: 18,
                            color: Colors.white,
                          )),
                          TextSpan(
                              text: ' Brush', style: TextStyle(fontSize: 18))
                        ]),
                      ),
                      BlocBuilder<UiStateManagerBloc, UiStateManagerState>(
                        buildWhen: (previous, current) {
                          if (current is BrushButtonState) {
                            _isBrushButtonEnabled =
                                current.isBrushButtonEnabled;
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: FlutterSwitch(
                              height: 25,
                              width: 50,
                              toggleSize: 20,
                              inactiveSwitchBorder:
                                  Border.all(width: 1, color: Colors.white),
                              activeSwitchBorder:
                                  Border.all(width: 1, color: Colors.white),
                              activeColor: Colors.blue,
                              inactiveColor: Colors.transparent,
                              value: _isBrushButtonEnabled,
                              onToggle: (value) {
                                final bool toggledValue =
                                    !_isBrushButtonEnabled;
                                context
                                    .read<UiStateManagerBloc>()
                                    .add(BrushToggleButtonEvent(toggledValue));
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 1,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white12,
                Colors.white24,
                Colors.white30,
                Colors.white60,
                Colors.white60,
                Colors.white30,
                Colors.white24,
                Colors.white12,
                Colors.transparent
              ],
            )),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.all(75),
            child: Joystick(
              period: const Duration(milliseconds: 30),
              stick: const JoyStickMoveableButton(),
              base: const JoyStickArrowKeys(),
              listener: (StickDragDetails details) {},
            ),
          ),
          BlocBuilder<UiStateManagerBloc, UiStateManagerState>(
            buildWhen: (previous, current) {
              if (current is StartStopButtonState) {
                _startAndStopButtonValue = current.value;
                return true;
              }
              return false;
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<UiStateManagerBloc>().add(StartStopButtonEvent(
                        _startAndStopButtonValue == 'START' ? 'STOP' : 'START',
                      ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _startAndStopButtonValue == 'START'
                          ? [
                              Colors.lightBlue,
                              const Color.fromARGB(255, 13, 92, 157)
                            ]
                          : [
                              Colors.red,
                              const Color.fromARGB(255, 230, 112, 112)
                            ],
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    _startAndStopButtonValue,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text('Remote Control'),
      titleTextStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}

class JoyStickMoveableButton extends StatelessWidget {
  const JoyStickMoveableButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              blurRadius: 35,
              color: Colors.black54,
              spreadRadius: 10,
              offset: Offset(0, 10))
        ],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blue,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade400,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + 2.5;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth - 5, trackHeight);
  }
}

class JoyStickArrowKeys extends StatelessWidget {
  final JoystickMode mode;

  const JoyStickArrowKeys({
    this.mode = JoystickMode.all,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 190,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: _JoystickBasePainter(mode),
      ),
    );
  }
}

class _JoystickBasePainter extends CustomPainter {
  _JoystickBasePainter(this.mode);

  final JoystickMode mode;

  final _borderPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 8
    ..style = PaintingStyle.stroke;
  final _centerPaint = Paint()
    ..color = Colors.indigo
    ..style = PaintingStyle.fill;
  final _linePaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 10
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.width / 2);
    final radius = size.width * 0.50;
    canvas.drawCircle(center, radius, _centerPaint);
    canvas.drawCircle(center, radius, _borderPaint);

    if (mode != JoystickMode.horizontal) {
      canvas.drawLine(Offset(center.dx - 10, center.dy - 125),
          Offset(center.dx, center.dy - 135), _linePaint);
      canvas.drawLine(Offset(center.dx + 10, center.dy - 125),
          Offset(center.dx, center.dy - 135), _linePaint);
      canvas.drawLine(Offset(center.dx - 10, center.dy - 125),
          Offset(center.dx + 10, center.dy - 125), _linePaint);

      canvas.drawLine(Offset(center.dx - 10, center.dy + 130),
          Offset(center.dx, center.dy + 140), _linePaint);
      canvas.drawLine(Offset(center.dx + 10, center.dy + 130),
          Offset(center.dx, center.dy + 140), _linePaint);
      canvas.drawLine(Offset(center.dx - 10, center.dy + 130),
          Offset(center.dx + 10, center.dy + 130), _linePaint);
    }

    if (mode != JoystickMode.vertical) {
      canvas.drawLine(Offset(center.dx - 130, center.dy - 10),
          Offset(center.dx - 140, center.dy), _linePaint);
      canvas.drawLine(Offset(center.dx - 130, center.dy + 10),
          Offset(center.dx - 140, center.dy), _linePaint);
      canvas.drawLine(Offset(center.dx - 130, center.dy - 10),
          Offset(center.dx - 130, center.dy + 10), _linePaint);

      canvas.drawLine(Offset(center.dx + 130, center.dy - 10),
          Offset(center.dx + 140, center.dy), _linePaint);
      canvas.drawLine(Offset(center.dx + 130, center.dy + 10),
          Offset(center.dx + 140, center.dy), _linePaint);
      canvas.drawLine(Offset(center.dx + 130, center.dy - 10),
          Offset(center.dx + 130, center.dy + 10), _linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
