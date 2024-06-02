import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'task_box.g.dart';

@HiveType(typeId: 4)
class TaskBox {
  TaskBox({
    required this.id,
    required this.name,
    required this.type,
    this.isHighlighter,
    this.memo,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String type;

  @HiveField(3)
  bool? isHighlighter;

  @HiveField(4)
  String? memo;
}
