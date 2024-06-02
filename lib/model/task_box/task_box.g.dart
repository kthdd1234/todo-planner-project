// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskBoxAdapter extends TypeAdapter<TaskBox> {
  @override
  final int typeId = 4;

  @override
  TaskBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskBox(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as String,
      isHighlighter: fields[3] as bool?,
      memo: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.isHighlighter)
      ..writeByte(4)
      ..write(obj.memo);
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
