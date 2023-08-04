import 'package:flutter/material.dart';
import 'package:wings/view/utils/utils.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.post});
  final post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: post['avatar'] != null
                  ? NetworkImage(post['avatar'])
                  : const AssetImage('assets/dp.jpg') as ImageProvider,
            ),
            Text(
              " ${post['name']}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Id: ${post['id']}",
              style: TextStyle(
                fontSize: 18,
                color: grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Address: ${post['description']}",
              style: TextStyle(
                fontSize: 18,
                color: grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
