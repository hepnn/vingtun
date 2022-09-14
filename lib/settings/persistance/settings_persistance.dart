/// An interface of persistence stores for settings.
///
/// Implementations can range from simple in-memory storage through
/// local preferences to cloud-based solutions.
abstract class SettingsPersistence {
  Future<bool> getMusicOn();

  Future<bool> getMuted({required bool defaultValue});

  Future<bool> getSoundsOn();

  Future<bool> getNotificationsOn();

  Future<void> saveMusicOn(bool value);

  Future<void> saveMuted(bool value) ;

  Future<void> saveSoundsOn(bool value);

  Future<void> saveNotificationsOn(bool value);
}
