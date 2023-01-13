import 'package:equatable/equatable.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';

abstract class CamerasEvent extends Equatable {
  const CamerasEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetCameraAlerts extends CamerasEvent {
  const GetCameraAlerts();

  @override
  List<Object> get props => <Object>[];
}

class LaunchCamerasAlertDetails extends CamerasEvent {
  const LaunchCamerasAlertDetails({required this.model});

  final CameraAlertResponseModel model;

  @override
  List<Object> get props => <Object>[model];
}

class HandleAlert extends CamerasEvent {
  const HandleAlert({required this.id});

  final int id;

  @override
  List<Object> get props => <Object>[id];
}
