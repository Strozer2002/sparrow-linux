import 'package:flutter/material.dart';

class ImageCollection {
  final String _defaultPath = 'assets/icons/';

  String _name(String name) => _defaultPath + name;

  // Example
  Image authIcon({double? width, double? height, BoxFit? fit}) => Image.asset(
        _name('auth_icon.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
}
