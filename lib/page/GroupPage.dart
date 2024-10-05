import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
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

  onItem(GroupInfoClass groupInfo) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(groupInfo: groupInfo),
    );
  }

  onAdd({
    required bool isPremium,
    required List<GroupInfoClass> groupInfoList,
  }) {
    if (isPremium == false && groupInfoList.length > 2) {
      return movePage(context: context, page: const PremiumPage());
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(),
    );
  }

  onEdit() {
    setState(() => isEdit = !isEdit);
  }

  onRemove({
    required List<GroupInfoClass> groupInfoList,
    required GroupInfoClass groupInfo,
    required UserInfoClass userInfo,
  }) {
    if (groupInfoList.length == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '최소 1개 이상의 그룹이 존재해야 합니다.',
          buttonText: '확인',
          height: 155,
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
            userInfo.groupOrderList.remove(groupInfo.gid);

            await userMethod.updateUser(userInfo: userInfo);
            await groupMethod.removeGroup(gid: groupInfo.gid);

            navigatorPop(context);
          },
        ),
      );
    }
  }

  onReorder(int oldIndex, int newIndex, UserInfoClass userInfo) async {
    List<String> groupOrderList = userInfo.groupOrderList;

    if (oldIndex < newIndex) newIndex -= 1;

    String orderId = groupOrderList.removeAt(oldIndex);
    groupOrderList.insert(newIndex, orderId);

    await userMethod.updateUser(userInfo: userInfo);
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

    return StreamBuilder<QuerySnapshot>(
      stream: groupMethod.stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CommonNull();

        List<GroupInfoClass> groupInfoList =
            groupMethod.getGroupInfoList(snapshot: snapshot);

        groupInfoList = getGroupInfoOrderList(
          userInfo.groupOrderList,
          groupInfoList,
        );

        return CommonBackground(
          child: CommonScaffold(
            appBarInfo: AppBarInfoClass(
              title: '그룹 관리',
              actions: [
                GroupEditButton(
                  isEdit: isEdit,
                  isLight: isLight,
                  onEdit: onEdit,
                )
              ],
            ),
            floatingActionButton: GroupAddButton(
              isLight: isLight,
              onAdd: () => onAdd(
                isPremium: isPremium,
                groupInfoList: groupInfoList,
              ),
            ),
            body: ReorderableListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: groupInfoList.length,
              onReorder: (oldIndex, newIndex) =>
                  onReorder(oldIndex, newIndex, userInfo),
              itemBuilder: (context, index) {
                return Padding(
                  key: Key(groupInfoList[index].gid),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: GroupItemButton(
                    groupInfo: groupInfoList[index],
                    isEdit: isEdit,
                    onItem: onItem,
                    onRemove: (groupInfo) => onRemove(
                      groupInfoList: groupInfoList,
                      groupInfo: groupInfo,
                      userInfo: userInfo,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
