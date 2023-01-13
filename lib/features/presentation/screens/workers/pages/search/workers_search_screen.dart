import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/employers_data.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/position_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/core/values_holder/worker_search_data.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/domain/repositories/worker_manager.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/workers/components/workers_search_fields.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_state.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';

class WorkersSearchScreen extends StatefulWidget {
  const WorkersSearchScreen({
    Key? key,
    this.lastProject,
  }) : super(key: key);

  final String? lastProject;

  @override
  WorkersSearchScreenState createState() => WorkersSearchScreenState();
}

class WorkersSearchScreenState extends State<WorkersSearchScreen>
    with WorkerManager {
  final RoundedLoadingButtonController _searchController =
      RoundedLoadingButtonController();

  final GlobalKey<FormFieldState<String>> _projectsFieldKey =
      GlobalKey<FormFieldState<String>>();

  final TextEditingController _controllerPassID = TextEditingController();

  final WorkerSearchData _searchData = getIt<WorkerSearchData>();
  final ProjectsData _proData = getIt<ProjectsData>();

  bool _isErrorNeedShow = false;

  @override
  void initState() {
    super.initState();
    _checkLastProject();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (final BuildContext context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: _blocListener,
        builder: (final BuildContext context, final SearchState state) {
          return Scaffold(
            appBar: ActionBar(
              title: StringsRes.searchWorkers,
            ),
            resizeToAvoidBottomInset: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: WorkersSearchFields(
                        isShownActiveProjects:
                            _searchData.isShownActiveProjects,
                        onToggleActiveProjects: (bool value) => context
                            .read<SearchBloc>()
                            .add(ChangeProjectActiveOrNot(isActive: value)),
                        projects: _searchData.isShownActiveProjects
                            ? _proData.projects.namesActive
                            : _proData.projects.namesActiveAndNotActive,
                        projectsFieldKey: _projectsFieldKey,
                        lastProject: _searchData.selectedProject,
                        onChangedProjects: (String? value) async {
                          if (value != null) {
                            await getIt<Storage>()
                                .setWorkerLastSelectedProjectSearch(value);
                          }
                          context
                              .read<SearchBloc>()
                              .add(SelectProject(project: value ?? ''));
                        },
                        //Note: send value from controller
                        textController: _controllerPassID,
                        positions: getIt<PositionsData>().positions.namesPos,
                        selectedPositions: (List<String> items) {
                          _searchData.selectedPositions.addAll(items);
                        },
                        classifications:
                            ItemsData.classifications.namesClassification,
                        selectedClassifications: (List<String> items) {
                          _searchData.selectedClassifications.addAll(items);
                        },
                        employers: getIt<EmployersData>().employers.namesEmp,
                        selectedEmployers: (List<String> items) {
                          _searchData.selectedEmployers.addAll(items);
                        },
                        onChanged: (String value, bool isReachLimit) =>
                            context.read<SearchBloc>().add(ShowLimitCharError(
                                  isReachLimit: isReachLimit,
                                )),
                        isErrorNeedShow: _isErrorNeedShow,
                      ),
                    ),
                  ),
                ),
                _searchButton(context: context),
                SizedBox(
                  height: Dimensions.margin24.h,
                ),
              ],
            ),
            floatingActionButton: const FloatingButton(
              bottomMargin: Dimensions.margin104,
            ),
          );
        },
      ),
    );
  }

  void _blocListener(final BuildContext context, final SearchState state) {
    if (state is ProjectSelected) {
      _searchData.selectedProject = state.project;
    } else if (state is ClearFieldsData) {
      _clearData();
    } else if (state is LimitCharErrorShown) {
      _isErrorNeedShow = state.isReachLimit;
    } else if (state is ProjectActiveOrNotChanged) {
      FocusManager.instance.primaryFocus?.unfocus();
      _searchData.isShownActiveProjects = state.isActive;
      _projectsFieldKey.currentState?.reset();
      _searchData.selectedProject = null;
    }
  }

  Widget _searchButton({required BuildContext context}) => SolidButton(
        label: StringsRes.search,
        controller: _searchController,
        isClickable: _searchData.selectedProject != null &&
            _searchData.selectedProject!.isNotEmpty,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context.read<SearchBloc>().add(LaunchSearchResults(
                projectId: _proData.projects
                    .projectId(_projectsFieldKey.currentState?.value ?? ''),
                idNumber: _controllerPassID.text,
                positionIds: getIt<PositionsData>()
                    .positions
                    .positionsId(_searchData.selectedPositions),
                employerIds: getIt<EmployersData>()
                    .employers
                    .employersId(_searchData.selectedEmployers),
                classificationIds: ItemsData.classifications
                    .classificationId(_searchData.selectedClassifications),
              ));
          _searchController.reset();
        },
      );

  void _clearData() {
    _projectsFieldKey.currentState?.reset();
    _controllerPassID.clear();
    _isErrorNeedShow = false;
    _searchData
      ..isShownActiveProjects = true
      ..selectedProject = null
      ..selectedPositions.clear()
      ..selectedClassifications.clear()
      ..selectedEmployers.clear();
  }

  void _checkLastProject() {
    if (widget.lastProject != null &&
        getIt<ProjectsData>().projects != null &&
        getIt<ProjectsData>().projects!.any((ProjectResponseModel element) =>
            element.name == widget.lastProject)) {
      _searchData.selectedProject = widget.lastProject;
      _searchData.isShownActiveProjects =
          getIt<ProjectsData>().projects.projectIsActive(widget.lastProject!);
    }
  }

  @override
  void dispose() {
    _controllerPassID.dispose();
    _searchData
      ..selectedPositions.clear()
      ..selectedClassifications.clear()
      ..selectedEmployers.clear()
      ..selectedProject = null
      ..isShownActiveProjects = true;
    super.dispose();
  }
}
