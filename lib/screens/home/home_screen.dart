import 'package:evently/core/extensions.dart';
import 'package:evently/screens/home/add_event/add_event_screen.dart';
import 'package:evently/screens/home/tabs/favorite_tab.dart';
import 'package:evently/screens/home/tabs/home_tab.dart';
import 'package:evently/screens/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';
  final List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var provider = Provider.of<HomeProvider>(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: (){
                  themeProvider.toggleTheme();
                },
                child: ImageIcon(

                  AssetImage(themeProvider.themeMode == ThemeMode.light?
                  "assets/images/sun.png" :
                  "assets/images/moon.png"
                  ),
                  color: context.primary(),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.primary(),
                ),
                child: Text(
                  "EN",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(width: 8),
            ],
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Welcome Back ✨", style: context.labelMedium()),
              subtitle: Text(
                "John Safwat",
                style: context.displayLarge().copyWith(
                  color: context.onSurface()
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.selectedIndex,
            onTap: (value) {
              provider.changeIndex(value);
            },
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/home.png")),
                label: "Home",
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/heart.png")),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.surface,
                icon: ImageIcon(AssetImage("assets/images/user.png")),
                label: "Profile",
              ),
            ],
          ),
          body: tabs[provider.selectedIndex],
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
