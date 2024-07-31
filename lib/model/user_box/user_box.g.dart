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
      taskTitleInfo: (fields[9] as Map).cast<String, dynamic>(),
      memoTitleInfo: (fields[10] as Map).cast<String, dynamic>(),
      alarmInfo: (fields[2] as Map?)?.cast<String, dynamic>(),
      passwords: fields[3] as String?,
      calendarFormat: fields[4] as String?,
      calendarMaker: fields[5] as String?,
      language: fields[6] as String?,
      fontFamily: fields[7] as String?,
      googleDriveInfo: (fields[8] as Map?)?.cast<String, dynamic>(),
      theme: fields[11] as String?,
      filterIdList: (fields[12] as List?)?.cast<String>(),
      widgetTheme: fields[13] as String?,
      watchAdDateTime: fields[14] as DateTime?,
      background: fields[15] as String?,
      appStartIndex: fields[16] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(17)
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
      ..write(obj.taskTitleInfo)
      ..writeByte(10)
      ..write(obj.memoTitleInfo)
      ..writeByte(11)
      ..write(obj.theme)
      ..writeByte(12)
      ..write(obj.filterIdList)
      ..writeByte(13)
      ..write(obj.widgetTheme)
      ..writeByte(14)
      ..write(obj.watchAdDateTime)
      ..writeByte(15)
      ..write(obj.background)
      ..writeByte(16)
      ..write(obj.appStartIndex);
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
