import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
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
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';
import 'package:safe_access/features/data/entities/responses/user_data_response_model.dart';
import 'package:safe_access/features/data/entities/responses/worker_data_response_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.pangeasac.xyz/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('user/')
  Future<UserDataResponseModel> getUserData(
      @Header('Cookie') String sessionIdAndToken);

  @GET('project')
  Future<List<ProjectResponseModel>> getProjects(
      @Header('Cookie') String sessionIdAndToken);

  @GET('employer')
  Future<List<EmployerModel>> getEmployers(
      @Header('Cookie') String sessionIdAndToken);

  @GET('position')
  Future<List<PositionResponseModel>> getPositions(
      @Header('Cookie') String sessionIdAndToken);

  @POST('registration/create')
  @MultiPart()
  Future<void> registerWorker(
    @Header('Cookie') String sessionIdAndToken, {
    @Part() required File img,
    @Part() String? identificationNumber,
    @Part() int? identificationType,
    @Part() required int projectId,
  });

  @GET('logout')
  Future<void> logout(@Header('Cookie') String sessionIdAndToken,
      @Query('isMobile') bool isMobile, @Query('logoutAD') bool logoutAD);

  @PATCH('user/updateTokens')
  Future<void> updateFCMToken(
    @Header('Cookie') String sessionIdAndToken,
    @Body() FirebaseTokenRequestModel model,
  );

  @GET('alerts/access/unhandled')
  Future<AccessAlertMainResponseModel> getAccessAlert(
    @Header('Cookie') String sessionIdAndToken,
    @Query('offset') int offset,
  );

  @GET('alerts/access/unhandled')
  Future<AccessAlertMainResponseModel> getAccessAlertByClassification(
      @Header('Cookie') String sessionIdAndToken,
      @Query('offset') int offset,
      @Query('classificationIds') List<int> classificationIds,
      );

  @PATCH('alerts/access')
  Future<void> handleAccessAlert(
    @Header('Cookie') String sessionIdAndToken,
    @Body() HandleAccessAlertRequestModel model,
  );

  @GET('hardware/unhandled')
  Future<List<CameraAlertResponseModel>> getCameraAlert(
      @Header('Cookie') String sessionIdAndToken);

  @PATCH('hardware')
  Future<void> handleHardAlert(@Header('Cookie') String sessionIdAndToken,
      @Query('hardwareAlertId') num id);

  @GET('person/byId')
  Future<WorkerDataResponseModel?> getWorkerByID(
    @Header('Cookie') String sessionIdAndToken,
    @Query('projectId') num projectId,
    @Query('identificationType') num idType,
    @Query('identificationNumber') String idNumber,
    @Query('countryId') num idCountry,
  );

  @POST('registration/search')
  @MultiPart()
  Future<WorkerDataResponseModel?> searchWorkerByPhoto(
    @Header('Cookie') String sessionIdAndToken, {
    @Part() required File img,
    @Part() required int projectId,
  });

  @POST('registration/assignToProject')
  Future<void> workerAssignToProject(
    @Header('Cookie') String sessionIdAndToken,
    @Body() WorkerAssignToProjectRequestModel model,
  );

  @PATCH('person')
  @MultiPart()
  Future<void> workerRegisterUpdateData(
    @Header('Cookie') String sessionIdAndToken, {
    @Part() required int personId,
    @Part() required int identificationType,
    @Part() required String identificationNumber,
    @Part() File? image,
    @Part() int? countryId,
    @Part() int? projectId,
  });

  @PATCH('user/updateLang')
  Future<void> updateLanguage(
    @Header('Cookie') String sessionIdAndToken,
    @Body() UpdateLanguageRequestModel model,
  );

  @GET('person/workers')
  Future<List<SearchWorkersResponseModel>> getWorkers(
    @Header('Cookie') String sessionIdAndToken,
    @Query('projectId') int projectId,
    @Query('positionIds') List<int> positionIds,
    @Query('identificationNumber') String idNumber,
    @Query('classificationIds') List<int> classificationIds,
    @Query('employerIds') List<int> employerIds,
  );

  @GET('event')
  Future<EventsSearchMainResponseModel> getEvents(
    @Header('Cookie') String sessionIdAndToken,
    @Query('projectId') int projectId,
    @Query('offset') int offset,
    @Query('positionIds') List<int> positionIds,
    @Query('isActive') bool isActive,
    @Query('classificationIds') List<int> classificationIds,
    @Query('employerIds') List<int> employerIds,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('isFirstAppearance') bool isFirstAppearance,
  );

  @POST('alerts/events/search')
  Future<AccessAlertMainResponseModel> searchAccessAlerts(
    @Header('Cookie') String sessionIdAndToken,
    @Body() AccessAlertSearchRequestModel model,
  );

  @GET('notification')
  Future<AccessAlertResponseModel> getAlertFromNotification(
    @Header('Cookie') String sessionIdAndToken,
    @Query('alertId') int alertId,
    @Query('alertType') String alertType,
  );

  @GET('notification')
  Future<CameraAlertResponseModel> getHardwareAlertFromNotification(
    @Header('Cookie') String sessionIdAndToken,
    @Query('alertId') int alertId,
    @Query('alertType') String alertType,
  );
}
