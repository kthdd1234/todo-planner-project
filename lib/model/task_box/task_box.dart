import 'package:hive/hive.dart';

part 'task_box.g.dart';

@HiveType(typeId: 3)
class TaskBox extends HiveObject {
  TaskBox({
    required this.id,
    required this.name,
    required this.taskType,
    required this.colorName,
    required this.dateTimeInfo,
    this.isHighlighter,
    this.memo,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String taskType;

  @HiveField(4)
  String colorName;

  @HiveField(5)
  Map<String, dynamic> dateTimeInfo;

  @HiveField(6)
  bool? isHighlighter;

  @HiveField(7)
  String? memo;
}
