import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/features/data/entities/requests/access_alert_search_request_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';

abstract class AccessAlertsEvent extends Equatable {
  const AccessAlertsEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetAccessAlerts extends AccessAlertsEvent {
  const GetAccessAlerts({required this.offset});

  final int offset;

  @override
  List<Object> get props => <Object>[offset];
}

class GetAccessAlertsFilter extends AccessAlertsEvent {
  const GetAccessAlertsFilter({
    required this.offset,
    required this.classificationsIds,
  });

  final int offset;
  final List<int> classificationsIds;

  @override
  List<Object> get props => <Object>[offset, classificationsIds];
}

class GetSearchAccessAlerts extends AccessAlertsEvent {
  const GetSearchAccessAlerts({
    required this.offset,
    required this.identificationNumber,
    required this.projectId,
    required this.isActiveProject,
  });

  final int offset;
  final int projectId;
  final bool? isActiveProject;
  final String? identificationNumber;

  @override
  List<Object> get props =>
      <Object>[offset, projectId, isActiveProject!, identificationNumber!];
}

class LaunchAccessAlertDetails extends AccessAlertsEvent {
  const LaunchAccessAlertDetails({required this.model});

  final AccessAlertResponseModel model;

  @override
  List<Object> get props => <Object>[model];
}

class HandleAlert extends AccessAlertsEvent {
  const HandleAlert({required this.id, required this.alertType});

  final int id;
  final String alertType;

  @override
  List<Object> get props => <Object>[id, alertType];
}

class ShowFilterDialog extends AccessAlertsEvent {
  const ShowFilterDialog();

  @override
  List<Object> get props => <Object>[];
}

class LaunchAccessAlertsSearch extends AccessAlertsEvent {
  const LaunchAccessAlertsSearch();

  @override
  List<Object> get props => <Object>[];
}

class LaunchAccessAlertsSearchResult extends AccessAlertsEvent {
  const LaunchAccessAlertsSearchResult({
    required this.model,
  });

  final AccessAlertSearchRequestModel model;

  @override
  List<Object> get props => <Object>[model];
}

class StartNewSearch extends AccessAlertsEvent {
  const StartNewSearch();

  @override
  List<Object> get props => <Object>[];
}

class LaunchAccessAlertSearchDetails extends AccessAlertsEvent {
  const LaunchAccessAlertSearchDetails({
    required this.model,
    required this.isNotHandled,
  });

  final AccessAlertResponseModel model;
  final bool isNotHandled;

  @override
  List<Object> get props => <Object>[model, isNotHandled];
}

class HandleAlertSearch extends AccessAlertsEvent {
  const HandleAlertSearch({
    required this.id,
    required this.alertType,
    required this.model,
  });

  final int id;
  final String alertType;
  final AccessAlertResponseModel model;

  @override
  List<Object> get props => <Object>[id, alertType, model];
}

class SelectProject extends AccessAlertsEvent {
  const SelectProject({required this.project});

  final String project;

  @override
  List<Object> get props => <Object>[project];
}

class ChangeProjectActiveOrNot extends AccessAlertsEvent {
  const ChangeProjectActiveOrNot({required this.isActive});

  final bool isActive;

  @override
  List<Object> get props => <Object>[isActive];
}

class ShowLimitCharError extends AccessAlertsEvent {
  const ShowLimitCharError({required this.isReachLimit});

  final bool isReachLimit;

  @override
  List<Object> get props => <Object>[isReachLimit];
}

class ViewMoreItemsResult extends AccessAlertsEvent {
  const ViewMoreItemsResult(
      {required this.allItems, required this.viewedItemsCont});

  final List<AccessAlertResponseModel> allItems;
  final int viewedItemsCont;

  @override
  List<Object> get props => <Object>[allItems, viewedItemsCont];
}

class ViewMoreItemsFilterResult extends AccessAlertsEvent {
  const ViewMoreItemsFilterResult(
      {required this.allItems, required this.viewedItemsCont});

  final List<AccessAlertResponseModel> allItems;
  final int viewedItemsCont;

  @override
  List<Object> get props => <Object>[allItems, viewedItemsCont];
}

class SearchViewMoreItemsResult extends AccessAlertsEvent {
  const SearchViewMoreItemsResult(
      {required this.allItems, required this.viewedItemsCont});

  final List<AccessAlertResponseModel> allItems;
  final int viewedItemsCont;

  @override
  List<Object> get props => <Object>[allItems, viewedItemsCont];
}

class ChangeDateTimeRange extends AccessAlertsEvent {
  const ChangeDateTimeRange({required this.dateRange});

  final DateTimeRange? dateRange;

  @override
  List<Object> get props => <Object>[dateRange!];
}

class ShowHideLoadMoreIndicator extends AccessAlertsEvent {
  const ShowHideLoadMoreIndicator({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}

class ShowHideLoadMoreIndicatorSearch extends AccessAlertsEvent {
  const ShowHideLoadMoreIndicatorSearch({required this.isShown});

  final bool isShown;

  @override
  List<Object> get props => <Object>[isShown];
}

class ReloadTheAlertImage extends AccessAlertsEvent {
  const ReloadTheAlertImage({required this.imageUrl});

  final String imageUrl;

  @override
  List<Object> get props => <Object>[imageUrl];
}
