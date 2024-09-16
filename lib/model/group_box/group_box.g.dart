// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupBoxAdapter extends TypeAdapter<GroupBox> {
  @override
  final int typeId = 4;

  @override
  GroupBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupBox(
      createDateTime: fields[0] as DateTime,
      id: fields[1] as String,
      name: fields[2] as String,
      colorName: fields[3] as String,
      isOpen: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GroupBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.createDateTime)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.colorName)
      ..writeByte(4)
      ..write(obj.isOpen);
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
