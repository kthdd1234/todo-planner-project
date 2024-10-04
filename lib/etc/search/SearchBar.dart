
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/provider/KeywordProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class SearchItemBar extends StatefulWidget {
  const SearchItemBar({super.key});

  @override
  State<SearchItemBar> createState() => _SearchItemBarState();
}

class _SearchItemBarState extends State<SearchItemBar> {
  TextEditingController textEditingController = TextEditingController();

  onChanged(_) {
    if (textEditingController.text == '') {
      context.read<KeywordProvider>().changeKeyword('');
    }

    setState(() {});
  }

  onEditingComplete() {
    context.read<KeywordProvider>().changeKeyword(textEditingController.text);
    FocusScope.of(context).unfocus();
  }

  onSuffixIcon() {
    if (textEditingController.text != '') {
      context.read<KeywordProvider>().changeKeyword('');
      textEditingController.text = '';

      setState(() {});
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc:
              '${ymdFullFormatter(locale: context.locale.toString(), dateTime: DateTime.now())}\n 이전 내역만 검색돼요.',
          buttonText: '확인',
          height: 175,
          onTap: () => navigatorPop(context),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 7, right: 7),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: textEditingController,
          style: TextStyle(
            color: isLight ? textColor : darkTextColor,
            fontWeight: isLight ? FontWeight.normal : FontWeight.bold,
            fontSize: 13,
          ),
          cursorColor: isLight ? indigo.s200 : darkTextColor,
          cursorHeight: 14,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 5),
            hintText: '이전의 할 일 또는 메모 검색',
            hintStyle: TextStyle(color: grey.s400, fontSize: 13),
            filled: true,
            fillColor: isLight ? Colors.white : const Color(0xff3D3E4B),
            prefixIcon: UnconstrainedBox(
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: isLight ? indigo.s100 : darkNotSelectedBgColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: onSuffixIcon,
              child: Icon(
                textEditingController.text != ''
                    ? Icons.close_rounded
                    : Icons.info_outline_rounded,
                color: grey.s300,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
