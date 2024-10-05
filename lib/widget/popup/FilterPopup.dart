
// import 'package:flutter/material.dart';
// import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
// import 'package:project/common/CommonContainer.dart';
// import 'package:project/common/CommonDivider.dart';
// import 'package:project/common/CommonNull.dart';
// import 'package:project/common/CommonPopup.dart';
// import 'package:project/common/CommonSwitch.dart';
// import 'package:project/common/CommonText.dart';
// import 'package:project/model/user_box/user_box.dart';
// import 'package:project/provider/themeProvider.dart';
// import 'package:project/util/constants.dart';
// import 'package:project/util/final.dart';
// import 'package:project/util/func.dart';
// import 'package:provider/provider.dart';

// class FilterPopup extends StatefulWidget {
//   const FilterPopup({super.key});

//   @override
//   State<FilterPopup> createState() => _FilterPopupState();
// }

// class _FilterPopupState extends State<FilterPopup> {
//   UserBox user = userRepository.user;

//   onChanged(String id, bool newValue) async {
//     isSearchCategory(id) == true
//         ? user.filterIdList?.remove(id)
//         : user.filterIdList?.add(id);

//     await user.save();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isLight = context.watch<ThemeProvider>().isLight;

//     return MultiValueListenableBuilder(
//       valueListenables: valueListenables,
//       builder: (context, values, child) => CommonPopup(
//         insetPaddingHorizontal: 40,
//         height: 435,
//         child: CommonContainer(
//           child: Column(
//             children: [
//               CommonText(
//                 text: '표시 설정',
//                 isBold: true,
//                 color: isLight ? textColor : darkTextColor,
//                 fontSize: 13,
//               ),
//               Column(
//                 children: filterItemList
//                     .map((item) => FilterItem(
//                           isLight: isLight,
//                           id: item.id,
//                           svg: item.svg,
//                           name: item.name,
//                           isVisible: isSearchCategory(item.id),
//                           onChanged: onChanged,
//                         ))
//                     .toList(),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FilterItem extends StatelessWidget {
//   FilterItem({
//     super.key,
//     required this.isLight,
//     required this.id,
//     required this.name,
//     required this.isVisible,
//     required this.onChanged,
//     this.svg,
//   });

//   String id, name;
//   bool isVisible, isLight;
//   String? svg;
//   Function(String, bool) onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(top: 10, bottom: id != 'image' ? 10 : 0),
//           child: Row(
//             children: [
//               svg != null
//                   ? Padding(
//                       padding: const EdgeInsets.only(top: 1.5, right: 10),
//                       child: svgAsset(
//                         name: 'mark-$svg',
//                         width: 15,
//                         color: isLight ? textColor : indigo.s300,
//                       ),
//                     )
//                   : const CommonNull(),
//               CommonText(text: name, isBold: !isLight),
//               const Spacer(),
//               CommonSwitch(
//                 activeColor: indigo.s300,
//                 value: isVisible,
//                 onChanged: (newValue) => onChanged(id, newValue),
//               )
//             ],
//           ),
//         ),
//         id != 'image'
//             ? CommonDivider(color: isLight ? grey.s200 : Colors.white12)
//             : const CommonNull(),
//       ],
//     );
//   }
// }
