import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/employers_data.dart';
import 'package:safe_access/core/values_holder/events_search_data.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/position_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/features/data/entities/common/events_search_parameters_model.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_bloc.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_event.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_state.dart';
import 'package:safe_access/features/presentation/screens/events/components/event_search_fields.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';
import 'package:safe_access/features/presentation/widgets/action_bar_no_buttons.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  EventsScreenState createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  final RoundedLoadingButtonController _searchController =
      RoundedLoadingButtonController();

  final TextEditingController _controllerPassID = TextEditingController();
  final GlobalKey<FormFieldState<String>> _projectsFieldKey =
      GlobalKey<FormFieldState<String>>();

  final EventsSearchData _eventsData = getIt<EventsSearchData>();
  final ProjectsData _proData = getIt<ProjectsData>();

  bool _isErrorNeedShow = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventsBloc>(
      create: (final BuildContext context) =>
          EventsBloc()..add(const CheckLastSelectedProject()),
      child: BlocConsumer<EventsBloc, EventsState>(
        listener: _blocListener,
        builder: (final BuildContext context, final EventsState state) {
          return SafeArea(
            child: Scaffold(
              appBar: const ActionBarNoButtons(
                title: StringsRes.searchEvents,
              ),
              body: _isLoading
                  ? const Center(
                      child: ProgIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                  bottom: Dimensions.margin104.h),
                              child: EventsSearchFields(
                                isShownFirstAppearance:
                                    _eventsData.isFirstAppearance,
                                onToggleFirstAppearances: (bool value) =>
                                    context.read<EventsBloc>().add(
                                        ChangeShownFirstAppearanceOrNot(
                                            isFirst: value)),
                                timeRange: (DateTimeRange range) => context
                                    .read<EventsBloc>()
                                    .add(ChangeDateTimeRange(dateRange: range)),

                                timeRangeText: _eventsData
                                    .selectedDateRange?.formattedRangeDate,
                                //Note: send value from controller
                                passportIdController: _controllerPassID,
                                onToggleActiveProjects: (bool value) => context
                                    .read<EventsBloc>()
                                    .add(ChangeProjectActiveOrNot(
                                        isActive: value)),
                                isShownActiveProjects:
                                    _eventsData.isShownActiveProjects,
                                projectItems: _eventsData.isShownActiveProjects
                                    ? _proData.projects.namesActive
                                    : _proData.projects.namesActiveAndNotActive,
                                projectsFieldKey: _projectsFieldKey,
                                lastProject: _eventsData.selectedProject,
                                onChangedProjects: (String? value) async {
                                  if (value != null) {
                                    await getIt<Storage>()
                                        .setEventsLastSelectedProject(value);
                                  }
                                  context
                                      .read<EventsBloc>()
                                      .add(SelectProject(project: value ?? ''));
                                },
                                employers:
                                    getIt<EmployersData>().employers.namesEmp,
                                selectedEmployers: (List<String> items) {
                                  _eventsData.selectedEmployers.addAll(items);
                                },
                                positions:
                                    getIt<PositionsData>().positions.namesPos,
                                selectedPositions: (List<String> items) {
                                  _eventsData.selectedPositions.addAll(items);
                                },
                                classifications: ItemsData
                                    .classifications.namesClassification,
                                selectedClassifications: (List<String> items) {
                                  _eventsData.selectedClassifications
                                      .addAll(items);
                                },
                                isErrorNeedShow: _isErrorNeedShow,
                                onChanged: (String value, bool isReachLimit) =>
                                    context.read<EventsBloc>().add(
                                        ShowLimitCharError(
                                            isReachLimit: isReachLimit)),
                              ),
                            ),
                          ),
                        ),
                        _searchButton(
                          context: context,
                        ),
                        SizedBox(
                          height: Dimensions.margin24.h,
                        ),
                      ],
                    ),
              floatingActionButton: const FloatingButton(
                bottomMargin: Dimensions.margin104,
              ),
            ),
          );
        },
      ),
    );
  }

  void _blocListener(final BuildContext context, final EventsState state) {
    if (state is ProjectSelected) {
      _eventsData.selectedProject = state.project;
    } else if (state is ClearFieldsData) {
      _clearData();
    } else if (state is LimitCharErrorShown) {
      _isErrorNeedShow = state.isReachLimit;
    } else if (state is ProjectActiveOrNotChanged) {
      FocusManager.instance.primaryFocus?.unfocus();
      _eventsData.isShownActiveProjects = state.isActive;
      _projectsFieldKey.currentState?.reset();
      _eventsData.selectedProject = null;
    } else if (state is DateTimeRangeChanged) {
      _eventsData.selectedDateRange = state.dateRange;
    } else if (state is SearchEventsControllerReset) {
      _searchController.reset();
    } else if (state is LastSelectedProjectChecked) {
      _isLoading = false;
      if (state.project != null &&
          getIt<ProjectsData>().projects != null &&
          getIt<ProjectsData>().projects!.any((ProjectResponseModel element) =>
              element.name == state.project)) {
        _eventsData.selectedProject = state.project;
        _eventsData.isShownActiveProjects =
            getIt<ProjectsData>().projects.projectIsActive(state.project!);
      }
    } else if (state is FirstAppearanceOrNotChanged) {
      FocusManager.instance.primaryFocus?.unfocus();
      _eventsData.isFirstAppearance = state.isFirst;
    }
  }

  Widget _searchButton({required BuildContext context}) => SolidButton(
        label: StringsRes.search,
        controller: _searchController,
        isAnimateOnTap: false,
        isClickable: _eventsData.selectedProject != null &&
            _eventsData.selectedProject!.isNotEmpty &&
            _eventsData.selectedDateRange != null,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context.read<EventsBloc>().add(LaunchEventsSearchResult(
                  modelParameters: EventsSearchParametersModel(
                isFirstAppearance: _eventsData.isFirstAppearance,
                fromDate: _eventsData.selectedDateRange?.start.toString() ?? '',
                toDate:
                    _eventsData.selectedDateRange?.end.formattedRangeToDate ??
                        '',
                projectId: _proData.projects
                    .projectId(_projectsFieldKey.currentState?.value ?? ''),
                isActiveProject: _proData.projects.projectIsActive(
                    _projectsFieldKey.currentState?.value ?? ''),
                passportID: _controllerPassID.text,
                employerIds: getIt<EmployersData>()
                    .employers
                    .employersId(_eventsData.selectedEmployers),
                positionIds: getIt<PositionsData>()
                    .positions
                    .positionsId(_eventsData.selectedPositions),
                classificationIds: ItemsData.classifications
                    .classificationId(_eventsData.selectedClassifications),
              )));
          _searchController.start();
          // _searchController.reset();
        },
      );

  void _clearData() {
    _projectsFieldKey.currentState?.reset();
    _controllerPassID.clear();
    _isErrorNeedShow = false;
    _eventsData
      ..isShownActiveProjects = true
      ..selectedProject = null
      ..selectedDateRange = null
      ..selectedEmployers.clear()
      ..selectedPositions.clear()
      ..selectedClassifications.clear();
  }

  @override
  void dispose() {
    _controllerPassID.dispose();
    _eventsData
      ..selectedDateRange = null
      ..isShownActiveProjects = true
      ..selectedProject = null
      ..selectedEmployers.clear()
      ..selectedPositions.clear()
      ..selectedClassifications.clear();
    super.dispose();
  }
}
