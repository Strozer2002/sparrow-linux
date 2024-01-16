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
  SvgPicture get switch_off => SvgPicture.asset(_name('icons/switch_off'));
  SvgPicture get switch_yellow => SvgPicture.asset(_name('icons/switch_yelow'));
  SvgPicture get switch_green => SvgPicture.asset(_name('icons/switch_green'));
  SvgPicture get switch_blue => SvgPicture.asset(_name('icons/switch_blue'));
  SvgPicture get tools => SvgPicture.asset(_name('icons/tools'));
  SvgPicture get server => SvgPicture.asset(_name('icons/server'));
  SvgPicture get eye => SvgPicture.asset(_name('icons/eye'));
  SvgPicture get access => SvgPicture.asset(_name('icons/access'));

  SvgPicture get transactions => SvgPicture.asset(_name('icons/transactions'));
  SvgPicture get send => SvgPicture.asset(_name('icons/send'));

  SvgPicture get address => SvgPicture.asset(_name('icons/address'));
  SvgPicture get settings => SvgPicture.asset(_name('icons/settings'));

  SvgPicture get logo => SvgPicture.asset(_name('icons/logo'));
  SvgPicture get chevron => SvgPicture.asset(_name('icons/chevron'));
  SvgPicture get plus => SvgPicture.asset(_name('icons/plus'));
  SvgPicture get importPlus => SvgPicture.asset(_name('icons/importPlus'));
  SvgPicture get wallets => SvgPicture.asset(_name('icons/wallets'));
  SvgPicture get lock => SvgPicture.asset(_name('icons/lock'));
  SvgPicture get pen => SvgPicture.asset(_name('icons/pen'));
  SvgPicture get phrase => SvgPicture.asset(_name('icons/phrase'));
  SvgPicture get key => SvgPicture.asset(_name('icons/key'));

  // bottom nav bar
  SvgPicture get clearAll => SvgPicture.asset(_name('icons/clearAll'));

  SvgPicture wallet({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('icons/wallet'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture import({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('icons/import'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture receive({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('icons/receive'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture get walletSend => SvgPicture.asset(_name('icons/walletSend'));
  SvgPicture get walletPlus => SvgPicture.asset(_name('icons/walletPlus'));
  //home
  SvgPicture get vector => SvgPicture.asset(_name('icons/vector'));
  SvgPicture get recive => SvgPicture.asset(_name('icons/recive'));

  SvgPicture upper({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('icons/upper'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
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

  SvgPicture get arbitrum => SvgPicture.asset(_name('crypto/arbitrum'));

  SvgPicture crypto({
    String? value,
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('crypto/$value'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
}
