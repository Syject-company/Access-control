import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';

abstract class AccessAlertsState extends Equatable {
  const AccessAlertsState();

  @override
  List<Object> get props => <Object>[];
}

class AccessAlertsInitial extends AccessAlertsState {}

class AccessAlertsGot extends AccessAlertsState {
  const AccessAlertsGot({required this.model, required this.itemsCount});

  final List<AccessAlertResponseModel> model;
  final int itemsCount;

  @override
  List<Object> get props => <Object>[model, itemsCount];
}

class AccessAlertsFilterGot extends AccessAlertsState {
  const AccessAlertsFilterGot({required this.model, required this.itemsCount});

  final List<AccessAlertResponseModel> model;
  final int itemsCount;

  @override
  List<Object> get props => <Object>[model, itemsCount];
}

class AccessAlertsGotLoadMore extends AccessAlertsState {
  const AccessAlertsGotLoadMore({required this.model});

  final List<AccessAlertResponseModel> model;

  @override
  List<Object> get props => <Object>[model];
}

class AccessAlertsFilterGotLoadMore extends AccessAlertsState {
  const AccessAlertsFilterGotLoadMore({required this.model});

  final List<AccessAlertResponseModel> model;

  @override
  List<Object> get props => <Object>[model];
}

class SearchAccessAlertsGotLoadMore extends AccessAlertsState {
  const SearchAccessAlertsGotLoadMore({required this.model});

  final List<AccessAlertResponseModel> model;

  @override
  List<Object> get props => <Object>[model];
}

class SearchAccessAlertsHandledListUpdated extends AccessAlertsState {
  const SearchAccessAlertsHandledListUpdated({required this.model});

  final List<AccessAlertResponseModel> model;

  @override
  List<Object> get props => <Object>[model];
}

class LoadingShown extends AccessAlertsState {
  const LoadingShown();

  @override
  List<Object> get props => <Object>[];
}

class FilterDialogShown extends AccessAlertsState {
  const FilterDialogShown({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class ClearFieldsData extends AccessAlertsState {
  const ClearFieldsData({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class AlertSearchHandled extends AccessAlertsState {
  const AlertSearchHandled({required this.model});

  final AccessAlertResponseModel model;

  @override
  List<Object> get props => <Object>[model];
}

class ProjectSelected extends AccessAlertsState {
  const ProjectSelected({required this.project, required this.updateKey});

  final String project;
  final Key updateKey;

  @override
  List<Object> get props => <Object>[project, updateKey];
}

class ProjectActiveOrNotChanged extends AccessAlertsState {
  const ProjectActiveOrNotChanged({required this.isActive});

  final bool isActive;

  @override
  List<Object> get props => <Object>[isActive];
}

class LimitCharErrorShown extends AccessAlertsState {
  const LimitCharErrorShown({required this.isReachLimit});

  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[isReachLimit];
}

class MoreItemsResultViewed extends AccessAlertsState {
  const MoreItemsResultViewed({required this.newItems});

  final List<AccessAlertResponseModel> newItems;

  @override
  List<Object> get props => <Object>[newItems];
}

class MoreItemsFilterResultViewed extends AccessAlertsState {
  const MoreItemsFilterResultViewed({required this.newItems});

  final List<AccessAlertResponseModel> newItems;

  @override
  List<Object> get props => <Object>[newItems];
}

class SearchMoreItemsResultViewed extends AccessAlertsState {
  const SearchMoreItemsResultViewed({required this.newItems});

  final List<AccessAlertResponseModel> newItems;

  @override
  List<Object> get props => <Object>[newItems];
}

class DateTimeRangeChanged extends AccessAlertsState {
  const DateTimeRangeChanged({required this.dateRange});

  final DateTimeRange? dateRange;

  @override
  List<Object> get props => <Object>[dateRange!];
}

class SearchAlertsControllerReset extends AccessAlertsState {
  const SearchAlertsControllerReset({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class LoadMoreIndicatorShownHidden extends AccessAlertsState {
  const LoadMoreIndicatorShownHidden({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}

class LoadMoreIndicatorSearchShownHidden extends AccessAlertsState {
  const LoadMoreIndicatorSearchShownHidden({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}

class TheAlertImageReloaded extends AccessAlertsState {
  const TheAlertImageReloaded(
      {required this.imageUrl, required this.updateKey});

  final String imageUrl;
  final Key updateKey;

  @override
  List<Object> get props => <Object>[imageUrl, updateKey];
}
