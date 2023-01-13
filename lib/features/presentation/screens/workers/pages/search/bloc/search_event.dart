import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => <Object>[];
}

class LaunchWorkerDetails extends SearchEvent {
  const LaunchWorkerDetails({required this.model, required this.projectId});

  final SearchWorkersResponseModel model;
  final int projectId;

  @override
  List<Object> get props => <Object>[model, projectId];
}

class LaunchWorkerEditDetails extends SearchEvent {
  const LaunchWorkerEditDetails({
    required this.image,
    required this.projectId,
    required this.numberId,
    required this.imageFile,
    required this.idType,
  });

  final String? image;
  final int projectId;
  final int? idType;
  final String numberId;
  final File? imageFile;

  @override
  List<Object> get props =>
      <Object>[image!, projectId, numberId, imageFile!, idType!];
}

class SelectPassportOrIDField extends SearchEvent {
  const SelectPassportOrIDField(
      {required this.isPassportSelected, required this.isIdSelected});

  final bool isPassportSelected;
  final bool isIdSelected;

  @override
  List<Object> get props => <Object>[isPassportSelected, isIdSelected];
}

class LaunchWorkerEditPhoto extends SearchEvent {
  const LaunchWorkerEditPhoto({
    required this.image,
    required this.imageFile,
  });

  final String? image;
  final File? imageFile;

  @override
  List<Object> get props => <Object>[image!, imageFile!];
}

class ChangeWorkerPhoto extends SearchEvent {
  const ChangeWorkerPhoto({
    required this.image,
  });

  final File image;

  @override
  List<Object> get props => <Object>[image];
}

class UpdateWorkerPhoto extends SearchEvent {
  const UpdateWorkerPhoto({
    required this.image,
  });

  final File image;

  @override
  List<Object> get props => <Object>[image];
}

class LaunchSearchResults extends SearchEvent {
  const LaunchSearchResults({
    required this.idNumber,
    required this.positionIds,
    required this.employerIds,
    required this.classificationIds,
    required this.projectId,
  });

  final int projectId;
  final String idNumber;
  final List<int> classificationIds;
  final List<int> employerIds;
  final List<int> positionIds;

  @override
  List<Object> get props => <Object>[
        projectId,
        idNumber,
        classificationIds,
        employerIds,
        positionIds
      ];
}

class StartNewSearch extends SearchEvent {
  const StartNewSearch();

  @override
  List<Object> get props => <Object>[];
}

class OverrideWorkerData extends SearchEvent {
  const OverrideWorkerData({
    required this.personId,
    required this.identificationType,
    required this.identificationNumber,
    required this.projectId,
    required this.image,
  });

  final int personId;
  final int identificationType;
  final String identificationNumber;
  final File? image;
  final int? projectId;

  @override
  List<Object> get props => <Object>[
        personId,
        image!,
        identificationType,
        identificationNumber,
        projectId!
      ];
}

class SelectProject extends SearchEvent {
  const SelectProject({required this.project});

  final String project;

  @override
  List<Object> get props => <Object>[project];
}

class CheckFieldChanges extends SearchEvent {
  const CheckFieldChanges({required this.value, required this.isReachLimit});

  final String value;
  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[value, isReachLimit];
}

class ShowLimitCharError extends SearchEvent {
  const ShowLimitCharError({required this.isReachLimit});

  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[isReachLimit];
}

class ChangeProjectActiveOrNot extends SearchEvent {
  const ChangeProjectActiveOrNot({required this.isActive});

  final bool isActive;

  @override
  List<Object> get props => <Object>[isActive];
}

class ViewMoreItemsResult extends SearchEvent {
  const ViewMoreItemsResult(
      {required this.allItems, required this.viewedItemsCont});

  final List<SearchWorkersResponseModel> allItems;
  final int viewedItemsCont;

  @override
  List<Object> get props => <Object>[allItems, viewedItemsCont];
}

class InformWorkersAfterEdit extends SearchEvent {
  const InformWorkersAfterEdit();

  @override
  List<Object> get props => <Object>[];
}

class GetWorkersAfterEdit extends SearchEvent {
  const GetWorkersAfterEdit({
    required this.projectId,
    required this.positionIds,
    required this.idNumber,
    required this.classificationIds,
    required this.employerIds,
  });

  final int projectId;
  final List<int> positionIds;
  final String idNumber;
  final List<int> classificationIds;
  final List<int> employerIds;

  @override
  List<Object> get props => <Object>[
        projectId,
        positionIds,
        idNumber,
        classificationIds,
        employerIds
      ];
}
