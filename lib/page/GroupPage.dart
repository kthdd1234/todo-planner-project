import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/group/GroupAddButton.dart';
import 'package:project/widget/group/GroupEditButton.dart';
import 'package:project/widget/group/GroupItemButton.dart';
import 'package:project/widget/modalSheet/TitleSettingModalSheet.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool isEdit = false;

  onItem(GroupBox groupBox) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(groupBox: groupBox),
    );
  }

  onAdd() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(),
    );
  }

  onEdit() {
    setState(() => isEdit = !isEdit);
  }

  onRemove(GroupBox groupBox) {
    if (groupRepository.groupList.length == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '최소 1개 이상의 그룹이 존재해야 합니다.',
          buttonText: '확인',
          height: 170,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '삭제 시, 그룹 내 할 일도 모두 삭제됩니다.',
          buttonText: '삭제',
          isCancel: true,
          height: 155,
          onTap: () async {
            UserBox user = userRepository.user;
            String groupId = groupBox.id;
            List<String> taskRemoveIdList = taskRepository.taskList
                .where((task) => task.id == groupBox.id)
                .map((task) => task.id)
                .toList();

            // group 제거
            groupRepository.deleteGroup(groupId);

            // group 순서 id 제거
            user.groupOrderList?.remove(groupId);

            // task 삭제
            taskRepository.taskList.forEach((task) {
              if (task.id == groupId) task.delete();
            });

            // mark 기록 제거
            recordRepository.recordList.forEach((record) {
              record.taskMarkList = record.taskMarkList
                  ?.where(
                    (taskMark) => !taskRemoveIdList.contains(taskMark['id']),
                  )
                  .toList();

              record.taskOrderList;
            });

            // record order 그룹 & 할 일 삭제
            recordRepository.recordList.forEach((record) async {
              int index = record.recordOrderList?.indexWhere(
                      (recordOrder) => recordOrder['id'] == groupId) ??
                  -1;

              if (index != -1) {
                record.recordOrderList!.removeAt(index);
                await record.save();
              }
            });

            await user.save();
            navigatorPop(context);
          },
        ),
      );
    }
  }

  onReorder(int oldIndex, int newIndex) async {
    UserBox? user = userRepository.user;
    List<String> groupOrderList = user.groupOrderList ?? [];

    if (oldIndex < newIndex) newIndex -= 1;

    String orderId = groupOrderList.removeAt(oldIndex);
    groupOrderList.insert(newIndex, orderId);

    await user.save();
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
            List<GroupBox> groupList =
                getGroupOrderList(groupRepository.groupList);

            return ReorderableListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: groupList.length,
              onReorder: onReorder,
              itemBuilder: (context, index) {
                return Padding(
                  key: Key(groupList[index].id),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: GroupItemButton(
                    groupBox: groupList[index],
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
