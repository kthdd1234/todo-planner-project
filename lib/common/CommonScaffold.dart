import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:provider/provider.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    super.key,
    required this.body,
    this.appBarInfo,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.padding,
  });

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset;
  Widget? floatingActionButton;
  Color? backgroundColor;
  EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              foregroundColor: isLight ? Colors.black : darkTextColor,
              title: CommonText(
                text: appBarInfo!.title,
                fontSize: appBarInfo!.fontSize ?? 18,
                isBold: !isLight,
                isNotTr: appBarInfo!.isNotTr,
              ),
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: backgroundColor ?? Colors.transparent,
              scrolledUnderElevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(10),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

// class Fab extends StatelessWidget {
//   Fab({super.key, required this.isFab});

//   bool? isFab;

//   @override
//   Widget build(BuildContext context) {
//     bool isLight = context.watch<ThemeProvider>().isLight;

//     return isFab == true
//         ? MultiValueListenableBuilder(
//             valueListenables: valueListenables,
//             builder: (context, values, child) {
//               DateTime selectedDateTime =
//                   context.watch<SelectedDateTimeProvider>().seletedDateTime;
//               bool isToday =
//                   dateTimeKey(DateTime.now()) == dateTimeKey(selectedDateTime);
//               bool isNotMonth = userRepository.user.calendarFormat !=
//                   CalendarFormat.month.toString();

//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   isNotMonth
//                       ? isToday
//                           ? const CommonNull()
//                           : const TodayButton()
//                       : const CommonNull(),
//                   AddButton(isLight: isLight),
//                 ],
//               );
//             })
//         : const CommonNull();
//   }
// }

// class Bnb extends StatelessWidget {
//   Bnb({super.key, this.bnb});

//   Widget? bnb;

//   @override
//   Widget build(BuildContext context) {
//     return bnb != null
//         ? MultiValueListenableBuilder(
//             valueListenables: valueListenables,
//             builder: (context, values, child) {
//               bool isNotMonth = userRepository.user.calendarFormat !=
//                   CalendarFormat.month.toString();

//               return isNotMonth ? bnb! : const CommonNull();
//             })
//         : const CommonNull();
//   }
// }
