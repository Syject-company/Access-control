import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => <Object>[];
}

class SearchInitial extends SearchState {}

class PassportOrIDFieldSelected extends SearchState {
  const PassportOrIDFieldSelected(
      {required this.isPassportSelected, required this.isIdSelected});

  final bool isPassportSelected;
  final bool isIdSelected;

  @override
  List<Object> get props => <Object>[isPassportSelected, isIdSelected];
}

class WorkerPhotoChanged extends SearchState {
  const WorkerPhotoChanged({
    required this.image,
  });

  final File image;

  @override
  List<Object> get props => <Object>[image];
}

class WorkerPhotoUpdated extends SearchState {
  const WorkerPhotoUpdated({
    required this.image,
  });

  final File image;

  @override
  List<Object> get props => <Object>[image];
}

class ClearFieldsData extends SearchState {
  const ClearFieldsData({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class ProjectSelected extends SearchState {
  const ProjectSelected({required this.project, required this.updateKey});

  final String project;
  final Key updateKey;

  @override
  List<Object> get props => <Object>[project, updateKey];
}

class FieldChangesChecked extends SearchState {
  const FieldChangesChecked({required this.value, required this.isReachLimit});

  final String value;
  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[value, isReachLimit];
}

class LimitCharErrorShown extends SearchState {
  const LimitCharErrorShown({required this.isReachLimit});

  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[isReachLimit];
}

class ProjectActiveOrNotChanged extends SearchState {
  const ProjectActiveOrNotChanged({required this.isActive});

  final bool isActive;

  @override
  List<Object> get props => <Object>[isActive];
}

class MoreItemsResultViewed extends SearchState {
  const MoreItemsResultViewed({required this.newItems});

  final List<SearchWorkersResponseModel> newItems;

  @override
  List<Object> get props => <Object>[newItems];
}

class WorkerDataEdited extends SearchState {
  const WorkerDataEdited({
    required this.image,
    required this.numberId,
  });

  final File? image;
  final String? numberId;

  @override
  List<Object> get props => <Object>[image!, numberId!];
}

class WorkersAfterEditInformed extends SearchState {
  const WorkersAfterEditInformed({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class WorkersAfterEditGot extends SearchState {
  const WorkersAfterEditGot({required this.items});

  final List<SearchWorkersResponseModel> items;

  @override
  List<Object> get props => <Object>[items];
}
