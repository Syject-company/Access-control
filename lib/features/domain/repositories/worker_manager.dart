import 'dart:io';

import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/api_provider.dart';
import 'package:safe_access/features/data/entities/requests/worker_assign_to_project_request_model.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';
import 'package:safe_access/features/data/entities/responses/worker_data_response_model.dart';
import 'package:safe_access/features/domain/exceptions/exceptions.dart';

mixin WorkerManager {
  Future<WorkerDataResponseModel?> getWorkerByID(
          {required num projectId,
          required num idType,
          required String idNumber}) =>
      getIt<ApiProvider>()
          .getWorkerByID(
            projectId: projectId,
            idType: idType,
            idNumber: idNumber,
          )
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<WorkerDataResponseModel?> searchWorkerByPhoto(
          {required File img, required int projectId}) =>
      getIt<ApiProvider>()
          .searchWorkerByPhoto(img: img, projectId: projectId)
          .timeout(const Duration(seconds: 60))
          .catchError(
              (dynamic onError) => throw error(onError, isSearchByPhoto: true));

  Future<void> registerWorker(
          {required File img,
          required int projectId,
          String? identificationNumber,
          int? identificationType}) =>
      getIt<ApiProvider>()
          .registerWorker(
            projectId: projectId,
            img: img,
            identificationNumber: identificationNumber,
            identificationType: identificationType,
          )
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<void> workerAssignToProject(
          {required WorkerAssignToProjectRequestModel model}) =>
      getIt<ApiProvider>()
          .workerAssignToProject(model: model)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<void> workerUpdateData({
    required int personId,
    required int identificationType,
    required String identificationNumber,
    int? projectId,
    File? image,
    int? countryId,
  }) =>
      getIt<ApiProvider>()
          .workerRegisterUpdateData(
              personId: personId,
              identificationNumber: identificationNumber,
              identificationType: identificationType,
              image: image,
              countryId: countryId,
              projectId: projectId)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<List<SearchWorkersResponseModel>> getWorkers({
    required int projectId,
    required List<int> positionIds,
    required String idNumber,
    required List<int> classificationIds,
    required List<int> employerIds,
  }) =>
      getIt<ApiProvider>()
          .getWorkers(
            projectId: projectId,
            classificationIds: classificationIds,
            employerIds: employerIds,
            positionIds: positionIds,
            idNumber: idNumber,
          )
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));
}
