import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wings/controller/provider/provider.dart';
import 'package:wings/view/home/widget/drawer.dart';
import 'package:wings/view/utils/utils.dart';
import 'widget/home_card.dart';

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
        color: bgColor,
        onRefresh: () async {
          await Provider.of<UserProvider>(context, listen: false)
              .fetchUser(refresh: true);
        },
        child: Consumer<ConnectivityProvider>(
          builder: (context, value, child) {
            value.hasInternet;
            if (value.hasInternet) {
              return const HomeCardBuilder();
            } else {
              return const HomeCardBuilder();
            }
          },
        ),
      ),
    );
  }
}
