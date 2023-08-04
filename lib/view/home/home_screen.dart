import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wings/controller/provider/provider.dart';
import 'package:wings/view/home/widget/drawer.dart';
import 'package:wings/view/utils/utils.dart';
import 'widget/item_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeKey,
      backgroundColor: cardClr2,
      appBar: AppBar(backgroundColor: bgColor, title: const Text('Wings.')),
      drawer: const NavigationDrawers(),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<UserProvider>(context, listen: false).fetchUser();
        },
        child: FutureBuilder<List<dynamic>>(
          future: Provider.of<UserProvider>(context).fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: LoadingIndicator(
                    indicatorType: Indicator.circleStrokeSpin,
                    colors: [bgColor],
                    strokeWidth: 2,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: user!.length,
                itemBuilder: (context, index) {
                  final post = user[index];
                  return ItemTile(post: post);
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
