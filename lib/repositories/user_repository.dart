import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/repositories/init_hive.dart';

class UserRepository {
  Box<UserBox>? _userBox;
  String userKey = 'userProfile';

  Box<UserBox> get userBox {
    _userBox ??= Hive.box<UserBox>(InitHiveBox.userBox);
    return _userBox!;
  }

  UserBox get user {
    return userBox.get(userKey)!;
  }

  void addUser(UserBox user) async {
    int key = await userBox.add(user);

    log('[addUser] add (key:$key) $user');
    log('result ${userBox.values.toList()}');
  }

  void deleteUser(int key) async {
    await userBox.delete(key);

    log('[deleteUser] delete (key:$key)');
    log('result ${userBox.values.toList()}');
  }

  void updateUser(UserBox user) async {
    await userBox.put(userKey, user);

    log('[updateUser] update (key:$userKey) $user');
    log('result ${userBox.values.toList()}');
  }
}
