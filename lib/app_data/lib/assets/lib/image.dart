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

  Image party({double? width, double? height, BoxFit? fit}) => Image.asset(
        _name('icons/party.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
  Image pen({double? width, double? height, BoxFit? fit}) => Image.asset(
        _name('icons/pen.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
}
