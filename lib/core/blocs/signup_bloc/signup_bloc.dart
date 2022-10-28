import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../constants/validators.dart';
import '../../repositories/user_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;

  SignupBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignupState.initial()) {




    on<SignupEmailChange>((event, emit) {
      state.update(isEmailValid: Validators.isEmailValid(event.email));
    });
    on<SignupPasswordChange>((event, emit) {
      state.update(isPasswordValid: Validators.isPasswordValid(event.password));
    });
    on<SignupWithCredentials>((event, emit) async {
      SignupState.loading();
      try {
        await _userRepository.signUp(
            event.email, event.password);
        SignupState.success();
      } catch (_) {
        SignupState.failure();
      }
    });
  }
}
