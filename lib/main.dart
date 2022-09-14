import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vingtun/IAP/user_purchases.dart';
import 'package:vingtun/app_lifecycle/app_lifecycle.dart';
import 'package:vingtun/audio/audio_controller.dart';
import 'package:vingtun/crashlytics/crashlytics.dart';
import 'package:vingtun/l10n/locale.dart';
import 'package:vingtun/settings/persistance/local_storage_settings_persistance.dart';
import 'package:vingtun/settings/persistance/settings_persistance.dart';
import 'package:vingtun/settings/settings_controller.dart';
import 'package:vingtun/settings/theme_provider.dart';
import 'package:vingtun/ui/introduction/intro_screen.dart';
import 'package:vingtun/widgets/game_coins.dart';
import 'package:timezone/data/latest.dart' as tz;

// Gives the option to override in tests.
class IAPConnection {
  static InAppPurchase? _instance;
  static set instance(InAppPurchase value) {
    _instance = value;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }
}

Future<void> main() async {
  FirebaseCrashlytics? crashlytics;
  // if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
  //   try {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform,
  //     );
  //     crashlytics = FirebaseCrashlytics.instance;
  //   } catch (e) {
  //     debugPrint("Firebase couldn't be initialized: $e");
  //   }
  // }

  await guardWithCrashlytics(
    guardedMain,
    crashlytics: crashlytics,
  );
}

/// Without logging and crash reporting, this would be `void main()`.
void guardedMain() async {
  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  FlutterNativeSplash.remove();
  await EasyLocalization.ensureInitialized();

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  // InAppPurchaseController? inAppPurchaseController;
  // if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
  //   inAppPurchaseController = InAppPurchaseController(InAppPurchase.instance)
  //     // Subscribing to [InAppPurchase.instance.purchaseStream] as soon
  //     // as possible in order not to miss any updates.
  //     ..subscribe();
  //   // Ask the store what the player has bought already.
  //   inAppPurchaseController.restorePurchases();
  // }

  final GameCoins coinBank = await GameCoins.fromPreferences();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()..initialize(),
        ),
        ChangeNotifierProvider<GameCoins>.value(
          value: coinBank,
        )
      ],
      child: EasyLocalization(
        path: 'assets/l10n',
        fallbackLocale: L10n.all[0],
        supportedLocales: L10n.all,
        child: MyApp(
          // inAppPurchaseController: inAppPurchaseController,
          settingsPersistence: LocalStorageSettingsPersistence(),
        ),
      ),
    ),
  );
}

Logger _log = Logger('main.dart');

// initializes app after 500ms
Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(milliseconds: 500));
}

class MyApp extends StatelessWidget {
  final SettingsPersistence settingsPersistence;
  // final InAppPurchaseController? inAppPurchaseController;

  const MyApp({
    required this.settingsPersistence,
    // required this.inAppPurchaseController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: Consumer<ThemeProvider>(builder: (context, provider, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<UserPurchases>(
              create: (context) => UserPurchases(
                context.read<GameCoins>(),
              ),
              lazy: false,
            ),
            Provider<SettingsController>(
              lazy: false,
              create: (context) => SettingsController(
                persistence: settingsPersistence,
              )..loadStateFromPersistence(),
            ),
            // ChangeNotifierProvider<InAppPurchaseController?>.value(
            //     value: inAppPurchaseController),
            ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,
                AudioController>(
              // Ensures that the AudioController is created on startup,
              // and not "only when it's needed", as is default behavior.
              // This way, music starts immediately.
              lazy: false,
              create: (context) => AudioController()..initialize(),
              update: (context, settings, lifecycleNotifier, audio) {
                if (audio == null) throw ArgumentError.notNull();
                audio.attachSettings(settings);
                audio.attachLifecycleNotifier(lifecycleNotifier);
                return audio;
              },
              dispose: (context, audio) => audio.dispose(),
            ),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp(
                theme: ThemeData.light().copyWith(
                  appBarTheme: const AppBarTheme(
                    foregroundColor: Colors.black,
                    iconTheme: IconThemeData(color: Colors.black),
                  ),
                ),
                darkTheme: ThemeData.dark().copyWith(
                  // textTheme:
                  //     GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
                  appBarTheme: const AppBarTheme(
                    foregroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                ),
                themeMode: provider.themeMode,
                home: const IntroScreen(),
                // home: showHome ? MenuScreen() : IntroScreen(),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
              );
            },
          ),
        );
      }),
    );
  }
}
