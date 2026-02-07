import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/custom_elevated_button.dart';
import 'package:evently/core/custom_textfield.dart';
import 'package:evently/core/extensions.dart';
import 'package:evently/core/firebase_functions.dart';
import 'package:evently/models/task_model.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventFormScreen extends StatefulWidget {
  static const String routeName = 'EventForm';

  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final List<String> categories = [
    "sport",
    "birthday",
    "book_club",
    "exhibition",
    "meeting",
  ];
  int selectedCategoryIndex = 0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isDateChosen = false;
  bool isTimeChosen = false;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  TaskModel? existingTask;
  bool isInitialized = false;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    if (!isInitialized) {
      final args = ModalRoute.of(context)!.settings.arguments;

      if (args is TaskModel) {
        existingTask = args;
        isEditMode = true;
        titleController.text = existingTask!.title;
        descriptionController.text = existingTask!.description;
        selectedDate = DateTime.fromMillisecondsSinceEpoch(existingTask!.date);
        selectedTime = TimeOfDay.fromDateTime(
          DateTime.fromMillisecondsSinceEpoch(existingTask!.time),
        );
        selectedCategoryIndex = categories.indexOf(existingTask!.category);
        isDateChosen = true;
        isTimeChosen = true;
        isInitialized = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: themeProvider.themeMode == ThemeMode.light
                ? context.onSecondary()
                : context.onPrimary(),
            borderRadius: BorderRadius.circular(8),
            border: BoxBorder.all(
              color: themeProvider.themeMode == ThemeMode.light
                  ? Color(0xFFF0F0F0)
                  : context.outline(),
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackButton(
              color: themeProvider.themeMode == ThemeMode.light
                  ? context.primary()
                  : context.onSecondary(),
            ),
          ),
        ),
        title: Text(
          isEditMode ? "updateEvent".tr() : "addEvent".tr(),
          style: context.displayLarge().copyWith(color: context.onSurface()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  themeProvider.themeMode == ThemeMode.light
                      ? "assets/images/${categories[selectedCategoryIndex]}_light.png"
                      : "assets/images/${categories[selectedCategoryIndex]}_dark.png",
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedCategoryIndex = index;
                        setState(() {});
                      },
                      child: Chip(
                        label: Row(
                          children: [
                            Image.asset(
                              'assets/images/${categories[index]}.png',
                              color: index == selectedCategoryIndex
                                  ? context.onPrimary()
                                  : context.primary(),
                              width: 22,
                              height: 19,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'categories.${categories[index]}'.tr(),
                              style: context.displayMedium().copyWith(
                                color: index != selectedCategoryIndex
                                    ? themeProvider.themeMode == ThemeMode.light
                                    ? context.primary()
                                    : context.secondary()
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor:
                        index == selectedCategoryIndex
                            ? context.primary()
                            : themeProvider.themeMode == ThemeMode.light
                            ? Colors.white
                            : context.onPrimary(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? context.outline()
                                : index == selectedCategoryIndex
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
                  Image.asset('assets/images/clock.png', width: 24, height: 24),
                  SizedBox(width: 6),
                  Text(
                    'eventTime'.tr(),
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
                  TaskModel event = TaskModel(
                    id: isEditMode ? existingTask!.id : '',
                    title: titleController.text,
                    description: descriptionController.text,
                    category: categories[selectedCategoryIndex],
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
          
                  if (isEditMode) {
                    await FirebaseFunctions.updateTask(event);
                    Navigator.pop(context, event);
                  } else {
                    await FirebaseFunctions.createTask(event);
                    Navigator.pop(context);
                  }
                },
                fillColor: context.primary(),
                child: Text(
                  isEditMode ? 'updateEvent'.tr() : 'addEvent'.tr(),
                  style: context.displayLarge(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDateTime() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      builder: (context, child) => Theme(
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
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
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