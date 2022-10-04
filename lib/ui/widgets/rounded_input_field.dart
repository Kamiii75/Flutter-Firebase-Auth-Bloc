import 'package:firebase_auth_bloc/ui/widgets/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';


class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool isPass;
  final textInputType;
  const RoundedInputField({
    Key? key,
    this.hintText="",
    this.icon = Icons.person,
    required this.onChanged,
    required this.controller,
     this.isPass=false,
     this.textInputType=TextInputType.name,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType:  textInputType,
        obscureText: isPass,
        controller: controller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
