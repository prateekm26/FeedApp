import 'dart:async';

import 'package:feed_app/src/data_layer/res/styles.dart';
import 'package:feed_app/src/feed_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  /// Initialize the WidgetFlutterBinding if required
  WidgetsFlutterBinding.ensureInitialized();

  /// Sets the status bar color of the widget
  AppStyles.setStatusBarTheme();

  /// Ensuring Size of the phone in UI Design
  await ScreenUtil.ensureScreenSize();

  /// Sets the device orientation of application
  AppStyles.setDeviceOrientationOfApp();

  /// Runs the application in its own error zone
  runApp(const FeedApp());
}
