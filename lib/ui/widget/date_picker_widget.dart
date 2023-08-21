import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _currentDate = DateTime.now();

  List<DayOption> dayOptionList = [
    DayOption(name: "Today", selected: false),
    DayOption(name: "Next Saturday", selected: false),
    DayOption(name: "Next Sunday", selected: false),
    DayOption(name: "After 1 week", selected: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
      child: Material(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        for (var element in dayOptionList) {
                          element.selected = false;
                        }
                        setState(() {
                          dayOptionList[index].selected = true;
                        });
                      },
                      child: Container(
                        color: dayOptionList[index].selected!
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).secondaryHeaderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Center(
                            child: Text(
                              dayOptionList[index].name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: dayOptionList[index].selected!
                                        ? Theme.of(context).primaryColorLight
                                        : Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                    setState(() => _currentDate = date);
                  },
                  weekendTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  thisMonthDayBorderColor: Colors.grey,
                  headerTextStyle: Theme.of(context).textTheme.titleLarge,
                  leftButtonIcon: const Icon(Icons.arrow_back_ios_new),
                  rightButtonIcon: const Icon(Icons.arrow_forward_ios),
                  weekdayTextStyle: Theme.of(context).textTheme.titleMedium,
                  height: 380.0,
                  selectedDateTime: _currentDate,
                  showOnlyCurrentMonthDate: true,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(DateFormat.yMMMd().format(_currentDate))
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColorLight)),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text("Save")),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DayOption {
  DayOption({this.name, this.selected});

  String? name;
  bool? selected;
}
