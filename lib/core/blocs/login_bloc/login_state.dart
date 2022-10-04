part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSucess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  const LoginState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSucess,
    required this.isFailure,
  });

  factory LoginState.initial() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSucess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSucess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSucess: false,
      isFailure: true,
    );
  }

  factory LoginState.sucess() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSucess: true,
      isFailure: false,
    );
  }

  LoginState update(
      { bool? isEmailValid,  bool? isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting:  false,
        isSucess:  false,
        isFailure:  false);
  }

  LoginState copyWith({
     bool? isEmailValid,
     bool? isPasswordValid,
     bool? isSubmitting,
     bool? isSucess,
     bool? isFailure,
  }) {
    return LoginState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSucess: isSucess ?? this.isSucess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
