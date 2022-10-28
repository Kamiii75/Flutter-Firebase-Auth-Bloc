import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../../core/blocs/signup_bloc/signup_bloc.dart';
import '../../../../core/repositories/user_repository.dart';
import '../../../widgets/already_have_an_account_acheck.dart';
import '../../../widgets/or_divider.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/rounded_input_field.dart';
import '../../../widgets/rounded_password_field.dart';
import '../../../widgets/social_icon.dart';
import 'sign_up_screen_view_model.dart';

class SignUpScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const SignUpScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(context: context),
      child:
      Consumer<SignUpProvider>(
        builder: (context, register, child) {
          return BlocListener<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state.isFailure) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                      SnackBar(content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:const  [
                          Text('Failure...'),
                          Icon(Icons.warning_amber),
                          //   CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                        ],
                      ))
                  );
              }
              if (state.isSubmitting) {    ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:const  [
                        Text('Submitting...'),
                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                      ],
                    ))
                );}
              if (state.isSucess) {    ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:const  [
                        Text('Success'),
                        Icon(Icons.done_all),
                        //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                      ],
                    ))
                );}
            },
            child: SizedBox(
              height: size.height,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        SizedBox(height: size.height * 0.03),
                        RoundedInputField(
                          controller: register.nameController,
                          hintText: "Name",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          controller: register.emailController,
                          icon: Icons.mail,
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress,
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          controller: register.phoneController,
                          icon: Icons.phone,
                          textInputType: TextInputType.phone,
                          hintText: "Phone",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          controller: register.addressController,
                          icon: Icons.add_location_alt_sharp,
                          hintText: "Address",
                          textInputType: TextInputType.streetAddress,
                          onChanged: (value) {},
                        ),
                        RoundedPasswordField(
                          controller: register.passController,
                          onChanged: (value) {},
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: CheckboxListTile(
                            title: const Text("Remember Me"),
                            value: register.rememberMe,
                            onChanged: (newValue) {
                              register.setRememberMe(newValue!);
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                        RoundedButton(
                          text: "Sign Up",
                          press: () {
                            EasyLoading.show(status: 'loading...');
                            //
                            // if (emailValidatorRegExp
                            //     .hasMatch(register.emailController.text)) {
                            //   Future<void> isLogin = Auth.funcSignUp(
                            //       register.nameController.text,
                            //       register.phoneController.text,
                            //       register.emailController.text,
                            //       register.passController.text);
                            //   isLogin.whenComplete(() {
                            //     String uid ="";
                            //     try {
                            //       uid= FirebaseAuth.instance.currentUser!.uid;
                            //     } on Exception catch (_) {
                            //       EasyLoading.dismiss();
                            //       register.setEmailClear();
                            //     }catch (_) {
                            //       EasyLoading.dismiss();
                            //       register.setEmailClear();
                            //     }
                            //
                            //
                            //     if (uid.isEmpty) {
                            //       EasyLoading.dismiss();
                            //       register.setEmailClear();
                            //     } else {
                            //       Map<String, Object> userMap = {
                            //         "name": register.nameController.text,
                            //         "email": register.emailController.text,
                            //         "phone": register.phoneController.text,
                            //         "address": register.addressController.text,
                            //         "wage": register.wageController.text,
                            //         "note": register.noteController.text,
                            //         "type": register.type,
                            //         "availableSunday": false,
                            //         "showProfile": true,
                            //         "lat": register.position.latitude.toString(),
                            //         "long": register.position.longitude.toString(),
                            //         "skillNo":
                            //         register.dropDownItemsIds[register.dropDownVal],
                            //         "skill": register.dropDownItems[register.dropDownVal],
                            //         "otherSkills": register.otherSkillController.text,
                            //         "createdAt": DateTime.now().microsecondsSinceEpoch,
                            //         "uid": uid
                            //       };
                            //
                            //       FocusManager.instance.primaryFocus?.unfocus();
                            //       Auth.funcSaveUser(userMap, uid).whenComplete(() {
                            //         HelperFunction.saveUserTypeSharedPreference(
                            //             register.type);
                            //         HelperFunction.saveUserLoggedInSharedPreference(register.rememberMe);
                            //         HelperFunction.saveUserNameSharedPreference(
                            //             register.nameController.text);
                            //         HelperFunction.saveUserEmailSharedPreference(
                            //             register.emailController.text);
                            //         EasyLoading.dismiss();
                            //
                            //         register.clearAll(context);
                            //         Navigator.of(context).pushAndRemoveUntil(
                            //
                            //             MaterialPageRoute(
                            //                 builder: (context) => const MainPage()),
                            //                 (Route<dynamic> route) => false);
                            //       }).catchError((onError) {
                            //         EasyLoading.dismiss();
                            //         register.setEmailClear();
                            //       }).onError((error, stackTrace) {
                            //         EasyLoading.dismiss();
                            //         register.setEmailClear();
                            //       });
                            //     }
                            //   });
                            // } else {
                            //   EasyLoading.dismiss();
                            //   register.setEmailClear();
                            // }
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            register.toggleScreen(context);
                          },
                        ),
                        const Visibility(visible: true, child: OrDivider()),
                        Visibility(
                          visible: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SocalIcon(
                                iconSrc: "assets/icons/facebook.svg",
                                press: () {},
                              ),
                              SocalIcon(
                                iconSrc: "assets/icons/twitter.svg",
                                press: () {},
                              ),
                              SocalIcon(
                                iconSrc: "assets/icons/google-plus.svg",
                                press: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),);
  }
}
