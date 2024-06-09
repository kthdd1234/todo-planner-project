// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordBoxAdapter extends TypeAdapter<RecordBox> {
  @override
  final int typeId = 2;

  @override
  RecordBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordBox(
      createDateTime: fields[0] as DateTime,
      imageList: (fields[3] as List?)?.cast<Uint8List>(),
      taskInfo: (fields[1] as Map?)?.cast<String, dynamic>(),
    )..memo = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, RecordBox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.createDateTime)
      ..writeByte(1)
      ..write(obj.taskInfo)
      ..writeByte(2)
      ..write(obj.memo)
      ..writeByte(3)
      ..write(obj.imageList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
