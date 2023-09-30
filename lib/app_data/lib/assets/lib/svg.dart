import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Svg {
  final String _defaultPath = 'assets/svg/';

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
  SvgPicture logoAllmetrics({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('Logo'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture iconGoogle({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconGoogle'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture iconApple({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconApple'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture iconEmail({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconEmail'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture iconVisibility({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconVisibility'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture iconVisibilityOff({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconVisibilityOff'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture iconAgency({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconAgency'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture iconSubdomain({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconSubdomain'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture iconSignIn({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconSignIn'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture iconSearch({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconSearch'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  // Bottom Nav Bar
  SvgPicture bottomHome({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomHome'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture bottomHomeActive({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomHomeActive'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture formIconOutlined({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomForms'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture bottomFormsActive({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomFormsActive'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture bottomVisit({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomVisit'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture bottomVisitActive({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomVisitActive'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture bottomProfile({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomProfile'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture bottomProfileActive({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('bottomProfileActive'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  // Navigation
  SvgPicture backSpaceButton({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('backSpaceButton'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture iconNext({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('iconNext'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  // Profile
  SvgPicture profileImageEdit({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('profileImageEdit'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture profileEdit({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('profileEdit'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture profileLanguage({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('profileLanguage'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture profileMail({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('profileMail'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture profileNotification({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('profileNotification'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture profilePassword({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('profilePassword'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture profileSave({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('profileSave'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  // Questions
  SvgPicture questionCalendar({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('question_calendar'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture questionPhoto({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionPhoto'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture questionQr({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionQr'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture questionBoolPhoto({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionBoolPhoto'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture questionMicro({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionMicro'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture microphoneIcon({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('microphone'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture deleteIcon({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('delete_icon'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture questionLocation({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionLocation'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture questionCheckbox({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionCheckbox'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );
  SvgPicture questionCheckBoxTrue({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionCheckBoxTrue'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture questionComment({
    Color? color,
    double? size,
  }) =>
      SvgPicture.asset(
        _name('questionComment'),
        colorFilter: _getColorFilterFromColor(color),
        width: size,
      );

  SvgPicture get formDefault => SvgPicture.asset(_name('form-default'));
  SvgPicture get formDone => SvgPicture.asset(_name('form-done'));
  SvgPicture get alarmIcon => SvgPicture.asset(_name('alarm-icon'));
  SvgPicture get priorityRedIcon => SvgPicture.asset(_name('priority-high'));
  SvgPicture get visitDefault => SvgPicture.asset(_name('visit-default'));
  SvgPicture get projectIcon => SvgPicture.asset(_name('project-icon'));
  SvgPicture get showOnMapIcon => SvgPicture.asset(_name('show-on-map-icon'));
  SvgPicture get calendarIcon => SvgPicture.asset(_name('calendar-icon'));
  SvgPicture get formIcon => SvgPicture.asset(_name('form-icon'));
  SvgPicture get locationIcon => SvgPicture.asset(_name('location-icon'));
  SvgPicture get moneyIcon => SvgPicture.asset(_name('money-icon'));
  SvgPicture get priorityGrayIcon =>
      SvgPicture.asset(_name('priority-gray-icon'));
  SvgPicture upcomingIcon({
    Color? color,
  }) =>
      SvgPicture.asset(
        _name('upcoming'),
        colorFilter: _getColorFilterFromColor(color),
      );
  SvgPicture pastIcon({
    Color? color,
  }) =>
      SvgPicture.asset(
        _name('past'),
        colorFilter: _getColorFilterFromColor(color),
      );
  SvgPicture get alarmFilled => SvgPicture.asset(_name('alarm-filled'));
}
