import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/access_alert_search_data.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/features/data/entities/requests/access_alert_search_request_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_bloc.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_event.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_state.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/components/access_alerts_search_fields.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';

class AccessAlertsSearchScreen extends StatefulWidget {
  const AccessAlertsSearchScreen({Key? key}) : super(key: key);

  @override
  AccessAlertsSearchScreenState createState() =>
      AccessAlertsSearchScreenState();
}

class AccessAlertsSearchScreenState extends State<AccessAlertsSearchScreen> {
  final RoundedLoadingButtonController _searchController =
      RoundedLoadingButtonController();

  final TextEditingController _controllerPassID = TextEditingController();

  final GlobalKey<FormFieldState<String>> _projectsFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _statusFieldKey =
      GlobalKey<FormFieldState<String>>();

  final AccessAlertSearchData _alertData = getIt<AccessAlertSearchData>();
  final ProjectsData _proData = getIt<ProjectsData>();

  bool _isErrorNeedShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccessAlertsBloc, AccessAlertsState>(
      listener: _blocListener,
      builder: (BuildContext context, AccessAlertsState state) {
        return SafeArea(
          child: Scaffold(
            appBar: ActionBar(
              title: StringsRes.searchAlerts,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: AccessAlertsSearchFields(
                        onToggleActiveProjects: (bool value) => context
                            .read<AccessAlertsBloc>()
                            .add(ChangeProjectActiveOrNot(isActive: value)),
                        isShownActiveProjects: _alertData.isShownActiveProjects,
                        projectItems: _alertData.isShownActiveProjects
                            ? _proData.projects.namesActive
                            : _proData.projects.namesActiveAndNotActive,
                        projectsFieldKey: _projectsFieldKey,
                        onChangedProjects: (String? value) {
                          context
                              .read<AccessAlertsBloc>()
                              .add(SelectProject(project: value ?? ''));
                        },
                        statusItems: ItemsData.accessAlertStatus,
                        statusFieldKey: _statusFieldKey,
                        onChangedStatus: (String? value) {
                          _alertData.selectedStatus = value ?? '';
                        },
                        classifications:
                            ItemsData.classifications.namesClassification,
                        selectedClassifications: (List<String> items) {
                          _alertData.selectedClassifications.addAll(items);
                        },
                        timeRange: (DateTimeRange range) => context
                            .read<AccessAlertsBloc>()
                            .add(ChangeDateTimeRange(dateRange: range)),

                        timeRangeText:
                            _alertData.selectedDateRange?.formattedRangeDate,
                        //Note: send value from controller
                        passportIdController: _controllerPassID,
                        isErrorNeedShow: _isErrorNeedShow,
                        onChanged: (String value, bool isReachLimit) => context
                            .read<AccessAlertsBloc>()
                            .add(ShowLimitCharError(
                              isReachLimit: isReachLimit,
                            )),
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
            floatingActionButton: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: const FloatingButton(
                bottomMargin: Dimensions.margin104,
              ),
            ),
          ),
        );
      },
    );
  }

  void _blocListener(
      final BuildContext context, final AccessAlertsState state) {
    if (state is ProjectSelected) {
      _alertData.selectedProject = state.project;
    } else if (state is ClearFieldsData) {
      _clearData();
    } else if (state is ProjectActiveOrNotChanged) {
      FocusManager.instance.primaryFocus?.unfocus();
      _alertData.isShownActiveProjects = state.isActive;
      _projectsFieldKey.currentState?.reset();
      _alertData.selectedProject = '';
    } else if (state is LimitCharErrorShown) {
      _isErrorNeedShow = state.isReachLimit;
    } else if (state is DateTimeRangeChanged) {
      _alertData.selectedDateRange = state.dateRange;
    } else if (state is SearchAlertsControllerReset) {
      _searchController.reset();
    }
  }

  Widget _searchButton({required BuildContext context}) => SolidButton(
        label: StringsRes.search,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context.read<AccessAlertsBloc>().add(LaunchAccessAlertsSearchResult(
                model: AccessAlertSearchRequestModel(
                  offset: 0,
                  fromDate:
                      _alertData.selectedDateRange?.start.toString() ?? '',
                  toDate:
                      _alertData.selectedDateRange?.end.formattedRangeToDate ??
                          '',
                  projectId: _proData.projects
                      .projectId(_projectsFieldKey.currentState?.value ?? ''),
                  active: _proData.projects.projectIsActive(
                      _projectsFieldKey.currentState?.value ?? ''),
                  identificationNumber: _controllerPassID.text.isNotEmpty
                      ? _controllerPassID.text
                      : null,
                  classification: _alertData.selectedClassifications.isNotEmpty
                      ? ItemsData.classifications
                          .classificationId(_alertData.selectedClassifications)
                      : null,
                  handled: _alertData.selectedStatus.stateStatus,
                ),
              ));
          _searchController.start();
        },
        controller: _searchController,
        isAnimateOnTap: false,
        isClickable: _alertData.selectedProject.isNotEmpty &&
            _alertData.selectedDateRange != null,
      );

  void _clearData() {
    _projectsFieldKey.currentState?.reset();
    _statusFieldKey.currentState?.reset();
    _controllerPassID.clear();
    _isErrorNeedShow = false;
    _alertData
      ..isShownActiveProjects = true
      ..selectedProject = ''
      ..selectedStatus = StringsRes.notHandled
      ..selectedClassifications.clear()
      ..selectedDateRange = null;
  }

  @override
  void dispose() {
    _controllerPassID.dispose();
    _alertData
      ..isShownActiveProjects = true
      ..selectedProject = ''
      ..selectedStatus = StringsRes.notHandled
      ..selectedClassifications.clear()
      ..selectedDateRange = null;
    super.dispose();
  }
}
