import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lionsbotremotecontroller/blocs/ui_state_manipulation/ui_state_manager_bloc.dart';
import 'package:lionsbotremotecontroller/blocs/user_details/auth_services_bloc.dart';

import 'package:lionsbotremotecontroller/common/common.dart';
import 'package:lionsbotremotecontroller/pages/home_screen.dart';
import 'package:lionsbotremotecontroller/pages/password_reset_screen.dart';
import 'package:lionsbotremotecontroller/pages/signup_screen.dart';

import '../constants/constants.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LogInScreen({
    super.key,
  });

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscureTextEnable = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              BlocBuilder<AuthServicesBloc, AuthServicesState>(
            buildWhen: (previous, current) {
              if (current is LoggedInFailureState) {
                errorDialog(context, current.error);
              }
              if (current is LoggedInSuccessfullyState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                        loggedUserDetails: current.loggedUserDetails),
                  ),
                );
              }
              return true;
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 18.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (state is LoggedInLoadingState) {
                            null;
                          } else if (_formKey.currentState!.validate()) {
                            context.read<AuthServicesBloc>().add(UserLoginEvent(
                                emailController.text, passwordController.text));
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                        child: Text(state is LoggedInLoadingState
                            ? 'Logging In'
                            : 'Login'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ));
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                        child: const Text('Not a member?   Register now'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          ),
          body: Stack(
            children: [
              Image.asset(
                'assets/background.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Log In',
                              style: headingTextStyle,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value)) {
                                return 'Enter valid email';
                              }

                              return null;
                            },
                          ),
                        ),
                        BlocBuilder<UiStateManagerBloc, UiStateManagerState>(
                          buildWhen: (previous, current) {
                            if (current is ObscureTextState) {
                              _isObscureTextEnable =
                                  current.isObscureTextEnable;
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: _isObscureTextEnable,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    suffixIcon: TextButton(
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      Colors.transparent),
                                        ),
                                        onPressed: () {
                                          final bool obscureEnable =
                                              !_isObscureTextEnable;
                                          context
                                              .read<UiStateManagerBloc>()
                                              .add(ObscureTextEvent(
                                                  isObscureTextEnable:
                                                      obscureEnable));
                                        },
                                        child: const Text(
                                          'Show',
                                          style: TextStyle(color: Colors.grey),
                                        ))),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (value.trim().length < 6) {
                                    return 'Password must be atleast 6 characters';
                                  }

                                  return null;
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PasswordResetScreen(),
                                  ));
                            },
                            child: Text(
                              'Forget your password?',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
