import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lionsbotremotecontroller/blocs/user_details/auth_services_bloc.dart';
import 'package:lionsbotremotecontroller/common/common.dart';
import 'package:lionsbotremotecontroller/pages/login_screen.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});
  static const String routeName = '/passwordResetScreen';

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Center(
          child: Form(
            key: _formKey,
            child: BlocListener<AuthServicesBloc, AuthServicesState>(
              listener: (context, state) {
                if (state is PasswordResetLinkSendFailureState) {
                  errorDialog(context, state.error);
                }
                if (state is PasswordResetLinkSendSuccessfullyState) {
                  passwordResetLinkSend(context).then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LogInScreen()),
                        (route) => false);
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 25.0,
                      left: 25,
                    ),
                    child: Text(
                      'Enter you mail and we will send you a password reset link',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(
                                r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value)) {
                          return 'Enter valid email';
                        }

                        return null;
                      },
                    ),
                  ),
                  BlocBuilder<AuthServicesBloc, AuthServicesState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 35,
                          child: TextButton(
                            onPressed: () {
                              if (state is PasswordResetSendingState) {
                                null;
                              }
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthServicesBloc>().add(
                                    PasswordResetRequestEvent(
                                        _emailController.text));
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
                            child: Text(state is PasswordResetSendingState
                                ? 'Sending link'
                                : 'Reset password'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
