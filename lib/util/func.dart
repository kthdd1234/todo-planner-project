import 'package:flutter_svg/flutter_svg.dart';

SvgPicture svgAsset({required String name, required double width}) {
  return SvgPicture.asset('assets/svg/$name.svg', width: width);
}
