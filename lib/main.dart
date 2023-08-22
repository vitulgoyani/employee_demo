import 'package:employee_demo/cubits/emp_cubit.dart';
import 'package:employee_demo/models/employee_data_model.dart';
import 'package:employee_demo/repository/emp_repo.dart';
import 'package:employee_demo/ui/employee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(EmployeeDataAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmpCubit(EmpRepo()),
      child: MaterialApp(
        title: 'Employee Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: const EmployeeListPage(),
      ),
    );
  }
}
