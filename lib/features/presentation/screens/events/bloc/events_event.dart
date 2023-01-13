import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/features/data/entities/common/events_search_parameters_model.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => <Object>[];
}

class LaunchEventsSearchResult extends EventsEvent {
  const LaunchEventsSearchResult({
    required this.modelParameters,
  });

  final EventsSearchParametersModel modelParameters;

  @override
  List<Object> get props => <Object>[modelParameters];
}

class StartNewSearch extends EventsEvent {
  const StartNewSearch();

  @override
  List<Object> get props => <Object>[];
}

class SaveEventReport extends EventsEvent {
  const SaveEventReport({required this.items});

  final List<EventsSearchResponseModel> items;

  @override
  List<Object> get props => <Object>[items];
}

class SelectProject extends EventsEvent {
  const SelectProject({required this.project});

  final String project;

  @override
  List<Object> get props => <Object>[project];
}

class ShowLimitCharError extends EventsEvent {
  const ShowLimitCharError({required this.isReachLimit});

  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[isReachLimit];
}

class ChangeProjectActiveOrNot extends EventsEvent {
  const ChangeProjectActiveOrNot({required this.isActive});

  final bool isActive;

  @override
  List<Object> get props => <Object>[isActive];
}

class ChangeShownFirstAppearanceOrNot extends EventsEvent {
  const ChangeShownFirstAppearanceOrNot({required this.isFirst});

  final bool isFirst;

  @override
  List<Object> get props => <Object>[isFirst];
}

class ChangeDateTimeRange extends EventsEvent {
  const ChangeDateTimeRange({required this.dateRange});

  final DateTimeRange? dateRange;

  @override
  List<Object> get props => <Object>[dateRange!];
}

class ViewMoreItemsResult extends EventsEvent {
  const ViewMoreItemsResult(
      {required this.allItems, required this.viewedItemsCont});

  final List<EventsSearchResponseModel> allItems;
  final int viewedItemsCont;

  @override
  List<Object> get props => <Object>[allItems, viewedItemsCont];
}

class GetEventsAlerts extends EventsEvent {
  const GetEventsAlerts({required this.offset, required this.projectId});

  final int offset;
  final int projectId;

  @override
  List<Object> get props => <Object>[offset, projectId];
}

class CheckLastSelectedProject extends EventsEvent {
  const CheckLastSelectedProject();

  @override
  List<Object> get props => <Object>[];
}

class ShowHideLoadMoreIndicator extends EventsEvent {
  const ShowHideLoadMoreIndicator({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}
