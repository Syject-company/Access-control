import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/api_provider.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/domain/exceptions/exceptions.dart';

mixin CameraAlertManager {
  Future<List<CameraAlertResponseModel>> getCameraAlert() =>
      getIt<ApiProvider>()
          .getCameraAlert()
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));

  Future<void> handleHardAlert({required num id}) => getIt<ApiProvider>()
      .handleHardAlert(id: id)
      .timeout(getIt<ApiProvider>().timeout)
      .catchError((dynamic onError) => throw error(onError));
}
