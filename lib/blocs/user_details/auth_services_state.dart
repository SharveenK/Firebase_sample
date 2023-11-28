part of 'auth_services_bloc.dart';

class AuthServicesState extends Equatable {
  const AuthServicesState();

  @override
  List<Object> get props => [];
}

class UserDetailsBlocInitial extends AuthServicesState {}

class LoggedInLoadingState extends AuthServicesState {}

class LoggedInSuccessfullyState extends AuthServicesState {
  final UserModel loggedUserDetails;
  final UserCredential userCredential;

  const LoggedInSuccessfullyState(
      {required this.loggedUserDetails, required this.userCredential});
  @override
  List<Object> get props => [
        loggedUserDetails,
        userCredential,
      ];
}

class LoggedInFailureState extends AuthServicesState {
  final ErrorController error;

  const LoggedInFailureState(this.error);
  @override
  List<Object> get props => [
        error,
      ];
}

class SignUpLoadingState extends AuthServicesState {
  const SignUpLoadingState();
}

class SignUpSuccessfullyState extends AuthServicesState {
  final bool isAccountCreatedSuccesfully;

  const SignUpSuccessfullyState(this.isAccountCreatedSuccesfully);
  @override
  List<Object> get props => [
        isAccountCreatedSuccesfully,
      ];
}

class SignUpFailureState extends AuthServicesState {
  final ErrorController error;

  const SignUpFailureState({required this.error});
  @override
  List<Object> get props => [
        error,
      ];
}

class LogoutFailureState extends AuthServicesState {
  final ErrorController error;
  const LogoutFailureState(this.error);
  @override
  List<Object> get props => [
        error,
      ];
}

class LogoutSuccessfullyState extends AuthServicesState {}

class PasswordResetLinkSendSuccessfullyState extends AuthServicesState {
  const PasswordResetLinkSendSuccessfullyState();
}

class PasswordResetLinkSendFailureState extends AuthServicesState {
  final ErrorController error;

  const PasswordResetLinkSendFailureState(this.error);
  @override
  List<Object> get props => [
        error,
      ];
}

class PasswordResetSendingState extends AuthServicesState {
  const PasswordResetSendingState();
}
