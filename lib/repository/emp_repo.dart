import 'package:hive/hive.dart';

import '../models/employee_data_model.dart';

class EmpRepo {
  Future<List<EmployeeData>> getAllEmp() async {
    var box = await Hive.openBox('empBox');
    List<EmployeeData> employeeList = [];
    for (var element in box.values) {
      employeeList.add(element);
    }
    return employeeList;
  }

  Future<void> addEmp(
      {required String empName,
      required String empRole,
      required DateTime fromDate,
      required DateTime? toDate}) async {
    var box = await Hive.openBox('empBox');
    var empData = EmployeeData(
        empName: empName, empRole: empRole, fromDate: fromDate, toDate: toDate);
    box.add(empData);
  }

  Future<void> editEmp(
      {required String empName,
      required String empRole,
      required int index,
      required DateTime fromDate,
      required DateTime? toDate}) async {
    var box = await Hive.openBox('empBox');
    var empData = EmployeeData(
        empName: empName, empRole: empRole, fromDate: fromDate, toDate: toDate);
    box.putAt(index, empData);
  }

  Future<void> deleteEmp({
    required int index,
  }) async {
    var box = await Hive.openBox('empBox');

    box.deleteAt(index);
  }
}
