import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/api_provider.dart';
import 'package:safe_access/features/data/entities/requests/access_alert_search_request_model.dart';
import 'package:safe_access/features/data/entities/requests/handle_access_alert_request_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_main_response_model.dart';
import 'package:safe_access/features/domain/exceptions/exceptions.dart';

mixin AccessAlertManager {
  Future<AccessAlertMainResponseModel> getAccessAlert({required int offset}) =>
      getIt<ApiProvider>()
          .getAccessAlert(offset: offset)
          .timeout(const Duration(seconds: 120))
          .catchError((dynamic onError) => throw error(onError));

  Future<AccessAlertMainResponseModel> getAccessAlertByClassification({
    required int offset,
    required List<int> classificationIds,
  }) =>
      getIt<ApiProvider>()
          .getAccessAlertByClassification(
            offset: offset,
            classificationIds: classificationIds,
          ).timeout(const Duration(seconds: 120))
          .catchError((dynamic onError) => throw error(onError));

  Future<void> handleAccessAlert(
          {required HandleAccessAlertRequestModel model}) =>
      getIt<ApiProvider>()
          .handleAccessAlert(model: model)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<AccessAlertMainResponseModel?> searchAccessAlerts(
          {required AccessAlertSearchRequestModel model}) =>
      getIt<ApiProvider>()
          .searchAccessAlerts(model: model)
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));
}
