import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/api_client.dart';
import 'package:safe_access/features/data/entities/common/employer_model.dart';
import 'package:safe_access/features/data/entities/requests/access_alert_search_request_model.dart';
import 'package:safe_access/features/data/entities/requests/firebase_token_request_model.dart';
import 'package:safe_access/features/data/entities/requests/handle_access_alert_request_model.dart';
import 'package:safe_access/features/data/entities/requests/update_language_request_model.dart';
import 'package:safe_access/features/data/entities/requests/worker_assign_to_project_request_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_main_response_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/data/entities/responses/events_search_main_response_model.dart';
import 'package:safe_access/features/data/entities/responses/position_response_model.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/data/entities/responses/user_data_response_model.dart';
import 'package:safe_access/features/data/entities/responses/worker_data_response_model.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';

import 'entities/responses/search_workers_response_model.dart';

class ApiProvider {
  final Duration timeout = const Duration(seconds: 15);

  final ApiClient _apiClient = ApiClient(Dio()
    ..interceptors.add(PrettyDioLogger(requestBody: true, requestHeader: true))
    ..options.headers['Accept'] = 'application/json');

  Future<UserDataResponseModel> getUserData() async =>
      _apiClient.getUserData(await getIt<Storage>().getHeaderCookies() ?? '');

  Future<List<ProjectResponseModel>> getProjects() async =>
      _apiClient.getProjects(await getIt<Storage>().getHeaderCookies() ?? '');

  Future<List<EmployerModel>> getEmployers() async =>
      _apiClient.getEmployers(await getIt<Storage>().getHeaderCookies() ?? '');

  Future<List<PositionResponseModel>> getPositions() async =>
      _apiClient.getPositions(await getIt<Storage>().getHeaderCookies() ?? '');

  Future<void> registerWorker(
          {required File img,
          required int projectId,
          String? identificationNumber,
          int? identificationType}) async =>
      _apiClient.registerWorker(
        await getIt<Storage>().getHeaderCookies() ?? '',
        projectId: projectId,
        img: img,
        identificationNumber: identificationNumber,
        identificationType: identificationType,
      );

  Future<void> logout() async => _apiClient.logout(
      await getIt<Storage>().getHeaderCookies() ?? '', true, true);

  Future<void> updateFCMToken(
          {required FirebaseTokenRequestModel model}) async =>
      _apiClient.updateFCMToken(
          await getIt<Storage>().getHeaderCookies() ?? '', model);

  Future<AccessAlertMainResponseModel> getAccessAlert(
          {required int offset}) async =>
      _apiClient.getAccessAlert(
        await getIt<Storage>().getHeaderCookies() ?? '',
        offset,
      );

  Future<AccessAlertMainResponseModel> getAccessAlertByClassification({
    required int offset,
    required List<int> classificationIds,
  }) async =>
      _apiClient.getAccessAlertByClassification(
        await getIt<Storage>().getHeaderCookies() ?? '',
        offset,
        classificationIds,
      );

  Future<void> handleAccessAlert(
          {required HandleAccessAlertRequestModel model}) async =>
      _apiClient.handleAccessAlert(
          await getIt<Storage>().getHeaderCookies() ?? '', model);

  Future<List<CameraAlertResponseModel>> getCameraAlert() async => _apiClient
      .getCameraAlert(await getIt<Storage>().getHeaderCookies() ?? '');

  Future<void> handleHardAlert({required num id}) async => _apiClient
      .handleHardAlert(await getIt<Storage>().getHeaderCookies() ?? '', id);

  Future<WorkerDataResponseModel?> getWorkerByID(
          {required num projectId,
          required num idType,
          required String idNumber}) async =>
      _apiClient.getWorkerByID(
        await getIt<Storage>().getHeaderCookies() ?? '',
        projectId,
        idType,
        idNumber,
        1,
      );

  Future<WorkerDataResponseModel?> searchWorkerByPhoto(
          {required File img, required int projectId}) async =>
      _apiClient.searchWorkerByPhoto(
        await getIt<Storage>().getHeaderCookies() ?? '',
        img: img,
        projectId: projectId,
      );

  Future<void> workerAssignToProject(
          {required WorkerAssignToProjectRequestModel model}) async =>
      _apiClient.workerAssignToProject(
        await getIt<Storage>().getHeaderCookies() ?? '',
        model,
      );

  Future<void> workerRegisterUpdateData({
    required int personId,
    required int identificationType,
    required String identificationNumber,
    int? projectId,
    int? countryId,
    File? image,
  }) async =>
      _apiClient.workerRegisterUpdateData(
        await getIt<Storage>().getHeaderCookies() ?? '',
        identificationType: identificationType,
        identificationNumber: identificationNumber,
        personId: personId,
        projectId: projectId,
        image: image,
        countryId: countryId,
      );

  Future<void> updateLanguage(
          {required UpdateLanguageRequestModel model}) async =>
      _apiClient.updateLanguage(
        await getIt<Storage>().getHeaderCookies() ?? '',
        model,
      );

  Future<List<SearchWorkersResponseModel>> getWorkers({
    required int projectId,
    required List<int> positionIds,
    required String idNumber,
    required List<int> classificationIds,
    required List<int> employerIds,
  }) async =>
      _apiClient.getWorkers(
        await getIt<Storage>().getHeaderCookies() ?? '',
        projectId,
        positionIds,
        idNumber,
        classificationIds,
        employerIds,
      );

  Future<EventsSearchMainResponseModel> getEvents({
    required int projectId,
    required int offset,
    required bool isActiveProject,
    required bool isFirstAppearance,
    required List<int> positionIds,
    required List<int> classificationIds,
    required List<int> employerIds,
    required String fromDate,
    required String toDate,
  }) async =>
      _apiClient.getEvents(
        await getIt<Storage>().getHeaderCookies() ?? '',
        projectId,
        offset,
        positionIds,
        isActiveProject,
        classificationIds,
        employerIds,
        fromDate,
        toDate,
        isFirstAppearance,
      );

  Future<AccessAlertMainResponseModel> searchAccessAlerts(
          {required AccessAlertSearchRequestModel model}) async =>
      _apiClient.searchAccessAlerts(
        await getIt<Storage>().getHeaderCookies() ?? '',
        model,
      );

  Future<AccessAlertResponseModel> getAlertFromNotification(
          {required int alertId, required String alertType}) async =>
      _apiClient.getAlertFromNotification(
        await getIt<Storage>().getHeaderCookies() ?? '',
        alertId,
        alertType,
      );

  Future<CameraAlertResponseModel> getHardwareAlertFromNotification(
          {required int alertId}) async =>
      _apiClient.getHardwareAlertFromNotification(
        await getIt<Storage>().getHeaderCookies() ?? '',
        alertId,
        'hardware',
      );
}
