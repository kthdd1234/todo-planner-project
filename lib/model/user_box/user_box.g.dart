// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBoxAdapter extends TypeAdapter<UserBox> {
  @override
  final int typeId = 1;

  @override
  UserBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBox(
      id: fields[0] as String,
      createDateTime: fields[1] as DateTime,
      todoRoutinTitle: fields[9] as String,
      alarmInfo: (fields[2] as Map?)?.cast<String, dynamic>(),
      passwords: fields[3] as String?,
      calendarFormat: fields[4] as String?,
      calendarMaker: fields[5] as String?,
      language: fields[6] as String?,
      fontFamily: fields[7] as String?,
      googleDriveInfo: (fields[8] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createDateTime)
      ..writeByte(2)
      ..write(obj.alarmInfo)
      ..writeByte(3)
      ..write(obj.passwords)
      ..writeByte(4)
      ..write(obj.calendarFormat)
      ..writeByte(5)
      ..write(obj.calendarMaker)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.fontFamily)
      ..writeByte(8)
      ..write(obj.googleDriveInfo)
      ..writeByte(9)
      ..write(obj.todoRoutinTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
