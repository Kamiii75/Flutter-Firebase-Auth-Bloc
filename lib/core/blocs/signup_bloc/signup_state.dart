part of 'signup_bloc.dart';

 class SignupState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSucess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  const SignupState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSucess,
    required this.isFailure,
  });

  factory SignupState.initial() {
    return const SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSucess: false,
      isFailure: false,
    );
  }

  factory SignupState.loading() {
    return const SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSucess: false,
      isFailure: false,
    );
  }

  factory SignupState.failure() {
    return const SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSucess: false,
      isFailure: true,
    );
  }

  factory SignupState.success() {
    return const SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSucess: true,
      isFailure: false,
    );
  }

  SignupState update(
      { bool? isEmailValid,  bool? isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting:  false,
        isSucess:  false,
        isFailure:  false);
  }

  SignupState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSucess,
    bool? isFailure,
  }) {
    return SignupState(
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
