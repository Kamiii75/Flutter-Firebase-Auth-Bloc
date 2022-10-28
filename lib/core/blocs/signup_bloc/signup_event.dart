part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
const SignupEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignupEmailChange extends SignupEvent {
  String email;

  SignupEmailChange({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class SignupPasswordChange extends SignupEvent {
  String password;

  SignupPasswordChange({required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [password];
}
class SignupWithCredentials extends SignupEvent {
  String email;
  String password;

  SignupWithCredentials({required this.password,required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}
