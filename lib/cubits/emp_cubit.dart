import 'package:employee_demo/cubits/emp_state.dart';
import 'package:employee_demo/models/employee_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../repository/emp_repo.dart';

class EmpCubit extends Cubit<EmpState> {
  final EmpRepo _empRepo;

  EmpCubit(this._empRepo) : super(InitEmpState());

  TextEditingController empNameTxt = TextEditingController();
  TextEditingController empRoleTxt = TextEditingController();
  TextEditingController empToDateTxt = TextEditingController();
  TextEditingController empFromDateTxt = TextEditingController();

  String? empRole = "";

  DateTime? empFromDate;
  DateTime? empToDate;

  List<String> role = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  onSelectFromDate(DateTime fromDate) {
    empFromDate = fromDate;
    empFromDateTxt.text = DateFormat.yMMMd().format(fromDate);
  }

  onSelectToDate(DateTime toDate) {
    empToDate = toDate;
    empToDateTxt.text = DateFormat.yMMMd().format(toDate);
  }

  setEmpData(EmployeeData employeeData) {
    empNameTxt.text = employeeData.empName!;
    empRoleTxt.text = employeeData.empRole!;
    empToDateTxt.text = employeeData.toDate != null
        ? DateFormat.yMMMd().format(employeeData.toDate!)
        : "";
    empFromDateTxt.text = DateFormat.yMMMd().format(employeeData.fromDate!);
    empRole = employeeData.empRole!;
    empFromDate = employeeData.fromDate!;
    empToDate = employeeData.toDate;
  }

  clearEmpFormData() {
    empNameTxt.clear();
    empRoleTxt.clear();
    empToDateTxt.clear();
    empFromDateTxt.clear();
    empRole = "";
    empFromDate = null;
    empToDate = null;
  }

  Future<void> fetchEmp() async {
    emit(LoadingEmpState());
    try {
      final empList = await _empRepo.getAllEmp();
      if (empList.isEmpty) {
        emit(EmptyEmpState());
      } else {
        emit(ResponseEmpState(empList));
      }
    } catch (e) {
      emit(ErrorEmpState(e.toString()));
    }
  }

  Future<void> addEmp(context) async {
    emit(LoadingEmpState());
    try {
      await _empRepo.addEmp(
        empName: empNameTxt.text,
        empRole: empRoleTxt.text,
        fromDate: empFromDate!,
        toDate: empToDate,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Employee added successfully'),
      ));
      fetchEmp();
    } catch (e) {
      emit(ErrorEmpState(e.toString()));
    }
  }

  Future<void> editEmp(context, int index) async {
    emit(LoadingEmpState());
    try {
      await _empRepo.editEmp(
          empName: empNameTxt.text,
          empRole: empRoleTxt.text,
          fromDate: empFromDate!,
          toDate: empToDate,
          index: index);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Employee edited successfully'),
      ));
      fetchEmp();
    } catch (e) {
      emit(ErrorEmpState(e.toString()));
    }
  }

  Future<void> deleteEmp(context, int index) async {
    emit(LoadingEmpState());
    try {
      await _empRepo.deleteEmp(index: index);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Employee deleted successfully'),
      ));
      fetchEmp();
    } catch (e) {
      emit(ErrorEmpState(e.toString()));
    }
  }
}
