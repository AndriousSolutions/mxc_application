///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  24 Dec 2018
///

import 'dart:async' show Future, StreamSubscription;

import 'package:flutter/foundation.dart'
    show Key, mustCallSuper, protected, required;

import 'package:flutter/material.dart'
    show
        AsyncSnapshot,
        AppLifecycleState,
        BuildContext,
        Color,
        ColorSwatch,
        ConnectionState,
        Drawer,
        DrawerHeader,
        FutureBuilder,
        GenerateAppTitle,
        GlobalKey,
        Key,
        ListTile,
        ListView,
        Locale,
        LocaleResolutionCallback,
        LocalizationsDelegate,
        MaterialApp,
        Navigator,
        NavigatorObserver,
        NavigatorState,
        RouteFactory,
        Scaffold,
        ScaffoldState,
        State,
        StatefulWidget,
        StatelessWidget,
        Text,
        Theme,
        ThemeData,
        TransitionBuilder,
        Widget,
        WidgetBuilder,
        mustCallSuper;

import 'package:connectivity/connectivity.dart'
    show Connectivity, ConnectivityResult;

import 'package:mxc_application/mvc.dart' show AppError;

import 'package:mxc_application/app.dart' show AppMVC, AppConMVC;

import 'package:mxc_application/controller.dart' show ControllerMVC, DeviceInfo;

import 'package:mxc_application/view.dart'
    show AppMenu, LoadingScreen, StateMVC;

import 'package:mxc_application/controller.dart' show Assets;

import 'package:mxc_application/model.dart' show Files;

import 'package:mxc_application/model.dart' show InstallFile;

import 'package:prefs/prefs.dart' show Prefs;

import 'package:package_info/package_info.dart' show PackageInfo;

import 'package:flutter/widgets.dart'
    show
        AppLifecycleState,
        BuildContext,
        Color,
        FutureBuilder,
        GenerateAppTitle,
        GlobalKey,
        Key,
        ListView,
        Locale,
        LocaleResolutionCallback,
        LocalizationsDelegate,
        Navigator,
        NavigatorObserver,
        NavigatorState,
        RouteFactory,
        State,
        StatelessWidget,
        Text,
        TransitionBuilder,
        Widget,
        WidgetBuilder,
        mustCallSuper;

import 'package:mxc_application/src/view/utils/loading_screen.dart'
    show LoadingScreen;

/// Highlights UI while debugging.
import 'package:flutter/rendering.dart' as debugPaint;

abstract class App extends AppMVC {
  // You must supply a 'View.'
  App({ControllerMVC con, Key key, this.loadingScreen})
      : super(con: con, key: key);

  @protected
  AppView createView();

  static AppView _vw;
  static AsyncSnapshot get snapshot => _snapshot;
  static AsyncSnapshot _snapshot;
  final Widget loadingScreen;
  static bool hotLoad = false;

  /// More efficient widget tree rebuilds
  static final materialKey = GlobalKey();

  @override
  void initApp() {
    _vw = createView();
    super.initApp();
    _vw.con.initApp();
  }

  @override
  Widget build(BuildContext context) {
    Assets.init(context);
    _context = context;
    return FutureBuilder<bool>(
      future: init(),
      initialData: false,
      builder: (_, snapshot) {
        _snapshot = snapshot;
        if (snapshot.hasError) {
          _vw = AppError(snapshot.error);
          return _AppWidget(snapshot);
        }
        return snapshot.connectionState == ConnectionState.done
            ? (snapshot.hasData && snapshot.data
                ? _AppWidget(snapshot)
                : LoadingScreen())
            : loadingScreen ?? LoadingScreen();
      },
    );
  }

  @override
  Future<bool> init() async {
    if (hotLoad) {
      _vw = createView();
      _vw.con.initApp();
    } else {
      await _initInternal();
      _packageInfo = await PackageInfo.fromPlatform();
    }
    _isInit = await super.init();
    if (_isInit) _isInit = await _vw.init();
    return _isInit;
  }

  @mustCallSuper
  void dispose() {
    _context = null;
    _theme = null;
    _scaffold = null;
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    super.dispose();
  }

  /// Determine if the App initialized successfully.
  static bool get isInit => _isInit;
  static bool _isInit = false;

  static GlobalKey<NavigatorState> get navigatorKey => _vw.navigatorKey;

  static Map<String, WidgetBuilder> get routes => _vw.routes;

  static String get initialRoute => _vw.initialRoute;

  static RouteFactory get onGenerateRoute => _vw.onGenerateRoute;

  static RouteFactory get onUnknownRoute => _vw.onUnknownRoute;

