import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => <Object>[];
}

class RegistrationInitial extends RegistrationState {}

class PassportOrIDFieldSelected extends RegistrationState {
  const PassportOrIDFieldSelected(
      {required this.isPassportSelected, required this.isIdSelected});

  final bool isPassportSelected;
  final bool isIdSelected;

  @override
  List<Object> get props => <Object>[isPassportSelected, isIdSelected];
}

class WorkerPhotoUpdated extends RegistrationState {
  const WorkerPhotoUpdated({
    required this.image,
  });

  final File image;

  @override
  List<Object> get props => <Object>[image];
}

class UpdatedWorkerPhotoRefused extends RegistrationState {
  const UpdatedWorkerPhotoRefused();

  @override
  List<Object> get props => <Object>[];
}

class NotifyHidden extends RegistrationState {
  const NotifyHidden({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class NextButtonClickableChecked extends RegistrationState {
  const NextButtonClickableChecked({
    required this.project,
    required this.passportID,
    required this.isReachLimit,
  });

  final String project;
  final String passportID;
  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[project, passportID, isReachLimit];
}

class RegisterButtonReset extends RegistrationState {
  const RegisterButtonReset({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}
