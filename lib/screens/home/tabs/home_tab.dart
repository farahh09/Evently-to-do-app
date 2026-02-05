import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/extensions.dart';
import 'package:evently/core/firebase_functions.dart';
import 'package:evently/providers/home_provider.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/screens/home/event_details/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeTabProvider()..getTasksStream(),
        ),
        ChangeNotifierProvider(create: (context) => HomeProvider()..getUser()),
      ],
      builder: (context, child) {
        final provider = context.watch<HomeTabProvider>();
        var homeProvider = Provider.of<HomeProvider>(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              ImageIcon(
                AssetImage(
                  themeProvider.themeMode == ThemeMode.light
                      ? "assets/images/sun.png"
                      : "assets/images/moon.png",
                ),
                color: context.primary(),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.primary(),
                ),
                child: Text(
                  context.locale == Locale("en", "US")
                      ? "EN"
                      : 'AR'
                  ,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(width: 8),
            ],
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("welcomeBack".tr(), style: context.labelMedium()),
              subtitle: homeProvider.user != null
                  ? Text(
                      homeProvider.user!.name,
                      style: context.displayLarge().copyWith(
                        color: context.onSurface(),
                      ),
                    )
                  : null,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: SizedBox(
                    height: 50,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                      itemCount: provider.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.changeCategory(index);
                          },
                          child: Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/${provider.categories[index]}.png',
                                  color: index == provider.selectedCategoryIndex
                                      ? themeProvider.themeMode ==
                                                ThemeMode.light
                                            ? context.onPrimary()
                                            : context.onSurface()
                                      : context.primary(),
                                  width: 21,
                                  height: 19,
                                ),
                                SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    provider.categories[index]
                                            .replaceAll("_", ' ')[0]
                                            .toUpperCase() +
                                        provider.categories[index]
                                            .replaceAll("_", ' ')
                                            .substring(1),
                                    style: context.displayMedium().copyWith(
                                      color:
                                          index !=
                                              provider.selectedCategoryIndex
                                          ? context.onSurface()
                                          : Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor:
                                index == provider.selectedCategoryIndex
                                ? context.primary()
                                : themeProvider.themeMode == ThemeMode.light
                                ? Colors.white
                                : context.onPrimary(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? context.outline()
                                    : index == provider.selectedCategoryIndex
                                    ? context.primary()
                                    : context.onPrimary(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: provider.tasks.isEmpty
                      ? Center(child: Text("noEventsFound".tr()))
                      : ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16),
                          itemCount: provider.tasks.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              direction: Axis.horizontal,
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      final task = provider.tasks[index];
                                      FirebaseFunctions.deleteTask(task);
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    icon: Icons.delete,
                                    label: 'delete'.tr(),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  final task = provider.tasks[index];
                                  Navigator.pushNamed(
                                    context,
                                    EventDetails.routeName,
                                    arguments: task,
                                  );
                                },
                                child: SizedBox(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: context.outline(),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                          child: Image.asset(
                                            themeProvider.themeMode ==
                                                    ThemeMode.light
                                                ? 'assets/images/${provider.tasks[index].category}_light.png'
                                                : 'assets/images/${provider.tasks[index].category}_dark.png',
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: context.surface(),
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                    8,
                                                  ),
                                              border: Border.all(
                                                color: context.outline(),
                                              ),
                                            ),
                                            child: Text(
                                              DateFormat('dd MMM').format(
                                                DateTime.fromMillisecondsSinceEpoch(
                                                  provider.tasks[index].date,
                                                ),
                                              ),
                                              style: context
                                                  .displayMedium()
                                                  .copyWith(
                                                    color:
                                                        themeProvider
                                                                .themeMode ==
                                                            ThemeMode.dark
                                                        ? context.primary()
                                                        : null,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: context.surface(),
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                    8,
                                                  ),
                                              border: Border.all(
                                                color: context.outline(),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  provider.tasks[index].title,
                                                  style: context
                                                      .displayMedium()
                                                      .copyWith(
                                                        color: context
                                                            .onSurface(),
                                                      ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    var task =
                                                        provider.tasks[index];
                                                    task.isFavorite =
                                                        !task.isFavorite;
                                                    provider.updateTask(task);
                                                  },
                                                  child: Icon(
                                                    provider
                                                            .tasks[index]
                                                            .isFavorite
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: context.primary(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
