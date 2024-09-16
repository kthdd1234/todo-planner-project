import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 1)
class UserBox extends HiveObject {
  UserBox({
    required this.id,
    required this.createDateTime,
    required this.taskTitleInfo,
    required this.memoTitleInfo,
    this.alarmInfo,
    this.passwords,
    this.calendarFormat,
    this.calendarMaker,
    this.language,
    this.fontFamily,
    this.googleDriveInfo,
    this.theme,
    this.filterIdList,
    this.widgetTheme,
    this.watchAdDateTime,
    this.background,
    this.appStartIndex,
    this.groupOrderList,
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

  @HiveField(9)
  Map<String, dynamic> taskTitleInfo;

  @HiveField(10)
  Map<String, dynamic> memoTitleInfo;

  @HiveField(11)
  String? theme;

  @HiveField(12)
  List<String>? filterIdList;

  @HiveField(13)
  String? widgetTheme;

  @HiveField(14)
  DateTime? watchAdDateTime;

  @HiveField(15)
  String? background;

  @HiveField(16)
  int? appStartIndex;

  @HiveField(17)
  List<String>? groupOrderList;

  @override
  String toString() {
    return '';
  }
}
