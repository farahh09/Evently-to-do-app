import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/custom_elevated_button.dart';
import 'package:evently/core/custom_textfield.dart';
import 'package:evently/core/extensions.dart';
import 'package:evently/core/firebase_functions.dart';
import 'package:evently/models/task_model.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = 'EditEvent';

  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isDateChosen = true;
  bool isTimeChosen = true;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  late TaskModel task;
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
        create: (context) => HomeTabProvider()..getTasksStream(),
        builder: (context, child) {
          var homeProvider = Provider.of<HomeTabProvider>(context);
          if (!isInitialized) {
            task = ModalRoute
                .of(context)!
                .settings
                .arguments as TaskModel;

            titleController.text = task.title;
            descriptionController.text = task.description;

            selectedDate = DateTime.fromMillisecondsSinceEpoch(task.date);

            selectedTime = TimeOfDay.fromDateTime(
              DateTime.fromMillisecondsSinceEpoch(task.time),
            );

            homeProvider.selectedCategoryIndex = homeProvider.categories.indexOf(task.category);

            isInitialized = true;
          }
          return Scaffold(
            appBar: AppBar(
              leading: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: provider.themeMode == ThemeMode.light
                      ? context.onSecondary()
                      : context.onPrimary(),
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(
                    color: provider.themeMode == ThemeMode.light
                        ? Color(0xFFF0F0F0)
                        : context.outline(),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: provider.themeMode == ThemeMode.light
                          ? context.primary()
                          : context.onSecondary(),
                    ),
                  ),
                ),
              ),
              title: Text(
                "updateEvent".tr(),
                style: context.displayLarge().copyWith(
                    color: context.onSurface()),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      provider.themeMode == ThemeMode.light
                          ? "assets/images/${homeProvider.categories[homeProvider.selectedCategoryIndex]}_light.png"
                          : "assets/images/${homeProvider.categories[homeProvider.selectedCategoryIndex]}_dark.png",
                      height: 230,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                      itemCount: homeProvider.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            homeProvider.selectedCategoryIndex = index;
                            setState(() {});
                          },
                          child: Chip(
                            label: Row(
                              children: [
                                Image.asset(
                                  'assets/images/${homeProvider.categories[index]}.png',
                                  color: index == homeProvider.selectedCategoryIndex
                                      ? context.onPrimary()
                                      : context.primary(),
                                  width: 22,
                                  height: 19,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  homeProvider.categories[index].replaceAll("_", ' ').toUpperCase(),
                                  style: context.displayMedium().copyWith(
                                    color: index != homeProvider.selectedCategoryIndex
                                        ? provider.themeMode == ThemeMode.light
                                        ? context.primary()
                                        : context.secondary()
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: index == homeProvider.selectedCategoryIndex
                                ? context.primary()
                                : provider.themeMode == ThemeMode.light
                                ? Colors.white
                                : context.onPrimary(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: provider.themeMode == ThemeMode.dark
                                    ? context.outline()
                                    : index == homeProvider.selectedCategoryIndex
                                    ? context.primary()
                                    : context.onPrimary(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    'title'.tr(),
                    style: context.displayMedium().copyWith(
                      color: context.onSurface(),
                    ),
                  ),
                  CustomTextField(
                    controller: titleController,
                    hintText: 'eventTitle'.tr(),
                    obscureText: false,
                  ),
                  Text(
                    'description'.tr(),
                    style: context.displayMedium().copyWith(
                      color: context.onSurface(),
                    ),
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'eventDescription'.tr(),
                    obscureText: false,
                    maxLines: 5,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/calendar.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'eventDate'.tr(),
                        style: context.displayMedium().copyWith(
                          color: context.onSurface(),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          selectDateTime();
                        },
                        child: Text(
                          isDateChosen
                              ? DateFormat('MMMdd, yyyy').format(selectedDate)
                              : 'chooseDate'.tr(),
                          style: context.titleSmall(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                          'assets/images/clock.png', width: 24, height: 24),
                      SizedBox(width: 6),
                      Text(
                        'Event Time',
                        style: context.displayMedium().copyWith(
                          color: context.onSurface(),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          selectTime();
                        },
                        child: Text(
                          isTimeChosen
                              ? selectedTime.format(context)
                              : 'chooseTime'.tr(),
                          style: context.titleSmall(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  CustomElevatedButton(
                    onPressed: () async {
                      TaskModel updatedTask = TaskModel(
                        id: task.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        category: homeProvider.categories[homeProvider.selectedCategoryIndex],
                        date: selectedDate.millisecondsSinceEpoch,
                        time: DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ).millisecondsSinceEpoch,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      );

                      await FirebaseFunctions.updateTask(updatedTask);

                      Navigator.pop(context, updatedTask);
                    },
                    fillColor: context.primary(),
                    child: Text(
                        'updateEvent'.tr(), style: context.displayLarge()),
                  ),
                ],
              ),
            ),
          );
        }
        );
  }

        Future<void> selectDateTime()async {
      DateTime? chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: selectedDate,
        builder: (context, child) =>
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: context.primary(),
                  onPrimary: context.onPrimary(),
                  onSurface: context.primary(),
                  surface: context.surface(),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      foregroundColor: context.primary()),
                ),
              ),
              child: child!,
            ),
        lastDate: DateTime.now().add(Duration(days: 365)),
      );
      if (chosenDate != null) {
        selectedDate = chosenDate;
        isDateChosen = true;
        setState(() {});
      }
    }

    Future<void> selectTime() async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: context.primary(),
                onPrimary: context.onPrimary(),
                onSurface: context.primary(),
                surface: context.surface(),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: context.primary()),
              ),
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: false),
              child: child!,
            ),
          );
        },
      );
      if (pickedTime != null) {
        selectedTime = pickedTime;
        isTimeChosen = true;
        setState(() {});
      }
    }
  }
