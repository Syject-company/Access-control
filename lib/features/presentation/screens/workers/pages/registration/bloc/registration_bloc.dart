import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/core/values_holder/worker_register_notify_data.dart';
import 'package:safe_access/features/data/entities/requests/worker_assign_to_project_request_model.dart';
import 'package:safe_access/features/data/entities/responses/worker_data_response_model.dart';
import 'package:safe_access/features/domain/repositories/worker_manager.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_state.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/registration_exists_database.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/registration_exists_project.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/registration_found_by_photo.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/registration_new_worker.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show WorkerRegisterNotifyType, DateTimeExtension;

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>
    with WorkerManager {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<SelectPassportOrIDField>(
      (SelectPassportOrIDField event, Emitter<RegistrationState> emit) {
        emit(
          PassportOrIDFieldSelected(
            isPassportSelected: event.isPassportSelected,
            isIdSelected: event.isIdSelected,
          ),
        );
      },
    );
    on<NavigateToNextPage>(
      (NavigateToNextPage event, Emitter<RegistrationState> emit) async {
        await _checkWorkerOnDataBase(event: event);
      },
    );
    on<UpdateWorkerPhoto>(
      (UpdateWorkerPhoto event, Emitter<RegistrationState> emit) {
        emit(WorkerPhotoUpdated(image: event.image));
      },
    );
    on<RegisterNewWorker>(
      (RegisterNewWorker event, Emitter<RegistrationState> emit) async {
        //if not found by Image, so Register New Worker on server if success nav to worker with notify
        await _registerNewWorker(event: event, emit: emit);
      },
    );
    on<OverrideIDPassport>(
      (OverrideIDPassport event, Emitter<RegistrationState> emit) async {
        _workerOverrideIDPassport(event: event);
      },
    );
    on<RegisterToAnotherProject>(
      (RegisterToAnotherProject event, Emitter<RegistrationState> emit) async {
        await _workerRegisterToAnotherProject(event: event);
      },
    );
    on<HideNotify>(
      (HideNotify event, Emitter<RegistrationState> emit) {
        emit(NotifyHidden(updateKey: UniqueKey()));
      },
    );
    on<CheckNextButtonClickable>(
      (CheckNextButtonClickable event, Emitter<RegistrationState> emit) {
        emit(NextButtonClickableChecked(
          project: event.project,
          passportID: event.passportID,
          isReachLimit: event.isReachLimit,
        ));
      },
    );
  }

  Future<void> _registerNewWorker(
      {required RegisterNewWorker event,
      required Emitter<RegistrationState> emit}) async {
    //Note: when not found return error 610 or 706 (no need to add in Toast exp)
    await searchWorkerByPhoto(
      projectId: event.projectId,
      img: event.image,
    ).then((WorkerDataResponseModel? model) {
      emit(RegisterButtonReset(updateKey: UniqueKey()));
      //Note: Found By Photo
      logInfo('Worker register found by photo');
      getIt<Navigation>()
          .toPageRouteProvider<RegistrationFoundByPhoto, RegistrationBloc>(
        page: RegistrationFoundByPhoto(
          isFoundOnCurrentProject: model?.project != null,
          personId:
              (model?.project != null ? model?.person?.id : model?.id) ?? 0,
          projectId: event.projectId,
          idType: event.typeId,
          selectedPassportID: event.selectedPassportOrID,
          selectedProject: event.selectedProject,
          existsAccessDate:
              model?.createDate?.formattedDateWithOutTime ?? 'N/A',
          existsPassportID: model?.project != null
              ? model?.person?.identificationNumber
              : model?.identificationNumber,
          existsPhoto: model?.project != null
              ? model?.person?.image?.imgUrl
              : model?.image?.imgUrl,
          existsProject: model?.project?.name,
          existsWorkerPosition: model?.position?.name,
        ),
        bloc: this,
      );
    }).catchError((dynamic errors) async {
      emit(RegisterButtonReset(updateKey: UniqueKey()));
      if (errors.message == ExceptionType.unknown) {
        logInfo('Worker register NOT found by photo');
        //Note: Not Found By Photo
        await registerWorker(
          identificationNumber: event.selectedPassportOrID,
          identificationType: event.typeId,
          projectId: event.projectId,
          img: event.image,
        ).then((dynamic value) async {
          logInfo(
              'Worker register new worker has been successfully registered');
          await getWorkerByID(
            projectId: event.projectId,
            idNumber: event.selectedPassportOrID,
            idType: event.typeId,
          ).then((WorkerDataResponseModel? model) {
            //Note: when successfully added a new worker
            getIt<Navigation>().toRemoveUntilHome(
              RouteName.workers,
              arguments: WorkerRegisterNotifyData(
                firstText: WorkerRegisterNotify.registeredSuccess.notifyText(
                  oldPassportId: event.selectedPassportOrID,
                ),
                isNeedShowFirst: true,
              ),
            );
          });
        }).catchError((dynamic onError) {
          logWarn('Worker register: Photo Not Sufficient');
          //Note: Photo Not Sufficient
          emit(const UpdatedWorkerPhotoRefused());
        });
      }
    });
  }

  Future<void> _checkWorkerOnDataBase(
      {required NavigateToNextPage event}) async {
    await getWorkerByID(
      projectId: event.projectId,
      idNumber: event.passportOrID,
      idType: event.typeId,
    ).then((WorkerDataResponseModel? model) async {
      logInfo(
          'Worker register already exists on this project. project id:${event.projectId}');
      //Note: Worker already exists on the project
      if (event.projectId == model?.project?.id) {
        await _toNextPage(
            model: model, page: WorkerRegisterPage.existsProject, event: event);
        logInfo(
            'Worker register already exists in the database. project id:${event.projectId}');
        //Note: Worker already exists in the database
      } else if (event.passportOrID == model?.identificationNumber) {
        await _toNextPage(
            model: model,
            page: WorkerRegisterPage.existsDatabase,
            event: event);
      }
    }).catchError((dynamic errors) async {
      //Note: New Worker Registration
      if (errors.message == ExceptionType.unknown) {
        await _toNextPage(page: WorkerRegisterPage.newWorker, event: event);
      }
    });
  }

  Future<void> _toNextPage(
      {WorkerDataResponseModel? model,
      required WorkerRegisterPage page,
      required NavigateToNextPage event}) async {
    switch (page) {
      case WorkerRegisterPage.newWorker:
        getIt<Navigation>()
            .toPageRouteProvider<RegistrationNewWorker, RegistrationBloc>(
          page: RegistrationNewWorker(
            projectId: event.projectId,
            project: event.project,
            typeId: event.typeId,
            passportOrID: event.passportOrID,
          ),
          bloc: this,
        );
        break;
      case WorkerRegisterPage.existsDatabase:
        getIt<Navigation>()
            .toPageRouteProvider<RegistrationExistsDatabase, RegistrationBloc>(
          page: RegistrationExistsDatabase(
            passportId: event.passportOrID,
            selectedProject: event.project,
            personId: model?.id ?? 0,
            projectID: event.projectId,
            workerPhoto: model?.image?.imgUrl,
          ),
          bloc: this,
        );
        break;
      case WorkerRegisterPage.existsProject:
        getIt<Navigation>()
            .toPageRouteProvider<RegistrationExistsProject, RegistrationBloc>(
          page: RegistrationExistsProject(
            workerPhoto: model?.person?.image?.imgUrl,
            approvedAccessDate:
                model?.createDate?.formattedDateWithOutTime ?? 'N/A',
            passportID: event.passportOrID,
            selectedProject: event.project,
          ),
          bloc: this,
        );
        break;
    }
  }

  Future<void> _workerOverrideIDPassport(
      {required OverrideIDPassport event}) async {
    //Note: when update Worker success add new passportId
    await workerUpdateData(
      personId: event.personId,
      identificationNumber: event.selectedIDPassport,
      identificationType: event.idType,
      countryId: 1,
    ).then((dynamic value) {
      logInfo(
          'Worker register updated worker data. person id:${event.personId}');
      if (event.isFoundOnCurrentProject) {
        getIt<Navigation>().toRemoveUntilHome(
          RouteName.workers,
          arguments: WorkerRegisterNotifyData(
            firstText: WorkerRegisterNotify.nameIdUpdated.notifyText(
              oldPassportId: event.idNumber,
              selectedPassportId: event.selectedIDPassport,
            ),
            isNeedShowFirst: true,
          ),
        );
      } else {
        getIt<Navigation>().toRemoveUntilHome(
          RouteName.workers,
          arguments: WorkerRegisterNotifyData(
            firstText: WorkerRegisterNotify.assignedTo.notifyText(
              oldPassportId: event.idNumber,
              projectName: event.selectedProject,
            ),
            isNeedShowFirst: true,
            secondText: WorkerRegisterNotify.nameIdUpdated.notifyText(
              oldPassportId: event.idNumber,
              selectedPassportId: event.selectedIDPassport,
            ),
            isNeedShowSecond: true,
          ),
        );
      }
    });
  }

  Future<void> _workerRegisterToAnotherProject(
      {required RegisterToAnotherProject event}) async {
    await workerAssignToProject(
        model: WorkerAssignToProjectRequestModel(
      projectId: event.projectID,
      personId: event.personId,
    )).then((dynamic value) {
      logInfo(
          'Worker register already registered to another project. project id:${event.projectID}');
      getIt<Navigation>().toRemoveUntilHome(
        RouteName.workers,
        arguments: WorkerRegisterNotifyData(
          firstText: WorkerRegisterNotify.assignedTo.notifyText(
            oldPassportId: event.passportId,
            projectName: event.selectedProject,
          ),
          isNeedShowFirst: true,
        ),
      );
    });
  }
}
