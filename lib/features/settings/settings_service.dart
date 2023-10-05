import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:rabby/features/settings/domain/settings.dart';

class SettingsService {
  static final SettingsService instance =
      GetIt.I.registerSingleton(SettingsService._());
  Box<Settings>? box;

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

  SettingsService._() {
    box = Hive.box<Settings>('settings');
  }

  factory SettingsService() => instance;
}
