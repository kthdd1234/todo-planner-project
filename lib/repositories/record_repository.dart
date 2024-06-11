import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/repositories/init_hive.dart';

class RecordRepository {
  Box<RecordBox>? _recordBox;

  Box<RecordBox> get recordBox {
    _recordBox ??= Hive.box<RecordBox>(InitHiveBox.recordBox);
    return _recordBox!;
  }

  List<RecordBox> get recordList {
    return recordBox.values.toList();
  }

  void addRecord(RecordBox record) async {
    int key = await recordBox.add(record);

    log('[addRecord] add (key:$key) $record');
    log('result ${recordBox.values.toList()}');
  }

  void deleteRecord(int key) async {
    await recordBox.delete(key);

    log('[deleteRecord] delete (key:$key)');
    log('result ${recordBox.values.toList()}');
  }

  void updateRecord({required dynamic key, required RecordBox record}) async {
    await recordBox.put(key, record);
    log('[updateRecord] update (key:$key) $record');
  }
}
