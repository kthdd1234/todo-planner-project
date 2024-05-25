// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupBoxAdapter extends TypeAdapter<GroupBox> {
  @override
  final int typeId = 3;

  @override
  GroupBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupBox(
      id: fields[0] as String,
      name: fields[1] as String,
      desc: fields[2] as String,
      colorName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupBox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.colorName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
