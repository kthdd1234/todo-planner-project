import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/util/class.dart';

class TodoGroupBtnList extends StatelessWidget {
  const TodoGroupBtnList({super.key});

  @override
  Widget build(BuildContext context) {
    onEdit() {
      //
    }

    onCalendar() {
      //
    }

    onTimeLine() {
      //
    }

    List<Widget> children = [
      TodoGroupBtnClass(assetName: 'edit-pencil', onTap: onEdit),
      TodoGroupBtnClass(assetName: 'calendar-check', onTap: onCalendar),
      TodoGroupBtnClass(assetName: 'timeline', onTap: onTimeLine),
    ]
        .map((item) => Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CommonSvgButton(
                name: item.assetName,
                width: item.assetName == 'edit-pencil' ? 18 : 20,
                color: Colors.grey.shade400,
                onTap: item.onTap,
              ),
            ))
        .toList();

    return Row(children: children);
  }
}
