import 'package:flutter/material.dart';

class ImageCollection {
  final String _defaultPath = 'assets/';

  String _name(String name) => _defaultPath + name;

  // Example
  Image rabbitBank({double? width, double? height, BoxFit? fit}) => Image.asset(
        _name('objects/rabbitBank.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
}
