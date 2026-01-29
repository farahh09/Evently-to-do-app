import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/custom_elevated_button.dart';
import 'package:evently/core/custom_textfield.dart';
import 'package:evently/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = 'AddEvent';
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<String> categories = [
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
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.light ? context.onSecondary() : context.onPrimary(),
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(
                color: provider.themeMode == ThemeMode.light ? Color(0xFFF0F0F0) : context.outline(),
              )
          ),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(Icons.arrow_back_ios, color: provider.themeMode == ThemeMode.light ? context.primary() : context.onSecondary(),),
            ),
          ),
        ),
        title: Text("Add event", style: context.displayLarge().copyWith(color: context.onSurface()),),
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
                provider.themeMode == ThemeMode.light?
                "assets/images/${categories[selectedCategoryIndex]}_light.png":
                "assets/images/${categories[selectedCategoryIndex]}_dark.png",
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ),
            SizedBox(
              height: 50,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 8,),
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
                          Image.asset('assets/images/${categories[index]}.png',
                            color: index == selectedCategoryIndex
                                ? context.onPrimary() : context.primary(),
                            width: 22,height: 19,),
                          SizedBox(width: 4,),
                          Text(
                            categories[index].replaceAll("_", ' ').toUpperCase(),
                            style: context.displayMedium().copyWith(
                              color: index != selectedCategoryIndex
                                  ? provider.themeMode == ThemeMode.light
                                  ? context.primary() : context.secondary()
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: index == selectedCategoryIndex
                          ? context.primary()
                          : provider.themeMode == ThemeMode.light
                          ? Colors.white : context.onPrimary(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: provider.themeMode == ThemeMode.dark
                              ? context.outline() : index == selectedCategoryIndex
                              ? context.primary() : context.onPrimary(),
                        )
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('Title', style: context.displayMedium().copyWith(color: context.onSurface()),),
            CustomTextField(
              controller: titleController,
              hintText: 'Event title',
              obscureText: false,
            ),
            Text('Description', style: context.displayMedium().copyWith(color: context.onSurface()),),
            CustomTextField(
              controller: descriptionController,
              hintText: 'Event Description....',
              obscureText: false,
              maxLines: 5,
            ),
            Row(
              children: [
                Image.asset('assets/images/calendar.png', width: 24, height: 24,),
                SizedBox(width: 6,),
                Text('Event Date',style: context.displayMedium().copyWith(color: context.onSurface())),
                Spacer(),
                InkWell(
                  onTap: (){
                    selectDateTime();
                  },
                  child: Text(
                      isDateChosen?
                      DateFormat('MMMdd, yyyy').format(selectedDate) :
                      'Choose date',
                      style: context.titleSmall()),
                )
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/clock.png', width: 24, height: 24,),
                SizedBox(width: 6,),
                Text('Event Time',style: context.displayMedium().copyWith(color: context.onSurface())),
                Spacer(),
                InkWell(
                  onTap: (){
                    selectTime();
                  },
                  child: Text(
                    isTimeChosen?
                    selectedTime.format(context) :
                    'Choose time', style: context.titleSmall()),
                )
              ],
            ),
            SizedBox(height: 24,),
            CustomElevatedButton(
                onPressed: (){},
                fillColor: context.primary(),
                child: Text('Add event', style: context.displayLarge(),)
            )
          ],
        ),
      ),
    );
  }
  Future<void> selectDateTime() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: context.primary(),
          onPrimary: context.onPrimary(),
          onSurface: context.primary(),
          surface: context.surface()
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: context.primary(),
          ),
        ),
      ), child: child!),
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
              style: TextButton.styleFrom(
                foregroundColor: context.primary(),
              ),
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
