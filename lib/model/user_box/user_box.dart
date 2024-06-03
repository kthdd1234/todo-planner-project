import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 1)
class UserBox extends HiveObject {
  UserBox({
    required this.id,
    required this.createDateTime,
    this.alarmInfo,
    this.passwords,
    this.calendarFormat,
    this.calendarMaker,
    this.language,
    this.fontFamily,
    this.googleDriveInfo,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime createDateTime;

  @HiveField(2)
  Map<String, dynamic>? alarmInfo;

  @HiveField(3)
  String? passwords;

  @HiveField(4)
  String? calendarFormat;

  @HiveField(5)
  String? calendarMaker;

  @HiveField(6)
  String? language;

  @HiveField(7)
  String? fontFamily;

  @HiveField(8)
  Map<String, dynamic>? googleDriveInfo;

  @override
  String toString() {
    return '{id: $id, createDateTime: $createDateTime, alarmInfo: $alarmInfo, passwords: $passwords, calendarFormat: $calendarFormat, calendarMaker: $calendarMaker, language: $language, fontFamily: $fontFamily, googleDriveInfo: $googleDriveInfo}';
  }
}