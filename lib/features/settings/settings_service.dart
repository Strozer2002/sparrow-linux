import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
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

  void putCrypts(List<Crypt> crypts) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.crypts = crypts;
      putSettings(settings);
    }
  }

  List<Crypt>? getCrypt() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.crypts;
    }
    return null;
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

  void putHexSeedMnemonic(String hexSeedMnemonic) {
    Settings? settings = getSettings();
    if (settings != null) {
      settings.hexSeedMnemonic = hexSeedMnemonic;
      putSettings(settings);
    } else {
      putSettings(
        Settings(hexSeedMnemonic: hexSeedMnemonic),
      );
    }
  }

  String? getHexSeedMnemonic() {
    Settings? settings = getSettings();
    if (settings != null) {
      return settings.hexSeedMnemonic;
    }
    return null;
  }

  SettingsService._() {
    box = Hive.box<Settings>('settings');
  }

  factory SettingsService() => instance;
}
