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

  Image walletIcon({double? width, double? height, BoxFit? fit}) => Image.asset(
        _name('icons/walletIcon.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
  Image sparrowIcon({double? width, double? height, BoxFit? fit}) =>
      Image.asset(
        _name('icons/10241.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
  Image light({double? width, double? height, BoxFit? fit}) => Image.asset(
        _name('icons/light.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
  Image eco({double? width, double? height, BoxFit? fit}) => Image.asset(
        _name('icons/eco.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );

  Image sparrow_logo48({double? width, double? height, BoxFit? fit}) =>
      Image.asset(
        _name('icons/sparrow_logo48.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );

  Image crypto({String? value, double? width, double? height, BoxFit? fit}) =>
      Image.asset(
        _name('crypto/$value.png'),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
}
