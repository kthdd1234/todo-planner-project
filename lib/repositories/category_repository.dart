import 'package:hive/hive.dart';
import 'package:project/model/category_box/category_box.dart';
import 'package:project/repositories/init_hive.dart';

class CategoryRepository {
  Box<CategoryBox>? _categoryBox;

  Box<CategoryBox> get categoryBox {
    _categoryBox ??= Hive.box<CategoryBox>(InitHiveBox.categoryBox);
    return _categoryBox!;
  }

  List<CategoryBox> get categoryList {
    return categoryBox.values.toList();
  }
}
