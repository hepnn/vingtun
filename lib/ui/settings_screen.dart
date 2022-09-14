import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/settings/services/local_notifications_service.dart';
import 'package:vingtun/settings/settings_controller.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/ui/language_screen.dart';
import 'package:vingtun/ui/menu_screen.dart';
import 'package:vingtun/utils/Round.dart';
import 'package:vingtun/utils/database.dart';
import 'package:vingtun/widgets/appbar.dart';
import 'package:vingtun/widgets/dialogs.dart';

import '../notifications/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const _gap = SizedBox(height: 20);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Round> _rounds = [];
  bool isSwitchedNotif = true;
  final _controllerSwitch = ValueNotifier<bool>(false);

  @override
  void initState() {
    NotificationApi.init(initScheduled: true);
    listenNotifications();
    getData();
    switchController();
    super.initState();
  }

  void switchController() {
    _controllerSwitch.addListener(() {
      setState(() {
        if (_controllerSwitch.value) {
          isSwitchedNotif = true;
          print('true');
          setState(() {
            NotificationApi.showScheduledNotificationDailyBases(
              title: 'Daily Bonus available',
              body: 'Remember to flip your cards today',
              scheduledDate: const Time(15, 0),
            );
          });
        } else {
          isSwitchedNotif = false;
          print('false');
        }
      });
    });
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuScreen(
                payload: payload,
              )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildThemeSelect(context),
            _buildAudioSelect(context),
            _buildNotificationSelect(),
            _buildLanguageSelect(),
            _buildDeleteData()
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelect(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Card(
      child: Consumer<ThemeProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            RadioListTile(
              activeColor: theme ? Colors.white : Colors.black,
              title: Text(tr('System')),
              value: 'system',
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: provider.currentTheme,
              onChanged: (String? value) {
                provider.changeTheme(value ?? 'system');
              },
            ),
            RadioListTile(
              activeColor: Colors.black,
              title: Text(tr('Light')),
              value: 'light',
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: provider.currentTheme,
              onChanged: (String? value) {
                provider.changeTheme(value ?? 'light');
              },
            ),
            RadioListTile(
              activeColor: Colors.white,
              title: Text(tr('Dark')),
              value: 'dark',
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: provider.currentTheme,
              onChanged: (String? value) {
                provider.changeTheme(value ?? 'dark');
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAudioSelect(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: settings.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                'Sound FX',
                // child: AdvancedSwitch(controller: settings.soundsOn),
                child: Icon(soundsOn ? Icons.music_note : Icons.music_off),
                onSelected: () => settings.toggleSoundsOn(),
              ),
            ),
            SettingsScreen._gap,
            ValueListenableBuilder<bool>(
              valueListenable: settings.musicOn,
              builder: (context, musicOn, child) => _SettingsLine(
                'Music',
                child: Icon(musicOn ? Icons.music_note : Icons.music_off),
                onSelected: () => settings.toggleMusicOn(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSelect() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
                valueListenable: _controllerSwitch,
                builder: ((context, value, child) {
                  return _SettingsLine('Notifications',
                      child: AdvancedSwitch(
                        controller: _controllerSwitch,
                      ));
                })),

            // FlutterSwitch(
            //   // implement scheduled notifications
            //   // make smaller
            //   activeColor: Colors.white,
            //   toggleColor: Colors.black38,
            //   value: notificationSwitch,
            //   onToggle: (val) async {
            //     await notificationService.showScheduledNotification(
            //       id: 0,
            //       title: 'Notification Title',
            //       body: 'Some body',
            //       seconds: 1,
            //     );
            //     setState(() {
            //       notificationSwitch = val;
            //     });
            //   },
            // ),
            // ValueListenableBuilder<bool>(
            //   valueListenable: settings.notificationsOn,
            //   builder: (context, notificationsOn, child) => _SettingsLine(
            //     'Notifications',
            //     child: AdvancedSwitch(controller: settings.notificationsOn),
            //     onSelected: () async {
            //       await notificationService.showScheduledNotification(
            //           id: 0,
            //           title: 'Vingtun',
            //           body: 'Remember to flip your cards today',
            //           seconds: 1);
            //       settings.toggleNotificationsOn();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelect() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _SettingsLine(
            'Languages',
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                    PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation1, animation2) =>
                            LanguageScreen()));
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildDeleteData() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _SettingsLine(
              'Reset Data',
              child: IconButton(
                icon: Icon(Icons.restore),
                onPressed: () {
                  deleteData();
                  getData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteData() async {
    DbSQLite.deleteData('historic');
  }

  void getData() async {
    _rounds = await DbSQLite.getData('historic');
  }

  // void listenToNotification() {
  //   notificationService.onNotificationClick.stream
  //       .listen(onNotificationListener);
  // }

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget child;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, {this.onSelected, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 14,
              )),
          const Spacer(),
          InkResponse(onTap: onSelected, child: child),
        ],
      ),
    );
  }
}
