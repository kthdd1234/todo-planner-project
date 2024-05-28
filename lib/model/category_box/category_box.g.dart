// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryBoxAdapter extends TypeAdapter<CategoryBox> {
  @override
  final int typeId = 3;

  @override
  CategoryBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryBox(
      id: fields[0] as String,
      name: fields[1] as String,
      colorName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.colorName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
