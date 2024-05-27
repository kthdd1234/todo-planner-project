import 'package:flutter/material.dart';
import 'package:project/body/todo/widget/todoGroupItem.dart';
import 'package:project/body/todo/widget/todoGroupTitle.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/ItemSettingPage.dart';
import 'package:project/provider/initGroupProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class GroupItemListPage extends StatelessWidget {
  const GroupItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    InitGroupProvider group = context.watch<InitGroupProvider>();
    ColorClass color = getColor(group.colorName);

    onAdd() {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => ItemSettingPage(isEdit: false),
        ),
      );
    }

    onSave() {
      //
    }

    onReorder(int oldIdx, int newIdx) {
      context.read<InitGroupProvider>().changeOrderTodo(oldIdx, newIdx);
    }

    confirmDismiss({
      required DismissDirection direction,
      required TodoClass todo,
    }) async {
      if (direction == DismissDirection.endToStart) {
        bool dismiss = false;

        await showDialog(
            context: context,
            builder: (context) {
              wContainer({
                required String text,
                required Color color,
                required Function() onTap,
              }) {
                return Expanded(
                  child: CommonContainer(
                    radius: 7,
                    innerPadding: 15,
                    color: color,
                    onTap: onTap,
                    child: CommonText(
                      text: text,
                      color: Colors.white,
                      isBold: true,
                    ),
                  ),
                );
              }

              onRemove() {
                context.read<InitGroupProvider>().removeTodo(todo: todo);
                navigatorPop(context);
              }

              onClose() {
                navigatorPop(context);
              }

              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Row(
                  children: [CommonText(text: '할 일을 삭제할까요?', fontSize: 18)],
                ),
                content: Row(
                  children: [
                    wContainer(text: '취소하기', onTap: onClose, color: blue.s200),
                    CommonSpace(width: 5),
                    wContainer(text: '삭제하기', onTap: onRemove, color: red.s200),
                  ],
                ),
              );
            });

        return dismiss;
      }
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '2. 할 일 리스트',
        ),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                outerPadding: 5,
                child: Column(
                  children: [
                    TodoGroupTitle(
                      title: group.name,
                      desc: group.desc != '' ? group.desc : 'ㅡ',
                      color: color,
                      isShowAction: false,
                    ),
                    group.todoList.isNotEmpty
                        ? Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                ReorderableListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, idx) => Dismissible(
                                    direction: DismissDirection.endToStart,
                                    dismissThresholds: const {
                                      DismissDirection.endToStart: 0.1
                                    },
                                    confirmDismiss:
                                        (DismissDirection direction) =>
                                            confirmDismiss(
                                      direction: direction,
                                      todo: group.todoList[idx],
                                    ),
                                    key: Key(group.todoList[idx].id),
                                    background: Container(
                                      color: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: TodoGroupItem(
                                      id: group.todoList[idx].id,
                                      name: group.todoList[idx].name,
                                      todoType: group.todoList[idx].type,
                                      isHighlight:
                                          group.todoList[idx].isHighlighter,
                                      memo: group.todoList[idx].memo,
                                      actionType: eItemActionEdit,
                                      color: color,
                                    ),
                                  ),
                                  itemCount: group.todoList.length,
                                  onReorder: onReorder,
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonText(
                                  text: '추가된 할 일이 없어요',
                                  color: Colors.grey,
                                ),
                                CommonText(
                                  text: '아래의 버튼을 눌러 할 일을 추가해보세요',
                                  color: Colors.grey,
                                ),
                                CommonSpace(height: 10),
                                svgAsset(
                                  name: 'arrow-down',
                                  width: 15,
                                  color: Colors.grey.shade300,
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
            CommonSpace(height: 10),
            Column(
              children: [
                CommonButton(
                  text: '할 일 추가',
                  outerPadding: const EdgeInsets.symmetric(horizontal: 5),
                  verticalPadding: 15,
                  borderRadius: 100,
                  textColor: Colors.white,
                  buttonColor: buttonColor,
                  onTap: onAdd,
                ),
                CommonSpace(height: 10),
                CommonButton(
                  text: '완료',
                  outerPadding: const EdgeInsets.symmetric(horizontal: 5),
                  verticalPadding: 15,
                  borderRadius: 100,
                  textColor: Colors.white,
                  buttonColor: buttonColor,
                  onTap: onSave,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 1. 아이템 이름 설정
// 2. 분류(할 일 또는 목표), 컬러, 메모, 형광펜
