import 'package:flutter/material.dart';
import 'package:wings/controller/controller.dart';
import 'package:wings/view/utils/utils.dart';
import '/view/login_screen/widget/login_btn.dart';
import '/view/login_screen/widget/main_card.dart';
import '/view/login_screen/widget/signup_btn.dart';
import '/view/login_screen/widget/text_field.dart';
import '/view/signup_screen/signup_screen.dart';

final formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SignInText(title: 'Sign In'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyTextField(
                      title: 'Email',
                      icon: Icons.mail,
                      myControler: userNameController,
                      passChar: false,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Email can\'t be empty';
                        }
                      },
                    ),
                    MyTextField(
                      title: 'Password',
                      icon: Icons.lock,
                      myControler: passwordController,
                      passChar: true,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Password can\'t be empty';
                        }
                      },
                    ),
                  ],
                ),
              ),
              kHeight,
              const LoginBtn(),
              kHeight40,
              const SignUpTxtBtn(navigateTo: SignUpScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
