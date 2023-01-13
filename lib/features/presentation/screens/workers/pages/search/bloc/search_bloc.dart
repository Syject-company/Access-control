import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';
import 'package:safe_access/features/data/entities/responses/worker_data_response_model.dart';
import 'package:safe_access/features/domain/repositories/worker_manager.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_state.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/worker_details.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/worker_edit_details.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/worker_edit_photo.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/workers_search_results.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> with WorkerManager {
  SearchBloc() : super(SearchInitial()) {
    on<LaunchSearchResults>(
      (LaunchSearchResults event, Emitter<SearchState> emit) async {
        await _launchSearchResults(event: event);
      },
    );
    on<LaunchWorkerDetails>(
      (LaunchWorkerDetails event, Emitter<SearchState> emit) {
        _launchWorkerDetails(event.model, event.projectId);
      },
    );
    on<LaunchWorkerEditDetails>(
      (LaunchWorkerEditDetails event, Emitter<SearchState> emit) async {
        await _launchWorkerEditDetails(event: event);
      },
    );
    on<SelectPassportOrIDField>(
      (SelectPassportOrIDField event, Emitter<SearchState> emit) {
        emit(
          PassportOrIDFieldSelected(
            isPassportSelected: event.isPassportSelected,
            isIdSelected: event.isIdSelected,
          ),
        );
      },
    );
    on<LaunchWorkerEditPhoto>(
      (LaunchWorkerEditPhoto event, Emitter<SearchState> emit) {
        _launchWorkerEditPhoto(event.image, event.imageFile);
      },
    );
    on<ChangeWorkerPhoto>(
      (ChangeWorkerPhoto event, Emitter<SearchState> emit) {
        emit(WorkerPhotoChanged(image: event.image));
      },
    );
    on<UpdateWorkerPhoto>(
      (UpdateWorkerPhoto event, Emitter<SearchState> emit) {
        emit(WorkerPhotoUpdated(image: event.image));
      },
    );
    on<StartNewSearch>(
      (StartNewSearch event, Emitter<SearchState> emit) {
        getIt<Navigation>().pop();
        emit(ClearFieldsData(updateKey: UniqueKey()));
      },
    );
    on<OverrideWorkerData>(
      (OverrideWorkerData event, Emitter<SearchState> emit) async {
        await workerUpdateData(
                identificationType: event.identificationType,
                identificationNumber: event.identificationNumber,
                personId: event.personId,
                image: event.image,
                countryId: 1)
            .then((dynamic value) {
          logInfo(
              'Worker search updated worker data. person id:${event.personId}');
          getIt<Navigation>().pop();
          emit(WorkerDataEdited(
              image: event.image, numberId: event.identificationNumber));
        });
      },
    );
    on<SelectProject>(
      (SelectProject event, Emitter<SearchState> emit) {
        emit(ProjectSelected(project: event.project, updateKey: UniqueKey()));
      },
    );
    on<CheckFieldChanges>(
      (CheckFieldChanges event, Emitter<SearchState> emit) {
        emit(FieldChangesChecked(
          value: event.value,
          isReachLimit: event.isReachLimit,
        ));
      },
    );
    on<ShowLimitCharError>(
      (ShowLimitCharError event, Emitter<SearchState> emit) {
        emit(LimitCharErrorShown(
          isReachLimit: event.isReachLimit,
        ));
      },
    );
    on<ChangeProjectActiveOrNot>(
      (ChangeProjectActiveOrNot event, Emitter<SearchState> emit) {
        emit(ProjectActiveOrNotChanged(isActive: event.isActive));
      },
    );
    on<ViewMoreItemsResult>(
      (ViewMoreItemsResult event, Emitter<SearchState> emit) {
        final List<SearchWorkersResponseModel> newList =
            event.allItems.subWorkers(event.viewedItemsCont);

        emit(MoreItemsResultViewed(newItems: newList));
      },
    );
    on<InformWorkersAfterEdit>(
      (InformWorkersAfterEdit event, Emitter<SearchState> emit) {
        emit(WorkersAfterEditInformed(updateKey: UniqueKey()));
      },
    );
    on<GetWorkersAfterEdit>(
      (GetWorkersAfterEdit event, Emitter<SearchState> emit) async {
        await _getWorkers(
          projectId: event.projectId,
          classificationIds: event.classificationIds,
          employerIds: event.employerIds,
          positionIds: event.positionIds,
          idNumber: event.idNumber,
        )
            .then((List<SearchWorkersResponseModel>? value) => emit(
                WorkersAfterEditGot(
                    items: value ?? <SearchWorkersResponseModel>[])))
            .catchError((dynamic error) {
          const WorkersAfterEditGot(items: <SearchWorkersResponseModel>[]);
        });
      },
    );
  }

  Future<void> _launchSearchResults(
      {required LaunchSearchResults event}) async {
    await _getWorkers(
      projectId: event.projectId,
      classificationIds: event.classificationIds,
      employerIds: event.employerIds,
      positionIds: event.positionIds,
      idNumber: event.idNumber,
    ).then((List<SearchWorkersResponseModel>? model) {
      logInfo('Worker search get workers has been successfully');
      getIt<Navigation>().toPageRouteProvider<WorkersSearchResults, SearchBloc>(
        page: WorkersSearchResults(
          items: model ?? <SearchWorkersResponseModel>[],
          projectId: event.projectId,
          classificationIds: event.classificationIds,
          employerIds: event.employerIds,
          positionIds: event.positionIds,
          idNumber: event.idNumber,
        ),
        bloc: this,
      );
    });
  }

  Future<List<SearchWorkersResponseModel>?> _getWorkers({
    required int projectId,
    required List<int> positionIds,
    required String idNumber,
    required List<int> classificationIds,
    required List<int> employerIds,
  }) =>
      getWorkers(
        projectId: projectId,
        classificationIds: classificationIds,
        employerIds: employerIds,
        positionIds: positionIds,
        idNumber: idNumber,
      );

  void _launchWorkerDetails(SearchWorkersResponseModel model, int projectId) {
    logInfo('Worker search lunched search worker details');
    getIt<Navigation>().toPageRouteProvider<WorkerDetails, SearchBloc>(
      page: WorkerDetails(model: model, projectId: projectId),
      bloc: this,
    );
  }

  Future<void> _launchWorkerEditDetails(
      {required LaunchWorkerEditDetails event}) async {
    await getWorkerByID(
            projectId: event.projectId,
            idNumber: event.numberId,
            idType: event.idType ?? 1)
        .then((WorkerDataResponseModel? model) {
      logInfo('Worker search get worker by id has been successfully');
      getIt<Navigation>().toPageRouteProvider<WorkerEditDetails, SearchBloc>(
        page: WorkerEditDetails(
          imageFile: event.imageFile,
          image: event.image,
          projectId: event.projectId,
          model: model,
          idType: event.idType ?? 1,
          idNumber: event.numberId,
        ),
        bloc: this,
      );
    });
  }

  void _launchWorkerEditPhoto(String? image, File? imageFile) {
    getIt<Navigation>().toPageRouteProvider<WorkerEditPhoto, SearchBloc>(
      page: WorkerEditPhoto(image: image, imageFile: imageFile),
      bloc: this,
    );
  }
}
