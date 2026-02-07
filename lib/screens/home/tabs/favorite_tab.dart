import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/custom_textfield.dart';
import 'package:evently/core/extensions.dart';
import 'package:evently/providers/favorite_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavoriteTab extends StatelessWidget {
  FavoriteTab({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider()..getTasks(),
      builder: (context, child) {
        final provider = context.watch<FavoriteProvider>();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                CustomTextField(
                  hintText: 'searchForEvent'.tr(),
                  controller: searchController,
                  onChanged: (value) {
                    provider.searchTasks(value);
                  },
                  obscureText: false,
                  suffixIconPath: 'assets/images/search.png',
                ),
                SizedBox(height: 16),
                Expanded(
                  child: provider.filteredTasks.isEmpty
                      ? Center(child: Text("noEventsFound".tr()))
                      : ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16),
                          itemCount: provider.filteredTasks.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: context.outline(),
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                        themeProvider.themeMode == ThemeMode.light
                                            ? 'assets/images/${provider.filteredTasks[index].category}_light.png'
                                            : 'assets/images/${provider.filteredTasks[index].category}_dark.png',
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
                                              BorderRadiusGeometry.circular(8),
                                          border: Border.all(
                                            color: context.outline(),
                                          ),
                                        ),
                                        child: Text(
                                          DateFormat('dd MMM').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              provider.filteredTasks[index].date,
                                            ),
                                          ),
                                          style: context
                                              .displayMedium()
                                              .copyWith(
                                                color: themeProvider.themeMode == ThemeMode.dark
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
                                              BorderRadiusGeometry.circular(8),
                                          border: Border.all(
                                            color: context.outline(),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              provider.filteredTasks[index].title,
                                              style: context
                                                  .displayMedium()
                                                  .copyWith(
                                                    color: context.onSurface(),
                                                  ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                var task = provider.filteredTasks[index];
                                                task.isFavorite = !task.isFavorite;
                                                provider.updateTask(task);
                                              },
                                              child: Icon(
                                                provider.filteredTasks[index].isFavorite
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
