import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lionsbotremotecontroller/blocs/ui_state_manipulation/ui_state_manager_bloc.dart';
import 'package:lionsbotremotecontroller/blocs/user_details/auth_services_bloc.dart';

import 'package:lionsbotremotecontroller/pages/home_screen.dart';
import 'package:lionsbotremotecontroller/pages/login_screen.dart';
import 'package:lionsbotremotecontroller/pages/password_reset_screen.dart';
import 'package:lionsbotremotecontroller/pages/profile_screen.dart';
import 'package:lionsbotremotecontroller/pages/remote_controll_screen.dart';
import 'package:lionsbotremotecontroller/pages/signup_screen.dart';
import 'package:lionsbotremotecontroller/repository/user_repository.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BotControllApp());
}

class BotControllApp extends StatelessWidget {
  const BotControllApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(FirebaseAuth.instance),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthServicesBloc(context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => UiStateManagerBloc(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LogInScreen(),
          routes: {
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            SignupScreen.routeName: (context) => const SignupScreen(),
            PasswordResetScreen.routeName: (context) =>
                const PasswordResetScreen(),
            RemoteControllScreen.routeName: (context) =>
                const RemoteControllScreen(),
          },
        ),
      ),
    );
  }
}