  static List<NavigatorObserver> get navigatorObservers =>
      _vw.navigatorObservers;

  static TransitionBuilder get builder => _vw.builder;

  static String get title => _vw.title;

  static GenerateAppTitle get onGenerateTitle => _vw.onGenerateTitle;

  static ThemeData get theme => _vw.theme ?? App._getTheme();

  static Color get color => _vw.color;

  static Locale get locale => _vw.locale;

  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      _vw.localizationsDelegates;

  static LocaleResolutionCallback get localeResolutionCallback =>
      _vw.localeResolutionCallback;

  static Iterable<Locale> get supportedLocales => _vw.supportedLocales;

  static bool get debugShowMaterialGrid => _vw.debugShowMaterialGrid;

  static bool get showPerformanceOverlay => _vw.showPerformanceOverlay;

  static bool get checkerboardRasterCacheImages =>
      _vw.checkerboardRasterCacheImages;

  static bool get checkerboardOffscreenLayers =>
      _vw.checkerboardOffscreenLayers;

  static bool get showSemanticsDebugger => _vw.showSemanticsDebugger;

  static bool get debugShowCheckedModeBanner => _vw.debugShowCheckedModeBanner;

  static BuildContext get context => _context;
  static BuildContext _context;

  static ThemeData _theme;

  static ScaffoldState _scaffold;

  // Application information
  static PackageInfo _packageInfo;

  static String get appName => _packageInfo?.appName;

  static String get packageName => _packageInfo?.packageName;

  static String get version => _packageInfo?.version;

  static String get buildNumber => _packageInfo?.buildNumber;

  /// Determines if running in an IDE or in production.
  static bool get inDebugger {
    var inDebugMode = false;
    // assert is removed in production.
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static ScaffoldState get scaffold => App._getScaffold();

  static ScaffoldState _getScaffold() {
    if (_scaffold == null) _scaffold = Scaffold.of(_context, nullOk: true);
    return _scaffold;
  }

  static ColorSwatch get colorTheme => AppMenu.colorTheme;

  static ThemeData _getTheme() {
    if (_theme == null) _theme = Theme.of(_context);
    return _theme;
  }

  static getThemeData() {
    Prefs.getStringF('theme').then((value) {
      var theme = value ?? 'light';
      ThemeData themeData;
      switch (theme) {
        case 'light':
          themeData = ThemeData.light();
          break;
        case 'dark':
          themeData = ThemeData.dark();
          break;
        default:
          themeData = ThemeData.fallback();
      }
      return themeData;
    });
  }

  static setThemeData(String theme) {
    switch (theme) {
      case 'light':
        break;
      case 'dark':
        break;
      default:
        theme = 'fallback';
    }
    Prefs.setString('theme', theme);
  }

  static final Connectivity _connectivity = Connectivity();

  static StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static get filesDir => _path;
  static String _path;

  static String get connectivity => _connectivityStatus;
  static String _connectivityStatus;

  static bool get isOnline => _connectivityStatus != 'none';

  static Set _listeners = new Set();

  static addConnectivityListener(ConnectivityListener listener) =>
      _listeners.add(listener);

  static removeConnectivityListener(ConnectivityListener listener) =>
      _listeners.remove(listener);

  static clearConnectivityListener() => _listeners.clear();

  static Future<String> getInstallNum() => InstallFile.id();

  static String get installNum =>
      _installNum ??
      App.getInstallNum().then((id) {
        _installNum = id;
      }).catchError((e) {
        _installNum = '';
      });
  static String _installNum;

  // Internal Initialization routines.
  static Future<void> _initInternal() async {
    // Get the installation number
    _installNum = await InstallFile.id();

    // Determine the location to the files directory.
    _path = await Files.localPath;

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _listeners.forEach((listener) {
        listener.onConnectivityChanged(result);
      });
    });

    _initConnectivity().then((status) {
      _connectivityStatus = status;
    }).catchError((e) {
      _connectivityStatus = 'none';
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
//TODO   FireBase.didChangeAppLifecycleState(state);
  }

  static Future<String> _initConnectivity() async {
    String connectionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } catch (ex) {
      connectionStatus = 'Failed to get connectivity.';
    }
    return connectionStatus;
  }

//  final GlobalKey<AppView> key = new GlobalKey<AppView>();
}

class _AppWidget extends StatefulWidget {
  _AppWidget(AsyncSnapshot snapshot, {Key key}) : super(key: key);
  State createState() => App._vw;
}

