import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'services/notification_service.dart';
import 'package:anti_moustique/custom_code/actions/device_connection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Conditional import to handle platform-specific code
import 'dart:io' if (dart.library.io) 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Initialize NotificationService
  await NotificationService().init();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class PlatformUtils {
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  late NotificationService notificationService; // Add this
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    notificationService = NotificationService(); // Initialize NotificationService here

    if (PlatformUtils.isAndroid) {
      FlutterBluePlus.turnOn();
    }

    // Initialize the refresh timer
    _refreshTimer = Timer.periodic(const Duration(minutes: 10), (timer) {
      print('Refreshing devices...');
      FFAppState().update(() {
        refreshAllDevices(FFAppState().deviceList);
      });
    });

    setState(() {});
  }

  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
  });

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Moustibox',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
