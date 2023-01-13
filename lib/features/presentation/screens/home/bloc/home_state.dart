import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => <Object>[];
}

class HomeInitial extends HomeState {}

class LogOutDialogShown extends HomeState {
  const LogOutDialogShown({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class LogOutError extends HomeState {
  const LogOutError({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class ProjEmplPositionRespond extends HomeState {
  const ProjEmplPositionRespond({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class AccessAlertCount extends HomeState {
  const AccessAlertCount({required this.alertCount});

  final int alertCount;

  @override
  List<Object> get props => <Object>[alertCount];
}

class CameraAlertCount extends HomeState {
  const CameraAlertCount({required this.alertCount});

  final int alertCount;

  @override
  List<Object> get props => <Object>[alertCount];
}

class FCMDataLoadingShown extends HomeState {
  const FCMDataLoadingShown({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}

class FirebaseTokenUpdated extends HomeState {
  const FirebaseTokenUpdated({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class TheAlertImageReloaded extends HomeState {
  const TheAlertImageReloaded(
      {required this.imageUrl, required this.updateKey});

  final String imageUrl;
  final Key updateKey;

  @override
  List<Object> get props => <Object>[imageUrl, updateKey];
}
