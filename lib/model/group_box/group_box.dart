import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'group_box.g.dart';

@HiveType(typeId: 4)
class GroupBox extends HiveObject {
  GroupBox({
    required this.createDateTime,
    required this.id,
    required this.name,
    required this.colorName,
    required this.isOpen,
  });

  @HiveField(0)
  DateTime createDateTime;

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String colorName;

  @HiveField(4)
  bool isOpen;
}
