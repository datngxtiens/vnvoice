import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon icon;
  final bool havePrefixIcon;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    this.havePrefixIcon = true,
    required this.hintText,
    required this.textInputType, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(40)
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: havePrefixIcon?icon:null,
        suffixIcon: isPass?Icon(Icons.remove_red_eye_outlined):null,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: havePrefixIcon?const EdgeInsets.all(10):const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
