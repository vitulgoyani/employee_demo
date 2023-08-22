import 'package:employee_demo/cubits/emp_cubit.dart';
import 'package:employee_demo/cubits/emp_state.dart';
import 'package:employee_demo/ui/add_emp_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:intl/intl.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<EmpCubit>();
      cubit.fetchEmp();
    });
  }

  @override
  Widget build(BuildContext context) {
    final empCubit = context.read<EmpCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: BlocBuilder<EmpCubit, EmpState>(builder: (context, state) {
        if (state is InitEmpState || state is LoadingEmpState) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
                Text("Loading..."),
              ],
            ),
          );
        }
        else if(state is EmptyEmpState){
          return Center(child: Image.asset("assets/no_emp_found.png"));
        }
        else if (state is ResponseEmpState) {
          final empList = state.empList;
          return ListView.separated(
            itemCount: empList.length,
            itemBuilder: (context, index) {
              return SwipeActionCell(
                key: ObjectKey(empList[index]),
                trailingActions: <SwipeAction>[
                  SwipeAction(
                      title: "Delete",
                      performsFirstActionWithFullSwipe: true,
                      onTap: (CompletionHandler handler) async {
                        await handler(true);
                        empCubit.deleteEmp(index);
                      },
                      color: Colors.red),
                ],
                child: ListTile(
                  onTap: () {
                    empCubit.setEmpData(empList[index]);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddEmpDetailsPage(
                        index: index,
                      );
                    }));
                  },
                  title: Text(
                    empList[index].empName ?? "",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        empList[index].empRole ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "From ${DateFormat.yMMMd().format(empList[index].fromDate!)}"),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        }
        return Center(
          child: Text(state.toString()),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          empCubit.clearEmpFormData();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEmpDetailsPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
