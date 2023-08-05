import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wings/main.dart';
import '/controller/controller.dart';
import '/view/login_screen/login_screen.dart';
import '/view/signup_screen/signup_screen.dart';
import '/view/splash_screen.dart/spalsh_screen.dart';
import '/view/utils/utils.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key, this.signup = false});
  final signup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: white,
            ),
            height: MediaQuery.of(context).size.height / 15,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (signup
                    ? !signUpformKey.currentState!.validate()
                    : !formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Please provide valid credentials',
                        style: TextStyle(fontSize: 17),
                      ),
                      backgroundColor: deleteRed,
                    ),
                  );
                } else {
                  signIn(context);
                }
              },
              child: Text(
                signup ? 'Sign Up' : 'Sign In',
                style: TextStyle(fontSize: 28, color: black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future signIn(context) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [white],
              strokeWidth: 2),
        ),
      ),
    );

    try {
      final connectivityResult =
          await InternetConnectionChecker().connectionStatus;
      if (connectivityResult == InternetConnectionStatus.disconnected) {
        Fluttertoast.showToast(
          msg: 'Oops..! Please turn on mobile data or wifi.',
          backgroundColor: deleteRed,
        );
        Navigator.pop(context);
        return; // return  null to indicate nothing to do
      }
      if (signup) {
        //sign up with username and password
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userNameController.text.trim(),
          password: passwordController.text.trim(),
        );
        //update the user name
        final currentUser = FirebaseAuth.instance.currentUser;
        await currentUser!.updateDisplayName(nameController.text.trim());
      } else {

        //or login in with username and password
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userNameController.text.trim(),
            password: passwordController.text.trim());
      }
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            signup ? 'Sign in successfully' : 'Logged In  successfully',
            style: const TextStyle(fontSize: 18),
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: green,
        ),
      );
      // if (signup) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CheckUserLogin(),
        ),
      );
      // }

      userNameController.clear();
      passwordController.clear();
      nameController.clear();
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Enter valid Credentials';
      if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(fontSize: 18),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: deleteRed,
        ),
      );
    }
    if (signup == false) {
      navigatorKey.currentState!.popUntil((route) {
        return route.isFirst;
      });
    }
  }
}
