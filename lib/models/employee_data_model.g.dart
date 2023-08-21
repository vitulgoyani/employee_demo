// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeDataAdapter extends TypeAdapter<EmployeeData> {
  @override
  final int typeId = 1;

  @override
  EmployeeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeData(
      empName: fields[0] as String?,
      empRole: fields[1] as String?,
      fromDate: fields[2] as DateTime?,
      toDate: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.empName)
      ..writeByte(1)
      ..write(obj.empRole)
      ..writeByte(2)
      ..write(obj.fromDate)
      ..writeByte(3)
      ..write(obj.toDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
