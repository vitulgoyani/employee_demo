import 'package:employee_demo/ui/add_emp_details_page.dart';
import 'package:flutter/material.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: Center(child: Image.asset("assets/no_emp_found.png")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
