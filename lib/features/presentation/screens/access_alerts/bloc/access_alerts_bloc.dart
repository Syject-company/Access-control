import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/core/values_holder/access_alert_search_data.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/features/data/entities/requests/access_alert_search_request_model.dart';
import 'package:safe_access/features/data/entities/requests/handle_access_alert_request_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_main_response_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/domain/repositories/access_alert_manager.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_event.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_state.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/pages/access_alert_details.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/pages/access_alert_search_details.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/pages/access_alert_search_result.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/pages/access_alerts_search_screen.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';

class AccessAlertsBloc extends Bloc<AccessAlertsEvent, AccessAlertsState>
    with AccessAlertManager {
  AccessAlertsBloc() : super(AccessAlertsInitial()) {
    on<GetAccessAlerts>(
      (GetAccessAlerts event, Emitter<AccessAlertsState> emit) async {
        await _getAlerts(emit: emit, offset: event.offset);
      },
    );
    on<GetAccessAlertsFilter>(
      (GetAccessAlertsFilter event, Emitter<AccessAlertsState> emit) async {
        await _getAlertsByClassification(
            emit: emit,
            offset: event.offset,
            classificationIds: event.classificationsIds);
      },
    );
    on<GetSearchAccessAlerts>(
      (GetSearchAccessAlerts event, Emitter<AccessAlertsState> emit) async {
        await _getAlertsSearch(emit: emit, event: event);
      },
    );
    on<ShowHideLoadMoreIndicator>(
      (ShowHideLoadMoreIndicator event, Emitter<AccessAlertsState> emit) async {
        emit(LoadMoreIndicatorShownHidden(isShown: event.isShown));
      },
    );
    on<ShowHideLoadMoreIndicatorSearch>(
      (ShowHideLoadMoreIndicatorSearch event,
          Emitter<AccessAlertsState> emit) async {
        emit(LoadMoreIndicatorSearchShownHidden(isShown: event.isShown));
      },
    );
    on<ShowLimitCharError>(
      (ShowLimitCharError event, Emitter<AccessAlertsState> emit) async {
        emit(LimitCharErrorShown(isReachLimit: event.isReachLimit));
      },
    );
    on<LaunchAccessAlertDetails>(
      (LaunchAccessAlertDetails event, Emitter<AccessAlertsState> emit) {
        _launchAccessAlertDetails(event.model);
      },
    );
    on<HandleAlert>(
      (HandleAlert event, Emitter<AccessAlertsState> emit) async {
        await _handleAccessAlert(
          emit: emit,
          id: event.id,
          alertType: event.alertType,
        );
      },
    );
    on<ShowFilterDialog>(
      (ShowFilterDialog event, Emitter<AccessAlertsState> emit) {
        emit(FilterDialogShown(updateKey: UniqueKey()));
      },
    );
    on<LaunchAccessAlertsSearch>(
      (LaunchAccessAlertsSearch event, Emitter<AccessAlertsState> emit) {
        _launchAccessAlertSearch();
      },
    );
    on<LaunchAccessAlertsSearchResult>(
      (LaunchAccessAlertsSearchResult event,
          Emitter<AccessAlertsState> emit) async {
        await _launchAccessAlertSearchResult(model: event.model, emit: emit)
            .whenComplete(() =>
                emit(SearchAlertsControllerReset(updateKey: UniqueKey())));
      },
    );
    on<StartNewSearch>(
      (StartNewSearch event, Emitter<AccessAlertsState> emit) {
        getIt<Navigation>().pop();
        emit(ClearFieldsData(updateKey: UniqueKey()));
      },
    );
    on<LaunchAccessAlertSearchDetails>(
      (LaunchAccessAlertSearchDetails event, Emitter<AccessAlertsState> emit) {
        _launchAccessAlertSearchDetails(event);
      },
    );
    on<HandleAlertSearch>(
      (HandleAlertSearch event, Emitter<AccessAlertsState> emit) async {
        await _handleSearchAccessAlert(
            model: event.model,
            emit: emit,
            alertType: event.alertType,
            id: event.id);
      },
    );
    on<SelectProject>(
      (SelectProject event, Emitter<AccessAlertsState> emit) {
        emit(ProjectSelected(project: event.project, updateKey: UniqueKey()));
      },
    );
    on<ChangeProjectActiveOrNot>(
      (ChangeProjectActiveOrNot event, Emitter<AccessAlertsState> emit) {
        emit(ProjectActiveOrNotChanged(isActive: event.isActive));
      },
    );
    on<ViewMoreItemsResult>(
      (ViewMoreItemsResult event, Emitter<AccessAlertsState> emit) {
        final List<AccessAlertResponseModel> newList =
            event.allItems.subAlerts(event.viewedItemsCont);

        emit(MoreItemsResultViewed(newItems: newList));
      },
    );
    on<ViewMoreItemsFilterResult>(
      (ViewMoreItemsFilterResult event, Emitter<AccessAlertsState> emit) {
        final List<AccessAlertResponseModel> newList =
            event.allItems.subAlerts(event.viewedItemsCont);

        emit(MoreItemsFilterResultViewed(newItems: newList));
      },
    );
    on<SearchViewMoreItemsResult>(
      (SearchViewMoreItemsResult event, Emitter<AccessAlertsState> emit) {
        final List<AccessAlertResponseModel> newList =
            event.allItems.subAlerts(event.viewedItemsCont);

        emit(SearchMoreItemsResultViewed(newItems: newList));
      },
    );
    on<ChangeDateTimeRange>(
      (ChangeDateTimeRange event, Emitter<AccessAlertsState> emit) {
        emit(DateTimeRangeChanged(dateRange: event.dateRange));
      },
    );
    on<ReloadTheAlertImage>(
      (ReloadTheAlertImage event, Emitter<AccessAlertsState> emit) {
        emit(TheAlertImageReloaded(
            imageUrl: event.imageUrl, updateKey: UniqueKey()));
      },
    );
  }

  Future<void> _getAlerts(
          {required Emitter<AccessAlertsState> emit, required int offset}) =>
      getAccessAlert(offset: offset).then((AccessAlertMainResponseModel value) {
        if (value != null && value.rows != null) {
          offset == 0
              ? emit(AccessAlertsGot(
                  model: value.rows!, itemsCount: value.count ?? 0))
              : emit(AccessAlertsGotLoadMore(model: value.rows!));
          logInfo(
              'Get access alert has been successfully, count: ${value.rows?.length}');
        }
      }).catchError((dynamic onError) {
        emit(const AccessAlertsGot(
            model: <AccessAlertResponseModel>[], itemsCount: 0));
      });

  Future<void> _getAlertsByClassification({
    required Emitter<AccessAlertsState> emit,
    required int offset,
    required List<int> classificationIds,
  }) =>
      getAccessAlertByClassification(
        offset: offset,
        classificationIds: classificationIds,
      ).then((AccessAlertMainResponseModel value) {
        if (value != null && value.rows != null) {
          offset == 0
              ? emit(AccessAlertsFilterGot(
                  model: value.rows!, itemsCount: value.count ?? 0))
              : emit(AccessAlertsFilterGotLoadMore(model: value.rows!));
          logInfo(
              'Get access alert by classification has been successfully, count: ${value.rows?.length}');
        }
      }).catchError((dynamic onError) {
        emit(const AccessAlertsFilterGot(
            model: <AccessAlertResponseModel>[], itemsCount: 0));
      });

  Future<void> _getAlertsSearch({
    required Emitter<AccessAlertsState> emit,
    required GetSearchAccessAlerts event,
  }) =>
      searchAccessAlerts(
          model: AccessAlertSearchRequestModel(
        offset: event.offset,
        fromDate: getIt<AccessAlertSearchData>()
                .selectedDateRange
                ?.start
                .toString() ??
            '',
        toDate: getIt<AccessAlertSearchData>()
                .selectedDateRange
                ?.end
                .formattedRangeToDate ??
            '',
        projectId: event.projectId,
        active: event.isActiveProject,
        identificationNumber: event.identificationNumber,
        classification:
            getIt<AccessAlertSearchData>().selectedClassifications.isNotEmpty
                ? ItemsData.classifications.classificationId(
                    getIt<AccessAlertSearchData>().selectedClassifications)
                : null,
        handled: getIt<AccessAlertSearchData>().selectedStatus.stateStatus,
      )).then((AccessAlertMainResponseModel? value) {
        if (value != null && value.rows != null) {
          event.offset == 0
              ? emit(SearchAccessAlertsHandledListUpdated(model: value.rows!))
              : emit(SearchAccessAlertsGotLoadMore(model: value.rows!));
          logInfo(
              'Get access alert has been successfully, count: ${value.rows?.length}');
        }
      });

  Future<void> _handleAccessAlert(
          {required Emitter<AccessAlertsState> emit,
          required int id,
          required String alertType}) =>
      handleAccessAlert(
          model: HandleAccessAlertRequestModel(
        alertId: id,
        alertType: alertType,
      )).then((dynamic value) async {
        logInfo('Access alert screen: handled Access alert, id: $id');
        getIt<Navigation>().pop();
        emit(const LoadingShown());
        await _getAlerts(emit: emit, offset: 0);
      });

  Future<void> _handleSearchAccessAlert(
          {required Emitter<AccessAlertsState> emit,
          required int id,
          required String alertType,
          required AccessAlertResponseModel model}) =>
      handleAccessAlert(
          model: HandleAccessAlertRequestModel(
        alertId: id,
        alertType: alertType,
      )).then((dynamic value) async {
        logInfo('Access alert search screen: handled Access alert, id: $id');
        getIt<Navigation>().pop();
        emit(AlertSearchHandled(model: model));
      });

  void _launchAccessAlertDetails(AccessAlertResponseModel model) {
    logInfo('Launched Access alert details page');
    getIt<Navigation>()
        .toPageRouteProvider<AccessAlertDetails, AccessAlertsBloc>(
      page: AccessAlertDetails(
          model: model,
          image: model.person?.image?.imgUrl ?? model.image?.imgUrl ?? ''),
      bloc: this,
    );
  }

  void _launchAccessAlertSearch() {
    logInfo('Launched Access alert search page');
    getIt<Navigation>()
        .toPageRouteProvider<AccessAlertsSearchScreen, AccessAlertsBloc>(
      page: const AccessAlertsSearchScreen(),
      bloc: this,
    );
  }

  Future<void> _launchAccessAlertSearchResult(
      {required AccessAlertSearchRequestModel model,
      required Emitter<AccessAlertsState> emit}) async {
    await searchAccessAlerts(model: model)
        .then((AccessAlertMainResponseModel? value) {
      logInfo('Launched Access alert search result page');
      getIt<Navigation>()
          .toPageRouteProvider<AccessAlertSearchResult, AccessAlertsBloc>(
        page: AccessAlertSearchResult(
            projectId: model.projectId,
            identificationNumber: model.identificationNumber,
            isActiveProject: model.active,
            itemsCount: value?.count ?? 0,
            items: value?.rows ?? <AccessAlertResponseModel>[],
            isNotHandled: model.handled ?? false),
        bloc: this,
      );
    });
  }

  void _launchAccessAlertSearchDetails(LaunchAccessAlertSearchDetails event) {
    logInfo('Launched Access alert search details page');
    getIt<Navigation>()
        .toPageRouteProvider<AccessAlertSearchDetails, AccessAlertsBloc>(
      page: AccessAlertSearchDetails(
        model: event.model,
        isHandled: event.isNotHandled,
        image: event.model.person?.image?.imgUrl ??
            event.model.image?.imgUrl ??
            '',
      ),
      bloc: this,
    );
  }
}
