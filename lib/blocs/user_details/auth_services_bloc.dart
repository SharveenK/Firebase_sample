import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lionsbotremotecontroller/models/user_model.dart';
import 'package:lionsbotremotecontroller/repository/error_controller.dart';
import 'package:lionsbotremotecontroller/repository/user_repository.dart';

part 'auth_services_event.dart';
part 'auth_services_state.dart';

class AuthServicesBloc extends Bloc<AuthServicesEvent, AuthServicesState> {
  AuthServicesBloc(this.userRepository) : super(UserDetailsBlocInitial()) {
    on<AuthServicesEvent>((event, emit) {});
    on<UserLoginEvent>(
      (event, emit) async {
        try {
          emit(LoggedInLoadingState());
          final UserCredential userDetails = await userRepository.logIn(
              email: event.email, password: event.passWord);
          final UserModel userModel =
              await userRepository.getUserDetails(uid: userDetails.user!.uid);
          emit(LoggedInSuccessfullyState(
              loggedUserDetails: userModel, userCredential: userDetails));
        } on FirebaseException catch (e) {
          emit(LoggedInFailureState(ErrorController(
            error: e.code,
            message: e.message!,
            plugin: e.plugin,
          )));
        }
      },
    );
    on<SignUpUserRequestEvent>(
      (event, emit) async {
        try {
          emit(const SignUpLoadingState());
          await userRepository.signup(
              name: event.name, email: event.email, password: event.password);
          emit(const SignUpSuccessfullyState(true));
        } on FirebaseException catch (e) {
          emit(SignUpFailureState(
              error: ErrorController(
                  error: e.code, message: e.message!, plugin: e.plugin)));
        }
      },
    );
    on<LogOutRequestEvent>(
      (event, emit) async {
        try {
          await userRepository.logOut();
          emit(LogoutSuccessfullyState());
        } on FirebaseException catch (e) {
          emit(LogoutFailureState(ErrorController(
            error: e.code,
            message: e.message!,
            plugin: e.plugin,
          )));
        }
      },
    );
    on<PasswordResetRequestEvent>(
      (event, emit) async {
        try {
          emit(const PasswordResetSendingState());
          await userRepository.resetPassword(event.email);
          emit(const PasswordResetLinkSendSuccessfullyState());
        } on FirebaseException catch (e) {
          emit(PasswordResetLinkSendFailureState(ErrorController(
            error: e.code,
            message: e.message!,
            plugin: e.plugin,
          )));
        }
      },
    );
  }
  final UserRepository userRepository;
}
