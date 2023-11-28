import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lionsbotremotecontroller/blocs/user_details/auth_services_bloc.dart';
import 'package:lionsbotremotecontroller/common/common.dart';
import 'package:lionsbotremotecontroller/models/user_model.dart';
import 'package:lionsbotremotecontroller/pages/login_screen.dart';

import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profileScreen';
  const ProfileScreen({super.key, this.userDetails});
  final UserModel? userDetails;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _backGroundImageHeight = 0;
  double _profilePictureHeight = 0;
  final LinearGradient _profileNameGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 28, 97, 235),
      Color.fromARGB(84, 22, 154, 255),
      Color.fromARGB(255, 191, 151, 240),
      Color.fromARGB(255, 245, 106, 103),
      Color.fromARGB(255, 146, 83, 38),
      Color.fromARGB(255, 238, 124, 164),
    ],
  );
  int __selectedIndex = 0;
  late UserModel _userDetails;
  @override
  void initState() {
    _userDetails = widget.userDetails!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _backGroundImageHeight = MediaQuery.of(context).size.height * 0.3;
    _profilePictureHeight = MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      body: BlocListener<AuthServicesBloc, AuthServicesState>(
        listener: (context, state) {
          if (state is LogoutSuccessfullyState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LogInScreen()),
                (route) => false);
          } else if (state is LogoutFailureState) {
            errorDialog(context, state.error);
          }
        },
        child: Column(
          children: [
            _buildAppBar(context),
            _buildProfileName(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ToggleSwitch(
                minWidth: MediaQuery.of(context).size.width / 2,
                cornerRadius: 20.0,
                activeBgColors: const [
                  [Colors.white],
                  [Colors.white]
                ],
                borderColor: [Colors.grey.shade300, Colors.grey.shade300],
                borderWidth: 1,
                activeFgColor: Colors.blue,
                inactiveBgColor: Colors.grey.shade100,
                inactiveFgColor: Colors.grey.shade500,
                initialLabelIndex: __selectedIndex,
                totalSwitches: 2,
                fontSize: 16,
                labels: const ['Points', 'Badges'],
                radiusStyle: true,
                onToggle: (index) {
                  __selectedIndex = index!;
                  setState(() {});
                },
              ),
            ),
            Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (__selectedIndex == 0) {
                        return ListTile(
                            isThreeLine: true,
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 30,
                                height: 30,
                                color: Colors.grey,
                              ),
                            ),
                            title: Text(
                              index % 3 == 1
                                  ? 'Successfull Operation '
                                  : index % 3 == 2
                                      ? 'Cleaning points'
                                      : 'Welcome reward',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('+${index + 1}Point  description'),
                            ),
                            trailing: const Text('8m ago',
                                style: TextStyle(color: Colors.grey)));
                      }
                      return ListTile(
                          isThreeLine: true,
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 30,
                              height: 30,
                              color: Colors.grey,
                            ),
                          ),
                          title: Text(
                            index % 3 == 1
                                ? 'Golden Batch '
                                : index % 3 == 2
                                    ? 'Silver Batch'
                                    : 'Bronze Batch',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('+${index + 1}Point  description'),
                          ),
                          trailing: const Text('8m ago',
                              style: TextStyle(color: Colors.grey)));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        indent: 72,
                        color: Colors.grey,
                      );
                    },
                    itemCount: __selectedIndex == 0
                        ? _userDetails.noOfPoints
                        : _userDetails.noOfBadges))
          ],
        ),
      ),
    );
  }

  Widget _buildProfileName() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => _profileNameGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(_userDetails.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                )),
          ),
          const SizedBox(height: 5),
          Text('Cleaning Hours: ${_userDetails.cleaningHours}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final double profilePictureOffset =
        _backGroundImageHeight - _profilePictureHeight / 1.25;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _getBackGroundImage(context),
        _getAppBarDetails(),
        _getProfilePicImag(profilePictureOffset)
      ],
    );
  }

  Positioned _getProfilePicImag(double profilePictureOffset) {
    return Positioned(
        top: profilePictureOffset,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 1)
            ],
          ),
          child: CircleAvatar(
            radius: _profilePictureHeight / 2,
            backgroundColor: Colors.white,
            child: CircleAvatar(
                radius: _profilePictureHeight / 2 - 5,
                backgroundImage: Image.asset(
                  'assets/download.png',
                  width: double.infinity,
                  height: _backGroundImageHeight,
                  fit: BoxFit.fill,
                ).image),
          ),
        ));
  }

  Widget _getAppBarDetails() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Home',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                context
                    .read<AuthServicesBloc>()
                    .add(const LogOutRequestEvent());
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getBackGroundImage(BuildContext context) {
    return Image.asset(
      'assets/background.png',
      height: _backGroundImageHeight,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
