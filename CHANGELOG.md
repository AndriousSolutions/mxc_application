## 1.3.0
 2019-04-12:
- _this ??=  implemented in many factory constructors.
- xml: ^3.4.1

## 1.2.1
 2019-03-19:
- Supply the AsyncSnapshot in App.snapshot

## 1.2.0+1
 2019-03-18: 
-   Updated homepage & repository in pubspec.yaml

## 1.2.0
 2019-03-18: 
- Add named parameter loadingScreen 

## 1.1.0+2
 2019-03-13:
- Remove firebase_admob from pubspec.yaml 

## 1.1.0+1
 2019-03-13: **THIS CONTINUES AS A BREAKING CHANGE.**
- Remove the package library, Ads 
- Remove ads.dart and dbutils.dart
- Rename example app, contact_androidx_example  

## 1.1.0
 2019-03-13: **THIS WAS AN UNINTENTIONAL BREAKING CHANGE.**
- Include the package library, Ads 
- Introduced ads.dart and dbutils.dart
- Ads will become a separate Flutter package

## 1.0.1
 2019-03-13: 
- Some Pub Health Suggestions Fixed
- Lengthened the pubspec.yaml description.

## 1.0.0 
 2019-03-09: 
- version constraints prior to AndroidX
- included package libraries: assest, fileutils, dbutils and uxutils
- introduced an example

## 0.13.0 
 2019-03-01: 
- prefs: library package

## 0.12.1 
 2019-02-27: 
- 'package:mvc_application/src/controller/app.dart' show App, AppController;

## 0.11.0 
 2019-02-22: 
- Rename class AppView to AppViewState; AppState to AppView

## 0.10.0 
 2019-02-20: 
- class App extends AppMVC { class ViewMVC extends AppState {

## 0.9.1 
 2019-02-16: 
- mvc_pattern: in pubspec.yaml

## 0.9.0 
 2019-02-14: 
- static String get appName => _packageInfo.appName; await DeviceInfo.init(); Introduced DeviceInfo

## 0.8.1 
 2019-02-10: 
- showAboutDialog(); PackageInfo.fromPlatform(); show Prefs; 

## 0.7.4 
 2019-02-09: 
- Color Theme Menu Popup

## 0.7.3 
 2019-02-09: 
- await Prefs.init(); get colorTheme => AppMenu.colorTheme;

## 0.7.2 
 2019-02-06: 
- class FieldWidgets<T> extends Item {

## 0.7.1 
 2019-02-06: 
- Removed class ConMVC, SDK Constraint to <3.0.0, keys() in class Item

## 0.6.0 
 2019-01-28: 
- Renamed the classes Controller and View to ConMVC and ViewMVC

## 0.5.0 
 2019-01-28: 
- if (_firstCon == null) _firstCon = this;  get inDebugger in class App 

## 0.4.0 
 2019-01-25: 
- factory _App({AppConMVC con, Key key}) {

## 0.3.0 
 2019-01-17: 
- Moved the class, Controller, into mvc.dart.

## 0.2.0
 2019-01-17: 
- class AppView extends StateMVC Highlights UI while debugging.

## 0.1.7 
 2019-01-16: 
-  _App  super(con: null, key: key);
-  controller.dart  export show StateListener;
-  fields.dart  DefaultTextStyle get defaultTextStyle
-  mvc.dart  MVC(AppView view, {Key key})  View() this.add(con);

## 0.1.2 
 2019-01-06: 
- Introduced the class, Field

## 0.1.1
 2019-01-03: 
- export statements finalized.

## 0.1.0 
 2018-12-24: 
- Initial Development Release