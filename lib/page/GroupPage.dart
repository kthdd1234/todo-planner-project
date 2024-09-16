import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/group/GroupAddButton.dart';
import 'package:project/widget/group/GroupEditButton.dart';
import 'package:project/widget/group/GroupItemButton.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool isEdit = false;

  onItem() {
    // showModalBottomSheet(
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => ,
    // );
  }

  onEdit() {
    setState(() => isEdit = !isEdit);
  }

  onAdd() {
    //
  }

  onRemove() {
    //
  }

  onReorder(int oldIndex, int newIndex) async {
    UserBox user = userRepository.user;

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // String orderId = user.categoryOrderList.removeAt(oldIndex);
    // user.categoryOrderList.insert(newIndex, orderId);

    // await userRepository.user.save();
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '그룹 관리', actions: [
          GroupEditButton(isEdit: isEdit, isLight: isLight, onEdit: onEdit)
        ]),
        body: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (context, values, child) {
            final groupList = [];

            return ReorderableListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: 1,
              onReorder: onReorder,
              itemBuilder: (context, index) {
                return Padding(
                  key: Key('1'),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: GroupItemButton(
                    isEdit: isEdit,
                    onItem: onItem,
                    onRemove: onRemove,
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: GroupAddButton(isLight: isLight, onAdd: onAdd),
      ),
    );
  }
}
