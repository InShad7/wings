import 'package:flutter/material.dart';
import '/controller/controller.dart';
import '/view/utils/utils.dart';

class SignUpTxtBtn extends StatelessWidget {
  const SignUpTxtBtn({super.key, this.signUp = true, required this.navigateTo});
  final signUp;
  final navigateTo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          signUp ? "New user? " : "Already have an account ! ",
          style: TextStyle(fontSize: 20, color: white),
        ),
        InkWell(
          child: signUp
              ? Text(
                  "Sign Up ",
                  style: TextStyle(
                    fontSize: 22,
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 22,
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          onTap: () {
            userNameController.clear();
            passwordController.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => navigateTo,
              ),
            );
          },
        ),
      ],
    );
  }
}
