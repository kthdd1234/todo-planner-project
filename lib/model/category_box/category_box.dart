import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'category_box.g.dart';

@HiveType(typeId: 3)
class CategoryBox extends HiveObject {
  CategoryBox({
    required this.id,
    required this.name,
    required this.colorName,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String colorName;
}
