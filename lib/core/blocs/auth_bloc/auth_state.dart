part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  User firebaseUser;

  AuthSuccess({required this.firebaseUser});

  @override
  List<Object> get props => [firebaseUser];
}

class AuthFailure extends AuthState {}
