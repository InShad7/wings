import 'package:flutter/material.dart';
import 'package:wings/view/details_screen/detail_screen.dart';
import 'package:wings/view/utils/utils.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.post});

  final post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(post: post),
          ),
        );
      },
      child: Container(
        color: white,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 7),
        padding: const EdgeInsets.all(6),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: white,
            radius: 25,
            backgroundImage: post['avatar'] != null
                ? NetworkImage(post['avatar'])
                : const AssetImage('assets/dp.jpg') as ImageProvider,
          ),
          title: Text(
            post['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            post['description'],
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: grey,
            ),
          ),
        ),
      ),
    );
  }
}
