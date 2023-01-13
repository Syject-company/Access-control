// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.pangeasac.xyz/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserDataResponseModel> getUserData(sessionIdAndToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserDataResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserDataResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<ProjectResponseModel>> getProjects(sessionIdAndToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<ProjectResponseModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'project',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            ProjectResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EmployerModel>> getEmployers(sessionIdAndToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<EmployerModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'employer',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => EmployerModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<PositionResponseModel>> getPositions(sessionIdAndToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PositionResponseModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'position',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            PositionResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> registerWorker(sessionIdAndToken,
      {required img,
      identificationNumber,
      identificationType,
      required projectId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.files.add(MapEntry(
        'img',
        MultipartFile.fromFileSync(img.path,
            filename: img.path.split(Platform.pathSeparator).last)));
    if (identificationNumber != null) {
      _data.fields.add(MapEntry('identificationNumber', identificationNumber));
    }
    if (identificationType != null) {
      _data.fields
          .add(MapEntry('identificationType', identificationType.toString()));
    }
    _data.fields.add(MapEntry('projectId', projectId.toString()));
    await _dio.fetch<void>(_setStreamType<void>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data')
        .compose(_dio.options, 'registration/create',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<void> logout(sessionIdAndToken, isMobile, logoutAD) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'isMobile': isMobile,
      r'logoutAD': logoutAD
    };
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'logout',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<void> updateFCMToken(sessionIdAndToken, model) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(model.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/updateTokens',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<AccessAlertMainResponseModel> getAccessAlert(
      sessionIdAndToken, offset) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'offset': offset};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccessAlertMainResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'alerts/access/unhandled',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AccessAlertMainResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AccessAlertMainResponseModel> getAccessAlertByClassification(
      sessionIdAndToken, offset, classificationIds) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'classificationIds': classificationIds
    };
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccessAlertMainResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'alerts/access/unhandled',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AccessAlertMainResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> handleAccessAlert(sessionIdAndToken, model) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(model.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'alerts/access',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<List<CameraAlertResponseModel>> getCameraAlert(
      sessionIdAndToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<CameraAlertResponseModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'hardware/unhandled',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            CameraAlertResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> handleHardAlert(sessionIdAndToken, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'hardwareAlertId': id};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'hardware',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<WorkerDataResponseModel?> getWorkerByID(
      sessionIdAndToken, projectId, idType, idNumber, idCountry) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'projectId': projectId,
      r'identificationType': idType,
      r'identificationNumber': idNumber,
      r'countryId': idCountry
    };
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<WorkerDataResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'person/byId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : WorkerDataResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WorkerDataResponseModel?> searchWorkerByPhoto(sessionIdAndToken,
      {required img, required projectId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.files.add(MapEntry(
        'img',
        MultipartFile.fromFileSync(img.path,
            filename: img.path.split(Platform.pathSeparator).last)));
    _data.fields.add(MapEntry('projectId', projectId.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<WorkerDataResponseModel>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'registration/search',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : WorkerDataResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> workerAssignToProject(sessionIdAndToken, model) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(model.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'registration/assignToProject',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<void> workerRegisterUpdateData(sessionIdAndToken,
      {required personId,
      required identificationType,
      required identificationNumber,
      image,
      countryId,
      projectId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry('personId', personId.toString()));
    _data.fields
        .add(MapEntry('identificationType', identificationType.toString()));
    _data.fields.add(MapEntry('identificationNumber', identificationNumber));
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (countryId != null) {
      _data.fields.add(MapEntry('countryId', countryId.toString()));
    }
    if (projectId != null) {
      _data.fields.add(MapEntry('projectId', projectId.toString()));
    }
    await _dio.fetch<void>(_setStreamType<void>(Options(
            method: 'PATCH',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data')
        .compose(_dio.options, 'person',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<void> updateLanguage(sessionIdAndToken, model) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(model.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/updateLang',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<List<SearchWorkersResponseModel>> getWorkers(sessionIdAndToken,
      projectId, positionIds, idNumber, classificationIds, employerIds) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'projectId': projectId,
      r'positionIds': positionIds,
      r'identificationNumber': idNumber,
      r'classificationIds': classificationIds,
      r'employerIds': employerIds
    };
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<SearchWorkersResponseModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'person/workers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            SearchWorkersResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<EventsSearchMainResponseModel> getEvents(
      sessionIdAndToken,
      projectId,
      offset,
      positionIds,
      isActive,
      classificationIds,
      employerIds,
      fromDate,
      toDate,
      isFirstAppearance) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'projectId': projectId,
      r'offset': offset,
      r'positionIds': positionIds,
      r'isActive': isActive,
      r'classificationIds': classificationIds,
      r'employerIds': employerIds,
      r'fromDate': fromDate,
      r'toDate': toDate,
      r'isFirstAppearance': isFirstAppearance
    };
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EventsSearchMainResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'event',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventsSearchMainResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AccessAlertMainResponseModel> searchAccessAlerts(
      sessionIdAndToken, model) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(model.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccessAlertMainResponseModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'alerts/events/search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AccessAlertMainResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AccessAlertResponseModel> getAlertFromNotification(
      sessionIdAndToken, alertId, alertType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'alertId': alertId,
      r'alertType': alertType
    };
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccessAlertResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'notification',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AccessAlertResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CameraAlertResponseModel> getHardwareAlertFromNotification(
      sessionIdAndToken, alertId, alertType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'alertId': alertId,
      r'alertType': alertType
    };
    final _headers = <String, dynamic>{r'Cookie': sessionIdAndToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CameraAlertResponseModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'notification',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CameraAlertResponseModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
