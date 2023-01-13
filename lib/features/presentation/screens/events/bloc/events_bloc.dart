import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/core/services/pdf_report_service.dart';
import 'package:safe_access/core/values_holder/employers_data.dart';
import 'package:safe_access/core/values_holder/events_search_data.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/position_data.dart';
import 'package:safe_access/features/data/entities/responses/events_search_main_response_model.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';
import 'package:safe_access/features/domain/repositories/events_manager.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_event.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_state.dart';
import 'package:safe_access/features/presentation/screens/events/pages/event_search_result.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> with EventsManager {
  EventsBloc() : super(EventsInitial()) {
    on<CheckLastSelectedProject>(
      (CheckLastSelectedProject event, Emitter<EventsState> emit) async {
        final String? _lastProject =
            await getIt<Storage>().getEventsLastSelectedProject();

        emit(LastSelectedProjectChecked(project: _lastProject));
      },
    );
    on<ShowHideLoadMoreIndicator>(
      (ShowHideLoadMoreIndicator event, Emitter<EventsState> emit) async {
        emit(LoadMoreIndicatorShownHidden(isShown: event.isShown));
      },
    );
    on<LaunchEventsSearchResult>(
      (LaunchEventsSearchResult event, Emitter<EventsState> emit) async {
        await _launchEventSearchResult(event).whenComplete(
            () => emit(SearchEventsControllerReset(updateKey: UniqueKey())));
      },
    );
    on<StartNewSearch>(
      (StartNewSearch event, Emitter<EventsState> emit) {
        getIt<Navigation>().pop();
        emit(ClearFieldsData(updateKey: UniqueKey()));
      },
    );
    on<SaveEventReport>(
      (SaveEventReport event, Emitter<EventsState> emit) {
        _saveReport(event.items);
      },
    );
    on<SelectProject>(
      (SelectProject event, Emitter<EventsState> emit) {
        emit(ProjectSelected(project: event.project, updateKey: UniqueKey()));
      },
    );
    on<ShowLimitCharError>(
      (ShowLimitCharError event, Emitter<EventsState> emit) {
        emit(LimitCharErrorShown(isReachLimit: event.isReachLimit));
      },
    );
    on<ChangeProjectActiveOrNot>(
      (ChangeProjectActiveOrNot event, Emitter<EventsState> emit) {
        emit(ProjectActiveOrNotChanged(isActive: event.isActive));
      },
    );
    on<ChangeShownFirstAppearanceOrNot>(
      (ChangeShownFirstAppearanceOrNot event, Emitter<EventsState> emit) {
        emit(FirstAppearanceOrNotChanged(isFirst: event.isFirst));
      },
    );
    on<ChangeDateTimeRange>(
      (ChangeDateTimeRange event, Emitter<EventsState> emit) {
        emit(DateTimeRangeChanged(dateRange: event.dateRange));
      },
    );
    on<ViewMoreItemsResult>(
      (ViewMoreItemsResult event, Emitter<EventsState> emit) {
        final List<EventsSearchResponseModel> newList =
            event.allItems.subEvents(event.viewedItemsCont);

        emit(MoreItemsResultViewed(newItems: newList));
      },
    );
    on<GetEventsAlerts>(
      (GetEventsAlerts event, Emitter<EventsState> emit) async {
        await _getMoreEvents(
            emit: emit, offset: event.offset, projectId: event.projectId);
      },
    );
  }

  Future<void> _launchEventSearchResult(LaunchEventsSearchResult event) async {
    logInfo('Launched Events search page');
    await getEvents(
            offset: 0,
            isFirstAppearance: event.modelParameters.isFirstAppearance,
            toDate: event.modelParameters.toDate,
            fromDate: event.modelParameters.fromDate,
            classificationIds: event.modelParameters.classificationIds,
            isActiveProject: event.modelParameters.isActiveProject,
            employerIds: event.modelParameters.employerIds,
            positionIds: event.modelParameters.positionIds,
            projectId: event.modelParameters.projectId)
        .then((EventsSearchMainResponseModel? model) {
      logInfo('Events search page results count ${model?.rows?.length}');
      getIt<Navigation>().toPageRouteProvider<EventSearchResult, EventsBloc>(
        page: EventSearchResult(
          projectId: event.modelParameters.projectId,
          allEventsCount: model?.count ?? 0,
          items: model?.rows ?? <EventsSearchResponseModel>[],
        ),
        bloc: this,
      );
    });
  }

  Future<void> _getMoreEvents(
          {required Emitter<EventsState> emit,
          required int offset,
          required int projectId}) =>
      getEvents(
              isFirstAppearance: getIt<EventsSearchData>().isFirstAppearance,
              offset: offset,
              toDate: getIt<EventsSearchData>()
                      .selectedDateRange
                      ?.end
                      .formattedRangeToDate ??
                  '',
              fromDate: getIt<EventsSearchData>()
                      .selectedDateRange
                      ?.start
                      .toString() ??
                  '',
              classificationIds: ItemsData.classifications.classificationId(
                  getIt<EventsSearchData>().selectedClassifications),
              isActiveProject: getIt<EventsSearchData>().isShownActiveProjects,
              employerIds: getIt<EmployersData>()
                  .employers
                  .employersId(getIt<EventsSearchData>().selectedEmployers),
              positionIds: getIt<PositionsData>()
                  .positions
                  .positionsId(getIt<EventsSearchData>().selectedPositions),
              projectId: projectId)
          .then((EventsSearchMainResponseModel? value) {
        if (value != null && value.rows != null) {
          emit(EventsGotLoadMore(model: value.rows!));
          logInfo(
              'Get events has been successfully, count: ${value.rows?.length}');
        }
      });

  Future<void> _saveReport(List<EventsSearchResponseModel> items) async {
    logInfo('Events search page results report is saved');
    final Uint8List report =
        await getIt<PDFReportService>().createPDFReport(items);
    getIt<PDFReportService>()
        .savePdfFile(byteList: report, count: items.length);
  }
}
