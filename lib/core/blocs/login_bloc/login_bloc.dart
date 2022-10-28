import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_bloc/core/constants/validators.dart';

import '../../repositories/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial()) {


    on<LoginEmailChange>((event, emit) {
      state.update(isEmailValid: Validators.isEmailValid(event.email));
    });
    on<LoginPasswordChange>((event, emit) {
      state.update(isPasswordValid: Validators.isPasswordValid(event.password));
    });
    on<LoginWithCredentials>((event, emit) async {
      LoginState.loading();
      try {
        await _userRepository.signInWithCredentials(
            event.email, event.password);
        LoginState.success();
      } catch (_) {
        LoginState.failure();
      }
    });
  }
}
