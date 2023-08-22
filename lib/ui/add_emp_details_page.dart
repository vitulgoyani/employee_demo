import 'package:employee_demo/cubits/emp_cubit.dart';
import 'package:employee_demo/cubits/emp_state.dart';
import 'package:employee_demo/ui/widget/common_textfield_widget.dart';
import 'package:employee_demo/ui/widget/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmpDetailsPage extends StatelessWidget {
  const AddEmpDetailsPage({super.key,this.index});

  final int? index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmpCubit, EmpState>(builder: (context, state) {
      final empCubit = context.read<EmpCubit>();
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
                  CommonTextFieldWidget(
                    hintText: "Employee name",
                    controller: empCubit.empNameTxt,
                    showPrefixIcon: true,
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonTextFieldWidget(
                    hintText: "Select role",
                    showPrefixIcon: true,
                    controller: empCubit.empRoleTxt,
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        builder: (BuildContext context) {
                          return SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: empCubit.role
                                  .map((e) => ListTile(
                                        title: Text(e),
                                        onTap: () {
                                          empCubit.empRole = e;
                                          empCubit.empRoleTxt.text = e;
                                          Navigator.pop(context);
                                        },
                                      ))
                                  .toList(),
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
                          hintText: "From date",
                          showPrefixIcon: true,
                          controller: empCubit.empFromDateTxt,
                          readOnly: true,
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return DatePickerWidget(
                                  onSelectDate: empCubit.onSelectFromDate,
                                );
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
                          hintText: "To date",
                          showPrefixIcon: true,
                          controller: empCubit.empToDateTxt,
                          readOnly: true,
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return DatePickerWidget(
                                  onSelectDate: empCubit.onSelectToDate,
                                );
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
                                if (empCubit.empNameTxt.text == "") {
                                } else if (empCubit.empRoleTxt.text == "") {
                                } else if (empCubit.empFromDateTxt.text == "") {
                                } else {
                                  if(index!=null){
                                    empCubit.editEmp(index!);
                                  }else {
                                    empCubit.addEmp();
                                  }
                                }
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
    });
  }
}
