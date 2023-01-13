import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/core/network/network_info.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/login/bloc/login_event.dart';
import 'package:safe_access/features/presentation/screens/login/bloc/login_state.dart';
import 'package:safe_access/features/presentation/screens/login/login_web_page/login_web_page.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {
    on<LogInAzure>(
      (LogInAzure event, Emitter<LogInState> emit) async {
        await NetworkInfoData().isConnected.then((bool isConnected) async {
          if (isConnected) {
            await _openWebAzureLogin(emit: emit);
          } else {
            logWarn(StringsRes.connectionError);
            emit(ErrorShown(error: StringsRes.connectionError));
          }
        });
      },
    );
    on<GetUserData>((GetUserData event, Emitter<LogInState> emit) async {
      await _getLoginCookies(emit: emit);
    });
  }

  Future<void> _openWebAzureLogin({required Emitter<LogInState> emit}) async {
    await getIt<Navigation>().toPageRoute<LoginWebPage>(
      page: LoginWebPage(onLoggedIn: () {
        emit(AzureLoggedIn());
      }),
    );
  }

  Future<void> _getLoginCookies({required Emitter<LogInState> emit}) =>
      WebviewCookieManager()
          .getCookies(StringsRes.loginAzureURL)
          .then((List<Cookie> cookies) async {
        if (cookies != null && cookies.isNotEmpty && cookies[0] != null) {
          debugPrint('cookies: ${cookies[0]}');
          await getIt<Storage>().setHeaderCookies(cookies[0].toString());
          await getIt<Storage>().setIsLoggedIn(StringsRes.isLoggedIn);
          logInfo('User has been successfully logged in Azure');
          Timer(const Duration(seconds: 2),
              () => getIt<Navigation>().toReplacement(RouteName.home));
        }
      });
}
