import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthInitial()) {
    on<AuthStarted>((event, emit) async {
      final isSignedIn=await _userRepository.isSignedIn();

      if(isSignedIn){
        final firebaseUser=await _userRepository.getUser();
        emit(AuthSuccess(firebaseUser: firebaseUser));
      }else{
        emit(AuthFailure());
      }

    });
    on<AuthLoggedIn>((event, emit) async {
      final firebaseUser=await _userRepository.getUser();
      emit(AuthSuccess(firebaseUser: firebaseUser));

    });
    on<AuthLoggedOut>((event, emit) async {
      await _userRepository.signOut();
      emit(AuthFailure());

    });
  }


}
