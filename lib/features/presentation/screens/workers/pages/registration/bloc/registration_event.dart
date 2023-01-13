import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => <Object>[];
}

class SelectPassportOrIDField extends RegistrationEvent {
  const SelectPassportOrIDField(
      {required this.isPassportSelected, required this.isIdSelected});

  final bool isPassportSelected;
  final bool isIdSelected;

  @override
  List<Object> get props => <Object>[isPassportSelected, isIdSelected];
}

class NavigateToNextPage extends RegistrationEvent {
  const NavigateToNextPage(
      {required this.projectId,
      required this.project,
      required this.typeId,
      required this.passportOrID});

  final int projectId;
  final String project;
  final int typeId;
  final String passportOrID;

  @override
  List<Object> get props => <Object>[projectId, project, typeId, passportOrID];
}

class UpdateWorkerPhoto extends RegistrationEvent {
  const UpdateWorkerPhoto({
    required this.image,
  });

  final File image;

  @override
  List<Object> get props => <Object>[image];
}

class RegisterNewWorker extends RegistrationEvent {
  const RegisterNewWorker({
    required this.image,
    required this.projectId,
    required this.selectedProject,
    required this.typeId,
    required this.selectedPassportOrID,
  });

  final File image;
  final int projectId;
  final String selectedProject;
  final int typeId;
  final String selectedPassportOrID;

  @override
  List<Object> get props =>
      <Object>[projectId, image, selectedProject, typeId, selectedPassportOrID];
}

class OverrideIDPassport extends RegistrationEvent {
  const OverrideIDPassport({
    required this.projectId,
    required this.personId,
    required this.idNumber,
    required this.idType,
    required this.selectedProject,
    required this.selectedIDPassport,
    required this.isFoundOnCurrentProject,
  });

  final int personId;
  final String idNumber;
  final int projectId;
  final int idType;
  final String selectedProject;
  final String selectedIDPassport;
  final bool isFoundOnCurrentProject;

  @override
  List<Object> get props => <Object>[
        personId,
        idNumber,
        projectId,
        idType,
        selectedProject,
        selectedIDPassport,
        isFoundOnCurrentProject,
      ];
}

class RegisterToAnotherProject extends RegistrationEvent {
  const RegisterToAnotherProject({
    required this.passportId,
    required this.selectedProject,
    required this.projectID,
    required this.personId,
  });

  final String selectedProject;
  final int projectID;
  final String passportId;
  final int personId;

  @override
  List<Object> get props =>
      <Object>[projectID, selectedProject, passportId, personId];
}

class HideNotify extends RegistrationEvent {
  const HideNotify();

  @override
  List<Object> get props => <Object>[];
}

class CheckNextButtonClickable extends RegistrationEvent {
  const CheckNextButtonClickable({
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
