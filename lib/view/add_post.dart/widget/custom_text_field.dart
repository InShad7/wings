
import 'package:flutter/material.dart';
import 'package:wings/view/utils/utils.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key, this.controller, this.maxLen, this.hintText});
  final controller;
  final maxLen;
  final hintText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autofocus: true,
        cursorColor: black,
        controller: controller,
        maxLines: null,
        maxLength: maxLen,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: grey, fontSize: 18),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
        style: TextStyle(color: black, fontSize: 18),
      ),
    );
  }
}
