part of 'auth_services_bloc.dart';

class AuthServicesEvent extends Equatable {
  const AuthServicesEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends AuthServicesEvent {
  final String email;
  final String passWord;

  const UserLoginEvent(this.email, this.passWord);
  @override
  List<Object> get props => [
        email,
        passWord,
      ];
}

class SignUpUserRequestEvent extends AuthServicesEvent {
  final String name;
  final String email;
  final String password;

  const SignUpUserRequestEvent(
      {required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [
        name,
        email,
        password,
      ];
}

class LogOutRequestEvent extends AuthServicesEvent {
  const LogOutRequestEvent();
}

class PasswordResetRequestEvent extends AuthServicesEvent {
  final String email;

  const PasswordResetRequestEvent(this.email);
  @override
  List<Object> get props => [
        email,
      ];
}
