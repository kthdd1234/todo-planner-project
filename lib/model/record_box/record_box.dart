import 'dart:typed_data';
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

/**
 * recordInfo = {
 *    'groupId-1': {
 *       'todoId-1': {
 *           mark: 'O',
 *           meme: '오답노트 3번씩 쓰기!'
 *        },
 *       'todoId-2':{
 *           mark: 'X',
 *           meme: null
 *       }
 *    }
 * }
 * 
 * 
 */