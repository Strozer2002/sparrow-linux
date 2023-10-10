import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:rabby/features/settings/domain/settings.dart';

import '../../../app_data/app_data.dart';

class SettingsService {
  static final SettingsService instance =
      GetIt.I.registerSingleton(SettingsService._());
  Box<Settings>? box;

  bool _isRelocate = false;
  final List<Function(bool)> _listeners = [];

  set isRelocate(bool newValue) {
    _isRelocate = newValue;
    _notifyListeners(newValue);
  }

  bool get isRelocate => _isRelocate;

  void addListener(Function(bool) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(bool) listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(bool value) {
    for (var listener in _listeners) {
      listener(value);
    }
  }

  void relocate() {
    if (getPassCode() != null && isRelocate == true) {
      print("Relocate resume");
      isRelocate = false;
      AppData.routesConfig.routerConfig.go(AppData.routes.setCode);
    }
  }

  void relocateChild() =>
      AppData.routesConfig.routerConfig.push(AppData.routes.setCode);

  void lockApp(bool value) {
    print("Relocate $value");
    if (value == true) {
      print("Entry in...");
      print(getDuration().toString());
      Future.delayed(Duration(minutes: getDuration()!), () {
        print("Try to relocate...");
        if (getPassCode() != null &&
            isRelocate == true &&
            getAutoLock() == true) {
          print("Relocate with ${getDuration()} min");
          isRelocate = false;
          AppData.routesConfig.routerConfig.push(AppData.routes.setCode);
        }
      });
    }
  }

  void boxClear() {
    box!.clear();
  }

  void putSettings(Settings settings) {
    box!.put('settings', settings);
  }

  Settings? getSettings() {
    return box!.get('settings');
  }

  void putPassCode(String passcode) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.userPassCode = passcode;
      putSettings(settings);
    } else {
      putSettings(
        Settings(userPassCode: passcode),
      );
    }
  }

  String? getPassCode() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.userPassCode;
    }
    return null;
  }

  void putAutoLock(bool isAutoLock) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.isAutoLock = isAutoLock;
      putSettings(settings);
    } else {
      putSettings(
        Settings(isAutoLock: isAutoLock),
      );
    }
  }

  bool? getAutoLock() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.isAutoLock;
    }
    return null;
  }

  void putDuration(int duration) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.autoLockDuration = duration;
      putSettings(settings);
    } else {
      putSettings(
        Settings(autoLockDuration: duration),
      );
    }
  }

  int? getDuration() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.autoLockDuration;
    }
    return null;
  }

  void putTheme(bool isLightTheme) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.isLightTheme = isLightTheme;
      putSettings(settings);
    } else {
      putSettings(
        Settings(isLightTheme: isLightTheme),
      );
    }
  }

  bool? getTheme() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.isLightTheme;
    }
    return null;
  }

  void putMnemonicSentence(String mnemonicSentence) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.mnemonicSentence = mnemonicSentence;
      putSettings(settings);
    } else {
      putSettings(
        Settings(mnemonicSentence: mnemonicSentence),
      );
    }
  }

  String? getMnemonicSentence() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.mnemonicSentence;
    }
    return null;
  }

  void putPrivateKey(String privateKey) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.privateKey = privateKey;
      putSettings(settings);
    } else {
      putSettings(
        Settings(privateKey: privateKey),
      );
    }
  }

  String? getPrivateKey() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.privateKey;
    }
    return null;
  }

  SettingsService._() {
    box = Hive.box<Settings>('settings');
  }

  factory SettingsService() => instance;
}
