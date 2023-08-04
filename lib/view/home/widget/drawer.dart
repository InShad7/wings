import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wings/view/add_post.dart/add_post.dart';
import 'package:wings/view/home/widget/alert.dart';
import 'package:wings/view/utils/utils.dart';

class NavigationDrawers extends StatelessWidget {
  const NavigationDrawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(children: [
          buildHeader(context),
          buildMenuItems(context),
        ]),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Colors.blue.shade700,
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage('assets/dp.jpg'),
          ),
          kHeight,
          Text(
            FirebaseAuth.instance.currentUser!.displayName!.toString(),
            style: TextStyle(fontSize: 20, color: white),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.person_add_alt),
              title: const Text('Create new user'),
              onTap: () {
                // addPost(context: context);
              },
            ),
            kHeight,
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () async {
                alertBox(context: context);
              },
            ),
          ],
        ),
      );
}
