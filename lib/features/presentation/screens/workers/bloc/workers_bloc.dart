import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/core/values_holder/worker_search_data.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/presentation/screens/workers/bloc/workers_event.dart';
import 'package:safe_access/features/presentation/screens/workers/bloc/workers_state.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/registration_screen.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/workers_search_screen.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';

class WorkersBloc extends Bloc<WorkersEvent, WorkersState> {
  WorkersBloc() : super(WorkersInitial()) {
    on<LaunchSearch>(
      (LaunchSearch event, Emitter<WorkersState> emit) async {
        emit(FirstNotifyHidden(updateKey: UniqueKey()));
        emit(SecondNotifyHidden(updateKey: UniqueKey()));
        logInfo('Launched Worker search page');

        final String? _lastProject =
            await getIt<Storage>().getWorkerLastSelectedProjectSearch();

        getIt<Navigation>().toPageRoute<WorkersSearchScreen>(
            page: WorkersSearchScreen(
          lastProject:
              getIt<ProjectsData>().projects.nameLastProject(_lastProject),
        ));
      },
    );
    on<LaunchRegistration>(
      (LaunchRegistration event, Emitter<WorkersState> emit) async {
        logInfo('Launched Worker registration page');

        emit(FirstNotifyHidden(updateKey: UniqueKey()));
        emit(SecondNotifyHidden(updateKey: UniqueKey()));

        final String? _lastProject =
            await getIt<Storage>().getWorkerLastSelectedProject();

        getIt<Navigation>().toPageRoute<RegistrationScreen>(
            page: RegistrationScreen(
          lastProject:
              getIt<ProjectsData>().projects.nameLastProject(_lastProject),
          projects: getIt<ProjectsData>().projects ?? <ProjectResponseModel>[],
        ));
      },
    );
    on<HideFirstNotify>(
      (HideFirstNotify event, Emitter<WorkersState> emit) {
        emit(FirstNotifyHidden(updateKey: UniqueKey()));
      },
    );
    on<HideSecondNotify>(
      (HideSecondNotify event, Emitter<WorkersState> emit) {
        emit(SecondNotifyHidden(updateKey: UniqueKey()));
      },
    );
  }
}
