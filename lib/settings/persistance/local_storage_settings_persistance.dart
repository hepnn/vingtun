import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/settings/persistance/settings_persistance.dart';

/// An implementation of [SettingsPersistence] that uses
/// `package:shared_preferences`.
class LocalStorageSettingsPersistence extends SettingsPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  @override
  Future<bool> getMusicOn() async {
    final prefs = await instanceFuture;
    return prefs.getBool('musicOn') ?? true;
  }

  @override
  Future<bool> getMuted({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('mute') ?? defaultValue;
  }

  @override
  Future<bool> getSoundsOn() async {
    final prefs = await instanceFuture;
    return prefs.getBool('soundsOn') ?? true;
  }

  @override
  Future<bool> getNotificationsOn() async {
    final prefs = await instanceFuture;
    return prefs.getBool('notificationsOn') ?? true;
  }

  @override
  Future<void> saveMusicOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('musicOn', value);
  }

  @override
  Future<void> saveMuted(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('mute', value);
  }

  @override
  Future<void> saveSoundsOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('soundsOn', value);
  }

  @override
  Future<void> saveNotificationsOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('notificationsOn', value);
  }
}
