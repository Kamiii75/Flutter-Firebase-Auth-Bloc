import 'package:firebase_auth_bloc/ui/widgets/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.controller,

  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {

  bool isObscure=true;
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        TextFieldContainer(
          child: TextField(
            controller: widget.controller,
            obscureText: isObscure,
            onChanged: widget.onChanged,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(

              hintText: "Password",
              icon: Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),


              border: InputBorder.none,

            ),
          ),
        ),

        Positioned(
          right:15,
          height: 80,


          child: GestureDetector(onTap: (){
            setState((){
              isObscure=!isObscure;
            });
          },
          child: isObscure?const Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ):const Icon(
            Icons.visibility_off,
            color: kPrimaryColor,
          ),),
        )
      ],
    );
  }
}
