import 'package:easy_localization/easy_localization.dart';
import 'package:evently/screens/add_edit_event/event_form_screen.dart';
import 'package:evently/core/extensions.dart';
import 'package:evently/core/firebase_functions.dart';
import 'package:evently/models/task_model.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = 'EventDetails';

  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late TaskModel task;
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      task = ModalRoute.of(context)!.settings.arguments as TaskModel;
      isInitialized = true;
    }
    final themeProvider = context.watch<ThemeProvider>();
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
          "eventDetails".tr(),
          style: context.displayLarge().copyWith(color: context.onSurface()),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.onPrimary(),
              border: Border.all(color: context.outline()),
            ),
            child: InkWell(
              onTap: () async {
                var updatedTask = await Navigator.pushNamed(
                  context,
                  EventFormScreen.routeName,
                  arguments: task,
                );

                if (updatedTask != null) {
                  setState(() {
                    task = updatedTask as TaskModel ;
                  });
                }
              },
              child: Image.asset(
                'assets/images/edit.png',
                width: 32,
                height: 32,
                color: context.primary(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.onPrimary(),
                border: Border.all(color: context.outline()),
              ),
              child: InkWell(
                onTap: () {
                  FirebaseFunctions.deleteTask(task);
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/trash.png',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.outline()),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      themeProvider.themeMode == ThemeMode.light
                          ? 'assets/images/${task.category}_light.png'
                          : 'assets/images/${task.category}_dark.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              task.title,
              style: context.displayLarge().copyWith(
                color: context.onSurface(),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 76,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: context.onPrimary(),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.surface(),
                        border: BoxBorder.all(color: context.outline()),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/calendar.png'),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd MMM').format(
                          DateTime.fromMillisecondsSinceEpoch(task.date),
                        ),
                        style: context.displayMedium().copyWith(
                          color: context.onSurface(),
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(task.time),
                        ),
                        style: context.bodyMedium(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'description'.tr(),
              style: context.displayMedium().copyWith(
                color: context.onSurface(),
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: context.onPrimary(),
                border: BoxBorder.all(color: context.outline()),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  task.description,
                  style: context.bodyMedium().copyWith(
                    color: context.onSurface(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
