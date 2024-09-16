// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskBoxAdapter extends TypeAdapter<TaskBox> {
  @override
  final int typeId = 3;

  @override
  TaskBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskBox(
      id: fields[0] as String,
      name: fields[1] as String,
      taskType: fields[2] as String,
      colorName: fields[4] as String,
      dateTimeType: fields[5] as String,
      dateTimeList: (fields[6] as List).cast<DateTime>(),
      isHighlighter: fields[7] as bool?,
      groupId: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskBox obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.taskType)
      ..writeByte(4)
      ..write(obj.colorName)
      ..writeByte(5)
      ..write(obj.dateTimeType)
      ..writeByte(6)
      ..write(obj.dateTimeList)
      ..writeByte(7)
      ..write(obj.isHighlighter)
      ..writeByte(8)
      ..write(obj.groupId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
