import 'package:hive/hive.dart';

part 'task_box.g.dart';

@HiveType(typeId: 3)
class TaskBox extends HiveObject {
  TaskBox({
    required this.id,
    required this.name,
    required this.taskType,
    required this.colorName,
    required this.dateTimeType,
    required this.dateTimeList,
    this.isHighlighter,
    this.groupId,
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
  String dateTimeType;

  @HiveField(6)
  List<DateTime> dateTimeList;

  @HiveField(7)
  bool? isHighlighter;

  @HiveField(8)
  String? groupId;
}
