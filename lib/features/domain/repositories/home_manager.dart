import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/api_provider.dart';
import 'package:safe_access/features/data/entities/common/employer_model.dart';
import 'package:safe_access/features/data/entities/requests/firebase_token_request_model.dart';
import 'package:safe_access/features/data/entities/requests/update_language_request_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/data/entities/responses/position_response_model.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/domain/exceptions/exceptions.dart';

mixin HomeManager {
  Future<void> logout() => getIt<ApiProvider>()
      .logout()
      .timeout(getIt<ApiProvider>().timeout)
      .catchError((dynamic onError) => throw error(onError));

  Future<List<ProjectResponseModel>> getProjects() => getIt<ApiProvider>()
      .getProjects()
      .timeout(getIt<ApiProvider>().timeout)
      .catchError((dynamic onError) => throw error(
            onError,
            isGetProjectsPosEmpl: true,
          ));

  Future<List<EmployerModel>> getEmployers() => getIt<ApiProvider>()
      .getEmployers()
      .timeout(getIt<ApiProvider>().timeout)
      .catchError((dynamic onError) => throw error(
            onError,
            isGetProjectsPosEmpl: true,
          ));

  Future<List<PositionResponseModel>> getPositions() => getIt<ApiProvider>()
      .getPositions()
      .timeout(getIt<ApiProvider>().timeout)
      .catchError((dynamic onError) => throw error(
            onError,
            isGetProjectsPosEmpl: true,
          ));

  Future<void> updateFCMToken({required FirebaseTokenRequestModel model}) =>
      getIt<ApiProvider>()
          .updateFCMToken(model: model)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<void> updateLanguage({required UpdateLanguageRequestModel model}) =>
      getIt<ApiProvider>()
          .updateLanguage(model: model)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<AccessAlertResponseModel> getAlertFromNotification(
          {required int alertId, required String alertType}) =>
      getIt<ApiProvider>()
          .getAlertFromNotification(alertType: alertType, alertId: alertId)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<CameraAlertResponseModel> getHardwareAlertFromNotification(
          {required int alertId}) =>
      getIt<ApiProvider>()
          .getHardwareAlertFromNotification(alertId: alertId)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));
}
