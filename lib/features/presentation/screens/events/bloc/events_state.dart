import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => <Object>[];
}

class EventsInitial extends EventsState {}

class ClearFieldsData extends EventsState {
  const ClearFieldsData({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class ProjectSelected extends EventsState {
  const ProjectSelected({required this.project, required this.updateKey});

  final String project;
  final Key updateKey;

  @override
  List<Object> get props => <Object>[project, updateKey];
}

class LimitCharErrorShown extends EventsState {
  const LimitCharErrorShown({required this.isReachLimit});

  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[isReachLimit];
}

class ProjectActiveOrNotChanged extends EventsState {
  const ProjectActiveOrNotChanged({required this.isActive});

  final bool isActive;

  @override
  List<Object> get props => <Object>[isActive];
}

class FirstAppearanceOrNotChanged extends EventsState {
  const FirstAppearanceOrNotChanged({required this.isFirst});

  final bool isFirst;

  @override
  List<Object> get props => <Object>[isFirst];
}

class DateTimeRangeChanged extends EventsState {
  const DateTimeRangeChanged({required this.dateRange});

  final DateTimeRange? dateRange;

  @override
  List<Object> get props => <Object>[dateRange!];
}

class SearchEventsControllerReset extends EventsState {
  const SearchEventsControllerReset({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class MoreItemsResultViewed extends EventsState {
  const MoreItemsResultViewed({required this.newItems});

  final List<EventsSearchResponseModel> newItems;

  @override
  List<Object> get props => <Object>[newItems];
}

class EventsGotLoadMore extends EventsState {
  const EventsGotLoadMore({required this.model});

  final List<EventsSearchResponseModel> model;

  @override
  List<Object> get props => <Object>[model];
}

class LastSelectedProjectChecked extends EventsState {
  const LastSelectedProjectChecked({required this.project});

  final String? project;

  @override
  List<Object> get props => <Object>[project!];
}

class LoadMoreIndicatorShownHidden extends EventsState {
  const LoadMoreIndicatorShownHidden({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}
