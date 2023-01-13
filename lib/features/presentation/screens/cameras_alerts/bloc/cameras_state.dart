import 'package:equatable/equatable.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';

abstract class CamerasState extends Equatable {
  const CamerasState();

  @override
  List<Object> get props => <Object>[];
}

class CamerasInitial extends CamerasState {}

class CameraAlertsGot extends CamerasState {
  const CameraAlertsGot({required this.data});

  final List<CameraAlertResponseModel> data;

  @override
  List<Object> get props => <Object>[data];
}

class LoadingShown extends CamerasState {
  const LoadingShown();

  @override
  List<Object> get props => <Object>[];
}
