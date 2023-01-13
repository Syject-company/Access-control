import 'package:bloc/bloc.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/domain/repositories/camera_alert_manager.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/bloc/cameras_event.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/bloc/cameras_state.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/pages/cameras_alert_details.dart';

class CamerasBloc extends Bloc<CamerasEvent, CamerasState>
    with CameraAlertManager {
  CamerasBloc() : super(CamerasInitial()) {
    on<GetCameraAlerts>(
      (GetCameraAlerts event, Emitter<CamerasState> emit) async {
        await _getAlerts(emit: emit);
      },
    );
    on<LaunchCamerasAlertDetails>(
      (LaunchCamerasAlertDetails event, Emitter<CamerasState> emit) {
        _launchCamerasAlertDetails(event.model);
      },
    );
    on<HandleAlert>(
      (HandleAlert event, Emitter<CamerasState> emit) async {
        await _handleHardAlert(emit: emit, id: event.id);
      },
    );
  }

  Future<void> _handleHardAlert(
          {required Emitter<CamerasState> emit, required num id}) =>
      handleHardAlert(id: id).then((dynamic value) async {
        logInfo('Hardware alert screen: handled hardware alert, id: $id');
        getIt<Navigation>().pop();
        emit(const LoadingShown());
        await _getAlerts(emit: emit);
      });

  Future<void> _getAlerts({required Emitter<CamerasState> emit}) =>
      getCameraAlert().then((List<CameraAlertResponseModel> value) {
        if (value != null) {
          logInfo('Get hardware alert has been successfully, count: ${value.length}');
          emit(CameraAlertsGot(data: value));
        }
      }).catchError((dynamic onError) {
        emit(const CameraAlertsGot(data: <CameraAlertResponseModel>[]));
      });

  void _launchCamerasAlertDetails(CameraAlertResponseModel model) {
    logInfo('Launched Hardware alert details page');
    getIt<Navigation>().toPageRouteProvider<CamerasAlertDetails, CamerasBloc>(
      page: CamerasAlertDetails(model: model),
      bloc: this,
    );
  }
}
