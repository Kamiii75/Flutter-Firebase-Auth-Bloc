class Validators{


  static final RegExp _emailValid = RegExp(r"^[a-zA-Z0-9_.]+@(gmail|yahoo|outlook|apple|hotmail|mailbox|aim).com$");


  static bool isEmailValid(String email){
    return _emailValid.hasMatch(email);
  }
  static bool isPasswordValid(String pass){
    return pass.length>=6;
  }
}