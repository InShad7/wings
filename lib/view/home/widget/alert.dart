import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wings/view/utils/utils.dart';

void alertBox({context}) {
  showModalBottomSheet(
    backgroundColor: cardClr2,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(18),
      ),
    ),
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        kHeight,
        SizedBox(
          width: double.infinity,
          height: 70,
          child: TextButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: teal, fontSize: 18),
            ),
          ),
        ),
        const Divider(indent: 60, endIndent: 60),
        SizedBox(
          height: 65,
          width: 400,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: deleteRed,
                fontSize: 18,
              ),
            ),
          ),
        ),
        kHeight,
      ],
    ),
  );
}
