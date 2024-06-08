import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/func.dart';

class ImageSlidePage extends StatefulWidget {
  ImageSlidePage({super.key, required this.xFileList, required this.curIndex});

  List<XFile> xFileList;
  int curIndex;

  @override
  State<ImageSlidePage> createState() => _ImageSlidePageState();
}

class _ImageSlidePageState extends State<ImageSlidePage> {
  int selectedIndex = 0;

  @override
  initState() {
    selectedIndex = widget.curIndex;
    super.initState();
  }

  onPageChanged(int index, _) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Scaffold(
          appBar: AppBar(
            title: CommonText(
              text: '${selectedIndex + 1}/${widget.xFileList.length}',
              color: Colors.white,
              fontSize: 14,
              isBold: true,
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              onPressed: () => navigatorPop(context),
            ),
          ),
          backgroundColor: Colors.black,
          body: CarouselSlider(
            items: widget.xFileList
                .map(
                  (xFile) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(child: Image.file(File(xFile.path))),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              initialPage: selectedIndex,
              height: MediaQuery.of(context).size.height,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: onPageChanged,
            ),
          )),
    );
  }
}