class AppView extends AppViewState<_AppWidget> {
  AppView(
      {this.key,
      @required this.home,
      AppController con,
      GlobalKey<NavigatorState> navigatorKey,
      Map<String, WidgetBuilder> routes,
      String initialRoute,
      RouteFactory onGenerateRoute,
      RouteFactory onUnknownRoute,
      List<NavigatorObserver> navigatorObservers,
      TransitionBuilder builder,
      String title,
      GenerateAppTitle onGenerateTitle,
      ThemeData theme,
      ThemeData darkTheme,
      Color color,
      Locale locale,
      Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
      LocaleResolutionCallback localeResolutionCallback,
      Iterable<Locale> supportedLocales,
      bool debugShowMaterialGrid,
      bool showPerformanceOverlay,
      bool checkerboardRasterCacheImages,
      bool checkerboardOffscreenLayers,
      bool showSemanticsDebugger,
      bool debugShowCheckedModeBanner,
      bool debugShowWidgetInspector,
      bool debugPaintSizeEnabled,
      bool debugPaintBaselinesEnabled,
      bool debugPaintPointersEnabled,
      bool debugPaintLayerBordersEnabled,
      bool debugRepaintRainbowEnabled})
      : super(
          con: con,
          navigatorKey: navigatorKey,
          routes: routes,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          navigatorObservers: navigatorObservers,
          builder: builder,
          title: title,
          onGenerateTitle: onGenerateTitle,
          theme: theme,
          darkTheme: darkTheme,
          color: color,
          locale: locale,
          localizationsDelegates: localizationsDelegates,
          localeResolutionCallback: localeResolutionCallback,
          supportedLocales: supportedLocales,
          debugShowMaterialGrid: debugShowMaterialGrid,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          showSemanticsDebugger: showSemanticsDebugger,
          debugShowWidgetInspector: debugShowWidgetInspector,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        );
  final Key key;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key ?? App.materialKey,
      navigatorKey: navigatorKey ?? onNavigatorKey(),
      home: home,
      routes: routes ?? onRoutes(),
      initialRoute: initialRoute ?? onInitialRoute(),
      onGenerateRoute: onGenerateRoute ?? onOnGenerateRoute(),
      onUnknownRoute: onUnknownRoute ?? onOnUnknownRoute(),
      navigatorObservers: navigatorObservers ?? onNavigatorObservers(),
      builder: builder ?? onBuilder(),
      title: title ?? onTitle(),
      onGenerateTitle: onGenerateTitle ?? onOnGenerateTitle(),
      color: color ?? onColor(),
      theme: theme ?? onTheme(),
      darkTheme: darkTheme ?? onDarkTheme(),
      locale: locale ?? onLocale(),
      localizationsDelegates:
          localizationsDelegates ?? onLocalizationsDelegates(),
      localeResolutionCallback:
          localeResolutionCallback ?? onLocaleResolutionCallback(),
      supportedLocales: supportedLocales ?? onSupportedLocales(),
      debugShowMaterialGrid: debugShowMaterialGrid ?? onDebugShowMaterialGrid(),
      showPerformanceOverlay:
          showPerformanceOverlay ?? onShowPerformanceOverlay(),
      checkerboardRasterCacheImages:
          checkerboardRasterCacheImages ?? onCheckerboardRasterCacheImages(),
      checkerboardOffscreenLayers:
          checkerboardOffscreenLayers ?? onCheckerboardOffscreenLayers(),
      showSemanticsDebugger: showSemanticsDebugger ?? onShowSemanticsDebugger(),
      debugShowCheckedModeBanner:
          debugShowCheckedModeBanner ?? onDebugShowCheckedModeBanner(),
    );
  }

  @override
  void dispose() {
    _navigatorKey = null;
    super.dispose();
  }

  /// During development, if a hot reload occurs, the reassemble method is called.
  @mustCallSuper
  @override
  void reassemble() {
    App.hotLoad = true;
    super.reassemble();
  }

  GlobalKey<NavigatorState> _navigatorKey;

  GlobalKey<NavigatorState> onNavigatorKey() {
    _navigatorKey ??= GlobalKey<NavigatorState>();
    return _navigatorKey;
  }

  Map<String, WidgetBuilder> onRoutes() => const <String, WidgetBuilder>{};
  String onInitialRoute() => null;
  RouteFactory onOnGenerateRoute() => null;
  RouteFactory onOnUnknownRoute() => null;
  List<NavigatorObserver> onNavigatorObservers() => const <NavigatorObserver>[];
  TransitionBuilder onBuilder() => null;
  String onTitle() => '';
  GenerateAppTitle onOnGenerateTitle() => null;
  Color onColor() => null;
  ThemeData onTheme() => App.getThemeData();
  ThemeData onDarkTheme() => null;
  Locale onLocale() => null;
  Iterable<LocalizationsDelegate<dynamic>> onLocalizationsDelegates() => null;
  LocaleResolutionCallback onLocaleResolutionCallback() => null;
  Iterable<Locale> onSupportedLocales() => const <Locale>[Locale('en', 'US')];
  bool onDebugShowMaterialGrid() => false;
  bool onShowPerformanceOverlay() => false;
  bool onCheckerboardRasterCacheImages() => false;
  bool onCheckerboardOffscreenLayers() => false;
  bool onShowSemanticsDebugger() => false;
  bool onDebugShowCheckedModeBanner() => true;
}

