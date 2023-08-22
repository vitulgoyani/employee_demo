import '../models/employee_data_model.dart';

abstract class EmpState {}

class InitEmpState extends EmpState {}

class LoadingEmpState extends EmpState {}

class EmptyEmpState extends EmpState {}

class ErrorEmpState extends EmpState {
  final String message;

  ErrorEmpState(this.message);
}

class ResponseEmpState extends EmpState {
  final List<EmployeeData> empList;

  ResponseEmpState(this.empList);
}
