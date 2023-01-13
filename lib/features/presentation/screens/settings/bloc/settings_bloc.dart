import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/firebase_messaging_service.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/data/entities/requests/firebase_token_request_model.dart';
import 'package:safe_access/features/data/entities/requests/update_language_request_model.dart';
import 'package:safe_access/features/domain/repositories/home_manager.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_event.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_state.dart';
import 'package:safe_access/features/presentation/screens/settings/pages/Language.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> with HomeManager {
  SettingsBloc() : super(SettingsInitial()) {
    on<LaunchLanguagePage>(
      (LaunchLanguagePage event, Emitter<SettingsState> emit) {
        _launchLanguagePage();
      },
    );
    on<ShowLogOutDialog>(
      (ShowLogOutDialog event, Emitter<SettingsState> emit) {
        emit(LogOutDialogShown());
      },
    );
    on<LogOut>(
      (LogOut event, Emitter<SettingsState> emit) async {
        await _logOut(emit: emit);
      },
    );
    on<UpdateLanguage>(
      (UpdateLanguage event, Emitter<SettingsState> emit) async {
        await _updateLanguage(lanCode: event.lanCode).whenComplete(() {
          logError('Language is changed to: ${event.lanCode}');
          emit(LanguageUpdated(locale: event.locale));
        });
      },
    );
  }

  void _launchLanguagePage() =>
      getIt<Navigation>().toPageRouteProvider<LanguagePage, SettingsBloc>(
        page: const LanguagePage(),
        bloc: this,
      );

  Future<void> _updateLanguage({required String lanCode}) =>
      updateLanguage(model: UpdateLanguageRequestModel(lang: lanCode));

  Future<void> _logOut({required Emitter<SettingsState> emit}) =>
      _updateFirebaseToken(isDelete: true)
          .then(
        (dynamic value) => logout().then((dynamic value) async {
          logInfo('The user is logged out');
          WebviewCookieManager().clearCookies();
          await getIt<Storage>().setIsLoggedIn(StringsRes.isLoggedOut);
          getIt<Navigation>().toRemoveUntil(RouteName.login);
          debugPrint('Firebase Token is deleted!');
        }).catchError((dynamic onError) {
          logError('Logging out error: $onError');
          emit(LogOutError());
        }),
      )
          .catchError((dynamic onError) {
        emit(LogOutError());
      });

  Future<void> _updateFirebaseToken({required bool isDelete}) async {
    final String? _token = await getIt<FirebaseMS>().token;
    final String? _id = await _deviceID;
    if (_token != null && _id != null) {
      await updateFCMToken(
          model: FirebaseTokenRequestModel(
        deviceId: _id,
        fcmToken: _token,
        isDelete: isDelete,
      ));
    }
  }

  Future<String?> get _deviceID async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        final IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    return identifier;
  }
}
