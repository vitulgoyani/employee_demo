// To parse this JSON data, do
//
//     final employeeData = employeeDataFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'employee_data_model.g.dart';
EmployeeData employeeDataFromJson(String str) => EmployeeData.fromJson(json.decode(str));

String employeeDataToJson(EmployeeData data) => json.encode(data.toJson());



@HiveType(typeId: 1)
class EmployeeData {
  @HiveField(0)
  final String? empName;
  @HiveField(1)
  final String? empRole;
  @HiveField(2)
  final DateTime? fromDate;
  @HiveField(3)
  final DateTime? toDate;

  EmployeeData({
    this.empName,
    this.empRole,
    this.fromDate,
    this.toDate,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
    empName: json["empName"],
    empRole: json["empRole"],
    fromDate: json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
    toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
  );

  Map<String, dynamic> toJson() => {
    "empName": empName,
    "empRole": empRole,
    "fromDate": fromDate?.toIso8601String(),
    "toDate": toDate?.toIso8601String(),
  };
}
