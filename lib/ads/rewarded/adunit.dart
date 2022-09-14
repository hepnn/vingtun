import 'dart:io';

class AdHelper {
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return ''; // enter your own id
    } else if (Platform.isIOS) {
      return '';// enter your own id
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
