import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'record_box.g.dart';

@HiveType(typeId: 2)
class RecordBox extends HiveObject {
  RecordBox({
    required this.createDateTime,
    this.taskOrderList,
    this.taskItemList,
    this.memo,
    this.imageList,
  });

  @HiveField(0)
  DateTime createDateTime;

  @HiveField(1)
  List<Map<String, dynamic>>? taskItemList;
  // [{ id: 'id', mark: 'mark', memo: 'memo' }]

  @HiveField(2)
  String? memo;

  @HiveField(3)
  List<Uint8List>? imageList;

  @HiveField(4)
  List<String>? taskOrderList;
}
