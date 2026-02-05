import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/home_provider.dart';
import 'package:evently/screens/home/add_event/add_event_screen.dart';
import 'package:evently/screens/home/tabs/favorite_tab.dart';
import 'package:evently/screens/home/tabs/home_tab.dart';
import 'package:evently/screens/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';
  final List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider()..getUser(),
      builder: (context, child) {
        var homeProvider = Provider.of<HomeProvider>(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeProvider.selectedIndex,
            onTap: (value) {
              homeProvider.changeIndex(value);
            },
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/home.png")),
                label: "home".tr(),
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/heart.png")),
                label: "favorite".tr(),
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/user.png")),
                label: "profile".tr(),
              ),
            ],
          ),
          body: tabs[homeProvider.selectedIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, AddEventScreen.routeName);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(50)
            ),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