abstract class AppViewState<T extends StatefulWidget> extends StateMVC<T> {
  AppViewState({
    this.con,
    this.navigatorKey,
    this.routes: const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers: const <NavigatorObserver>[],
    this.builder,
    this.title: '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.locale,
    this.localizationsDelegates,
    this.localeResolutionCallback,
    this.supportedLocales: const <Locale>[const Locale('en', 'US')],
    this.debugShowMaterialGrid: false,
    this.showPerformanceOverlay: false,
    this.checkerboardRasterCacheImages: false,
    this.checkerboardOffscreenLayers: false,
    this.showSemanticsDebugger: false,
    this.debugShowWidgetInspector: false,
    this.debugShowCheckedModeBanner: true,
    this.debugPaintSizeEnabled = false,
    this.debugPaintBaselinesEnabled = false,
    this.debugPaintPointersEnabled = false,
    this.debugPaintLayerBordersEnabled = false,
    this.debugRepaintRainbowEnabled = false,
  }) : super(con) {
    /// Highlights UI while debugging.
    _debugPaint(
      debugPaintSizeEnabled: debugPaintSizeEnabled,
      debugPaintBaselinesEnabled: debugPaintBaselinesEnabled,
      debugPaintPointersEnabled: debugPaintPointersEnabled,
      debugPaintLayerBordersEnabled: debugPaintLayerBordersEnabled,
      debugRepaintRainbowEnabled: debugRepaintRainbowEnabled,
    );
  }

  final AppController con;

  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder builder;
  final String title;
  final GenerateAppTitle onGenerateTitle;
  final ThemeData theme;
  final ThemeData darkTheme;
  final Color color;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowWidgetInspector;
  final bool debugShowCheckedModeBanner;

  /// Highlights UI while debugging.
  final bool debugPaintSizeEnabled;
  final bool debugPaintBaselinesEnabled;
  final bool debugPaintPointersEnabled;
  final bool debugPaintLayerBordersEnabled;
  final bool debugRepaintRainbowEnabled;

  /// Provide 'the view'
  Widget build(BuildContext context);

  @mustCallSuper
  Future<bool> init() async {
    bool init = await con.init();
    return init;
  }
}

class AppController extends ControllerMVC implements AppConMVC {
  AppController([StateMVC state]) : super(state);

  /// Initialize any immediate 'none time-consuming' operations at the very beginning.
  void initApp() {}

  /// Initialize any 'time-consuming' operations at the beginning.
  /// Initialize items essential to the Mobile Applications.
  /// Called by the _App.init() function.
  @mustCallSuper
  Future<bool> init() async {
    await Prefs.init();
    await DeviceInfo.init();
    return Future.value(true);
  }

  /// Ensure certain objects are 'disposed.'
  /// Callec by the AppState.dispose() function.
  @override
  @mustCallSuper
  void dispose() {
    Prefs.dispose();

    /// Assets.init(context); called in App.build() -gp
    Assets.dispose();
    super.dispose();
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Text("DRAWER HEADER.."),
        ),
        ListTile(
          title: new Text("Item => 1"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: new Text("Item => 2"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}

abstract class ConnectivityListener {
  onConnectivityChanged(ConnectivityResult result);
}

/// High-level function to highlights UI while debugging.
void _debugPaint({
  bool debugPaintSizeEnabled = false,
  bool debugPaintBaselinesEnabled = false,
  bool debugPaintPointersEnabled = false,
  bool debugPaintLayerBordersEnabled = false,
  bool debugRepaintRainbowEnabled = false,
}) {
  /// Highlights UI while debugging.
  debugPaint.debugPaintSizeEnabled = debugPaintSizeEnabled;
  debugPaint.debugPaintBaselinesEnabled = debugPaintBaselinesEnabled;
  debugPaint.debugPaintPointersEnabled = debugPaintPointersEnabled;
  debugPaint.debugPaintLayerBordersEnabled = debugPaintLayerBordersEnabled;
  debugPaint.debugRepaintRainbowEnabled = debugRepaintRainbowEnabled;
}
