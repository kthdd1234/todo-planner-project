import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/etc/TodoSettingPage.dart';
import 'package:project/provider/CategoryProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    super.key,
    required this.id,
    required this.name,
    required this.color,
    required this.actionType,
    required this.todoType,
    this.markType,
    this.isHighlight,
    this.isShade50,
    this.memo,
  });

  String id, name, todoType;
  String? memo, markType;
  bool? isHighlight, isShade50;

  String actionType;
  ColorClass color;

  wAction({
    required String svgName,
    required Color actionColor,
    required double width,
    required Function() onTap,
    double? right,
  }) {
    return Expanded(
      flex: 0,
      child: Padding(
        padding: EdgeInsets.only(right: right ?? 0),
        child: CommonSvgButton(
          width: width,
          name: svgName,
          color: actionColor,
          onTap: onTap,
        ),
      ),
    );
  }

  wContainer({
    required String svgName,
    required String actionText,
    required Color color,
    required Function() onTap,
  }) {
    return Expanded(
      child: CommonContainer(
        onTap: onTap,
        radius: 7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgAsset(name: svgName, width: 25, color: color),
            CommonSpace(height: 10),
            CommonText(text: actionText, color: color)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TodoClass todo = TodoClass(
      id: id,
      isHighlighter: isHighlight == true,
      type: todoType,
      name: name,
      memo: memo,
    );

    onMark() {
      //
    }

    onEdit() {
      navigatorPop(context);

      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => TodoSettingPage(
            isEdit: true,
            editTodo: todo,
          ),
        ),
      );
    }

    onRemove() {
      // context.read<CategoryProvider>().removeTodo(todo: todo);
      navigatorPop(context);
    }

    onMore() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => CommonModalSheet(
          title: name,
          height: 200,
          child: Row(
            children: [
              wContainer(
                svgName: 'highlighter',
                actionText: '수정하기',
                color: textColor,
                onTap: onEdit,
              ),
              CommonSpace(width: 5),
              wContainer(
                svgName: 'remove',
                actionText: '삭제하기',
                color: Colors.red.shade200,
                onTap: onRemove,
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: onMore,
      child: Column(
        children: [
          id == '1' ? CommonDivider(color: blue.s50) : CommonNull(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: name,
                              textAlign: TextAlign.start,
                              highlightColor:
                                  isHighlight == true ? color.s50 : null,
                            ),
                            CommonSpace(height: 2),
                            memo != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CommonSpace(width: 3),
                                      svgAsset(
                                        name: 'memo',
                                        width: 10,
                                        color: grey.s400,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 3),
                                        child: SizedBox(
                                          width: 200,
                                          child: CommonText(
                                            text: memo!,
                                            color: grey.original,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const CommonNull()
                          ],
                        )),
                    CommonSpace(width: 30),
                    actionType == eItemActionMark
                        ? wAction(
                            svgName: 'mark-$markType',
                            width: 25,
                            actionColor: itemMarkColor(
                              groupColor: color.s200,
                              markType: markType!,
                            ),
                            onTap: onMark,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.more_horiz,
                              size: 18,
                              color: Colors.grey.shade400,
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
          CommonDivider(color: blue.s50)
        ],
      ),
    );
  }
}
