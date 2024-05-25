import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'group_box.g.dart';

@HiveType(typeId: 3)
class GroupBox extends HiveObject {
  GroupBox({
    required this.id,
    required this.name,
    required this.desc,
    required this.colorName,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String desc;

  @HiveField(3)
  String colorName;
}
