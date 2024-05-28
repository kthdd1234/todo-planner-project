import 'package:hive/hive.dart';

part 'record_box.g.dart';

@HiveType(typeId: 2)
class RecordBox extends HiveObject {
  RecordBox({required this.createDateTime, this.recordInfo});

  @HiveField(0)
  DateTime createDateTime;

  @HiveField(1)
  Map<String, dynamic>? recordInfo;
}
