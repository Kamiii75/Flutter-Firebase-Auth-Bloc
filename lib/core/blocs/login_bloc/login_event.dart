part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEmailChange extends LoginEvent {
  String email;

  LoginEmailChange({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class LoginPasswordChange extends LoginEvent {
  String password;

  LoginPasswordChange({required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [password];
}
class LoginWithCredentials extends LoginEvent {
  String email;
  String password;

  LoginWithCredentials({required this.password,required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}
