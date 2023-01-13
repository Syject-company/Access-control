import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

class LaunchPage extends HomeEvent {
  const LaunchPage({required this.route});

  final String route;

  @override
  List<Object> get props => <Object>[route];
}

class ShowLogOutDialog extends HomeEvent {
  const ShowLogOutDialog();

  @override
  List<Object> get props => <Object>[];
}

class LogOut extends HomeEvent {
  const LogOut();

  @override
  List<Object> get props => <Object>[];
}

class ResponseProjEmplPosition extends HomeEvent {
  const ResponseProjEmplPosition();

  @override
  List<Object> get props => <Object>[];
}

class UpdateFirebaseToken extends HomeEvent {
  const UpdateFirebaseToken();

  @override
  List<Object> get props => <Object>[];
}

class CheckFCMDataEmpty extends HomeEvent {
  const CheckFCMDataEmpty();

  @override
  List<Object> get props => <Object>[];
}

class HandleAccessAlert extends HomeEvent {
  const HandleAccessAlert({required this.id, required this.alertType});

  final int id;
  final String alertType;

  @override
  List<Object> get props => <Object>[id, alertType];
}

class HandleHardwareAlert extends HomeEvent {
  const HandleHardwareAlert({required this.id});

  final int id;

  @override
  List<Object> get props => <Object>[id];
}

class ShowFCMDataLoading extends HomeEvent {
  const ShowFCMDataLoading({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}

class ReloadTheAlertImage extends HomeEvent {
  const ReloadTheAlertImage({required this.imageUrl});

  final String imageUrl;

  @override
  List<Object> get props => <Object>[imageUrl];
}
