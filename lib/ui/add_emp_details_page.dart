import 'package:employee_demo/models/employee_data_model.dart';
import 'package:employee_demo/ui/widget/common_textfield_widget.dart';
import 'package:employee_demo/ui/widget/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddEmpDetailsPage extends StatelessWidget {
  const AddEmpDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CommonTextFieldWidget(
                  hintText: "Employee name",
                  showPrefixIcon: true,
                  prefixIcon: Icon(Icons.account_circle_outlined),
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextFieldWidget(
                  hintText: "Select role",
                  showPrefixIcon: true,
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (BuildContext context) {
                        return const SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Product Designer'),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Flutter Developer'),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('QA Tester'),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Product Owner'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  readOnly: true,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  prefixIcon: const Icon(Icons.work_outline),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextFieldWidget(
                        hintText: "No date",
                        showPrefixIcon: true,
                        readOnly: true,
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return const DatePickerWidget();
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: CommonTextFieldWidget(
                        hintText: "No date",
                        showPrefixIcon: true,
                        readOnly: true,
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return const DatePickerWidget();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
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
                            onPressed: () async {
                              var box = await Hive.openBox('myBox');
                              var empData = EmployeeData(
                                  empName: "Vitul",
                                  empRole: "Sale",
                                  fromDate: DateTime.now(),
                                  toDate: DateTime.now());
                              box.add(empData);
                              print(box.values);
                              box.clear();
                            },
                            child: const Text("Save")),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
