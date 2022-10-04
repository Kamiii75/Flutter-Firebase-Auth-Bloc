part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AuthStarted extends AuthEvent{}
class AuthLoggedIn extends AuthEvent{}
class AuthLoggedOut extends AuthEvent{}
