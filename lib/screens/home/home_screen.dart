import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:evently/screens/add_edit_event/event_form_screen.dart';
import 'package:evently/providers/home_provider.dart';
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
    return MultiProvider(
        providers: [
            ChangeNotifierProvider(create: (context) => HomeProvider()..getUser()),
            ChangeNotifierProvider(create: (context) => HomeTabProvider()..getTasksStream())
        ],
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: context.read<HomeTabProvider>(),
                      child: const EventFormScreen(),
                    ),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(50),
              ),
              child: Icon(Icons.add),
            ),
          );
        }
        );
  }
}
