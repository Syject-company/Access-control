import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/data/entities/common/error/error_model.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';

Exception error(
  dynamic onError, {
  bool isGetUserData = false,
  bool isSearchByPhoto = false,
  bool isGetProjectsPosEmpl = false,
}) {
  if (onError is DioError &&
      onError.type == DioErrorType.response &&
      onError.response != null &&
      onError.response?.data is Map<String, dynamic> &&
      !isGetProjectsPosEmpl &&
      (onError.response?.statusCode == 401 ||
          onError.response?.statusCode == 612 ||
          onError.response?.statusCode == 604 ||
          (!isSearchByPhoto && onError.response?.statusCode == 706) ||
          onError.response?.statusCode == 704 ||
          onError.response?.statusCode == 701 ||
          onError.response?.statusCode == 422)) {
    final ErrorModel error =
        ErrorModel.fromJson(onError.response?.data as Map<String, dynamic>);
    if (onError.response?.statusCode == 401 && isGetUserData) {
      _logOut();
      Fluttertoast.cancel();
    } else if (onError.response?.statusCode == 401 && !isGetUserData) {
      _toastError(error: StringsRes.noPermission.tr());
    } else {
      _toastError(error: error.message);
    }

    logError(
        'API error: method:${onError.requestOptions.method}/${onError.requestOptions.path} - code:${onError.response?.statusCode} - message:${error.message}');

    return Exception(ExceptionType.response);
  } else if (onError is TimeoutException) {
    _toastError(error: StringsRes.timeOutError.tr());
    logError('API error: Timeout Exception');
    return Exception(ExceptionType.timeout);
  } else if (onError is DioError &&
      onError.type == DioErrorType.response &&
      onError.response != null &&
      (onError.response?.statusCode).toString().startsWith('5')) {
    _toastError(error: StringsRes.apiError.tr());
    logError(
        'API error: method:${onError.requestOptions.method}/${onError.requestOptions.path} - Server not responding');
    return Exception(ExceptionType.server);
  }
  logError(
      'API error: method:${onError is DioError ? onError.requestOptions.method : ''}/${onError is DioError ? onError.requestOptions.path : ''} - ${StringsRes.apiError}');
  // _toastError(error: StringsRes.apiError.tr());
  return Exception(ExceptionType.unknown);
}

void _toastError({required String error}) => Fluttertoast.showToast(
      msg: error,
      backgroundColor: Colors.grey,
      fontSize: TextSizes.sp16.sp,
    );

Future<void> _logOut() async {
  if (await getIt<Storage>().getIsLoggedIn()) {
    logInfo('The user is logged out');
    await getIt<Storage>().setIsLoggedIn(StringsRes.isLoggedOut);
    getIt<Navigation>().toRemoveUntil(RouteName.login);
  }
}
