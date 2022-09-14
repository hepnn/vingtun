import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:vingtun/utils/notifications.dart';

class NotificationApi {
  /// first initialize notification package
  static final _notifications = FlutterLocalNotificationsPlugin();

  /// We want to also listen notifications therefore we need to go main page and put the call NotificationApi's init method inside the main init method.
  static final onNotifications = BehaviorSubject<String?>();

  /// In Android our notification is links to a channel therefore we need to create channel
  /// Whenever change details make sure that chancing the channel ID (channel Id 1 etc.)
  static Future notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "channel Id", "channelName", channelDescription: 'channelDescription',
          // importance: Importance.max ///if you don't want to show notification on app , take command line here.
        ),
        iOS: IOSNotificationDetails());
  }

  /// implementing functionality is ;
  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = IOSInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: android, iOS: ios);

    /// When app is closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await _notifications.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
    if (initScheduled) {
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _notifications.show(id, title, body, await notificationDetails(),
        payload: payload);
  }

  /// Scheduled notification need TimeZone or Native Time Zone plugin and you need to initialize in main
  static Future showScheduledNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime scheduledDate}) async {
    //scheduledDate mandatory
    return _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    /// if we want to send notification daily bases wee need to put "matchDateTimeComponents: DateTimeComponents.time" in zonedSchedule method
    /// and put a method
  }

  /// if we want to send notification daily bases wee need to put "matchDateTimeComponents: DateTimeComponents.time" in zonedSchedule method
  static Future showScheduledNotificationDailyBases(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required Time scheduledDate}) async {
    //scheduledDate mandatory
    return _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduleWeekly(scheduledDate,
            days: [DateTime.monday, DateTime.friday]),

        ///if you want specific day for notification
        ///you can add "days:[DateTime.monday,DateTime.tuesday]"
        /// We set notification at 8 am every morning
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);

    /// and put a method
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduledDate.isBefore(now)

        /// We check that whether before
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);
    while (days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static void cancel(int id) => _notifications.cancel(id);

  /// cancel via specific id
  static void cancelAll() => _notifications.cancelAll();

  /// cancel all
}
