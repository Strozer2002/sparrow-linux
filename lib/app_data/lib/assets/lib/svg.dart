import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Svg {
  final String _defaultPath = 'assets/';

  String _name(String name) {
    if (name.endsWith('.svg')) {
      return _defaultPath + name;
    } else {
      return '$_defaultPath$name.svg';
    }
  }

  ColorFilter? _getColorFilterFromColor(Color? color) =>
      color == null ? null : ColorFilter.mode(color, BlendMode.srcIn);

  // Auth
  SvgPicture rabbitBank({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('objects/rabbitBank'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  // SvgPicture get formDefault => SvgPicture.asset(_name('form-default'));

  SvgPicture get logo => SvgPicture.asset(_name('icons/logo'));
  SvgPicture get chevron => SvgPicture.asset(_name('icons/chevron'));
  SvgPicture get plus => SvgPicture.asset(_name('icons/plus'));
  SvgPicture get import => SvgPicture.asset(_name('icons/import'));
  SvgPicture get wallets => SvgPicture.asset(_name('icons/wallets'));
  SvgPicture get lock => SvgPicture.asset(_name('icons/lock'));
  SvgPicture get pen => SvgPicture.asset(_name('icons/pen'));
  SvgPicture star({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('icons/star'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture rabbit({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('objects/rabbit'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
}
