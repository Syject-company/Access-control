import 'dart:async';
import 'dart:io';

import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/app_info.dart';
import 'package:safe_access/features/internal/application.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';

import 'core/services/firebase_messaging_service.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  debugPrint('Main Background message ${message.data}');
}

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) async {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: ColorsRes.secondPrimary));
      await EasyLocalization.ensureInitialized();
      setupGitIt();
      await getIt<FirebaseMS>().init();
      FirebaseMessaging.onBackgroundMessage(_messageHandler);
      getIt<Storage>().init();
      //To switch off the logger
      EasyLocalization.logger.enableBuildModes = [];

      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      getIt<AppInfo>().appVersion = packageInfo.version;

      final bool isLoggedIn = await getIt<Storage>().getIsLoggedIn();

      //Note: DatadogSdk
      final DdSdkConfiguration configuration = DdSdkConfiguration(
        clientToken: StringsRes.datadogSdkToken,
        env: StringsRes.datadogSdkEnv,
        site: DatadogSite.eu1,
        trackingConsent: TrackingConsent.granted,
        nativeCrashReportEnabled: true,
        loggingConfiguration: LoggingConfiguration(
          sendNetworkInfo: true,
          printLogsToConsole: true,
          loggerName:
              '${StringsRes.platformName} ${Platform.isAndroid ? 'Android' : 'Ios'}',
        ),
        tracingConfiguration: TracingConfiguration(
          sendNetworkInfo: true,
        ),
      );

      final DatadogSdk _datadogSdk = DatadogSdk.instance;
      _datadogSdk.sdkVerbosity = Verbosity.verbose;

      DatadogSdk.instance.initialize(configuration);

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        _datadogSdk.rum?.handleFlutterError(details);
      };

      runApp(
        EasyLocalization(
            supportedLocales: const <Locale>[Locale('en'), Locale('he')],
            path: StringsRes.pathLanguages,
            assetLoader: const RootBundleAssetLoader(),
            useOnlyLangCode: true,
            startLocale: const Locale('en'),
            child: SafeAccess(
              isLoggedIn: isLoggedIn,
            )),
      );
    });
  }, (Object e, StackTrace s) {
    DatadogSdk.instance.rum
        ?.addErrorInfo(e.toString(), RumErrorSource.source, stackTrace: s);
    throw e;
  });
}
