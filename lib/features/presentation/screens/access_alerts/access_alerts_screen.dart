import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/core/values_holder/worker_search_data.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_bloc.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_event.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_state.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/components/alert_item_list.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/components/header.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar_no_buttons.dart';
import 'package:safe_access/features/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/multi_selectable_dialog.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/view_more_button.dart';

class AccessAlertsScreen extends StatefulWidget {
  const AccessAlertsScreen({Key? key}) : super(key: key);

  @override
  AccessAlertsScreenState createState() => AccessAlertsScreenState();
}

class AccessAlertsScreenState extends State<AccessAlertsScreen> {
  List<String> _selectedClassifications =
      getIt<WorkerSearchData>().selectedClassifications;

  final List<AccessAlertResponseModel> _itemsAlertsAll =
      <AccessAlertResponseModel>[];
  List<AccessAlertResponseModel> _itemsAlertsShowing =
      <AccessAlertResponseModel>[];

  final List<AccessAlertResponseModel> _itemsAlertsFilterAll =
      <AccessAlertResponseModel>[];
  List<AccessAlertResponseModel> _itemsAlertsFilterShowing =
      <AccessAlertResponseModel>[];

  int _itemsCount = 0;
  int _offset = 0;
  int _itemsCountFilter = 0;
  int _offsetFilter = 0;

  bool _isLoading = true;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccessAlertsBloc>(
      create: (final BuildContext context) =>
          AccessAlertsBloc()..add(const GetAccessAlerts(offset: 0)),
      child: BlocConsumer<AccessAlertsBloc, AccessAlertsState>(
          listener: _blocListener,
          builder: (final BuildContext context, final AccessAlertsState state) {
            return SafeArea(
              child: Scaffold(
                appBar: const ActionBarNoButtons(
                  title: StringsRes.accessAlerts,
                ),
                body: _isLoading
                    ? const Center(
                        child: ProgIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.padding22.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Header(
                              allAlertsCount: _selectedClassifications.isEmpty
                                  ? _itemsCount
                                  : _itemsCountFilter,
                              alertsCount: _selectedClassifications.isEmpty
                                  ? _itemsAlertsShowing.length
                                  : _itemsAlertsFilterShowing.length,
                              filterOnTap: () {
                                //  if (_itemsAlertsAll.isNotEmpty) {
                                context
                                    .read<AccessAlertsBloc>()
                                    .add(const ShowFilterDialog());
                                //  }
                              },
                            ),
                            SizedBox(
                              height: Dimensions.margin24.h,
                            ),
                            Flexible(
                              child: AlertItemList(
                                list: _selectedClassifications.isEmpty
                                    ? _itemsAlertsShowing
                                    : _itemsAlertsFilterShowing,
                                onItemTap: (AccessAlertResponseModel model) {
                                  context.read<AccessAlertsBloc>().add(
                                        LaunchAccessAlertDetails(model: model),
                                      );
                                },
                              ),
                            ),
                            _viewMore(
                              onTap: () {
                                if (_selectedClassifications.isEmpty) {
                                  if (_itemsAlertsShowing.length ==
                                      _itemsAlertsAll.length) {
                                    context.read<AccessAlertsBloc>()
                                      ..add(const ShowHideLoadMoreIndicator(
                                          isShown: true))
                                      ..add(GetAccessAlerts(offset: _offset));
                                  } else {
                                    context.read<AccessAlertsBloc>().add(
                                        ViewMoreItemsResult(
                                            allItems: _itemsAlertsAll,
                                            viewedItemsCont:
                                                _itemsAlertsShowing.length));
                                  }
                                } else {
                                  if (_itemsAlertsFilterShowing.length ==
                                      _itemsAlertsFilterAll.length) {
                                    context.read<AccessAlertsBloc>()
                                      ..add(const ShowHideLoadMoreIndicator(
                                          isShown: true))
                                      ..add(GetAccessAlertsFilter(
                                          offset: _offsetFilter,
                                          classificationsIds: ItemsData
                                              .classifications
                                              .classificationId(
                                                  _selectedClassifications)));
                                  } else {
                                    context.read<AccessAlertsBloc>().add(
                                        ViewMoreItemsFilterResult(
                                            allItems: _itemsAlertsFilterAll,
                                            viewedItemsCont:
                                                _itemsAlertsFilterShowing
                                                    .length));
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                floatingActionButton: const FloatingButton(),
                bottomNavigationBar: BottomNavBar(
                  navType: BottomNavTypeSelected.search,
                  onSearch: () {
                    if (getIt<ProjectsData>()
                        .projects
                        .isPermittedPerformAction) {
                      context
                          .read<AccessAlertsBloc>()
                          .add(const LaunchAccessAlertsSearch());
                    }
                  },
                ),
              ),
            );
          }),
    );
  }

  void _blocListener(
      final BuildContext context, final AccessAlertsState state) {
    if (state is FilterDialogShown) {
      _showFilterDialog().then((List<String>? results) {
        if (results != null) {
          _offsetFilter = 0;
          _selectedClassifications = results;
          context.read<AccessAlertsBloc>().add(GetAccessAlertsFilter(
              offset: _offsetFilter,
              classificationsIds: ItemsData.classifications
                  .classificationId(_selectedClassifications)));
        }
      });
    } else if (state is AccessAlertsFilterGot) {
      _itemsCountFilter = state.itemsCount;
      _itemsAlertsFilterAll.clear();
      _itemsAlertsFilterAll.addAll(state.model);
      _offsetFilter = _itemsAlertsFilterAll.length;
      _itemsAlertsFilterShowing.clear();
      _alertsFilter(data: state.model);
      _isLoading = false;
    } else if (state is AccessAlertsFilterGotLoadMore) {
      _itemsAlertsFilterAll.addAll(state.model);
      _offsetFilter = _itemsAlertsFilterAll.length;
      context.read<AccessAlertsBloc>()
        ..add(const ShowHideLoadMoreIndicator(isShown: false))
        ..add(ViewMoreItemsFilterResult(
          allItems: _itemsAlertsFilterAll,
          viewedItemsCont: _itemsAlertsFilterShowing.length,
        ));
    } else if (state is MoreItemsFilterResultViewed) {
      _itemsAlertsFilterShowing.addAll(state.newItems);
    }
    ///////////////
    else if (state is LoadingShown) {
      _isLoading = true;
    } else if (state is LoadMoreIndicatorShownHidden) {
      _isLoadingMore = state.isShown;
    }
    ///////////////

    else if (state is AccessAlertsGot) {
      _itemsCount = state.itemsCount;
      _itemsAlertsAll.clear();
      _itemsAlertsAll.addAll(state.model);
      _offset = _itemsAlertsAll.length;
      _itemsAlertsShowing.clear();
      _alerts(data: state.model);
      _isLoading = false;
    } else if (state is AccessAlertsGotLoadMore) {
      _itemsAlertsAll.addAll(state.model);
      _offset = _itemsAlertsAll.length;
      context.read<AccessAlertsBloc>()
        ..add(const ShowHideLoadMoreIndicator(isShown: false))
        ..add(ViewMoreItemsResult(
          allItems: _itemsAlertsAll,
          viewedItemsCont: _itemsAlertsShowing.length,
        ));
    } else if (state is MoreItemsResultViewed) {
      _itemsAlertsShowing.addAll(state.newItems);
    }
  }

  Future<List<String>?> _showFilterDialog() => showDialog<List<String>?>(
        context: context,
        builder: (BuildContext context) => MultiSelectableDialog(
          items: ItemsData.classifications.namesClassification,
          selectedItems: _selectedClassifications,
          buttonLabel: StringsRes.filter,
        ),
      );

  void _alerts({required List<AccessAlertResponseModel> data}) {
    if (data.length <= 5) {
      _itemsAlertsShowing = data;
    } else {
      _itemsAlertsShowing = data.sublist(0, 5);
    }
  }

  void _alertsFilter({required List<AccessAlertResponseModel> data}) {
    if (data.length <= 5) {
      _itemsAlertsFilterShowing = data;
    } else {
      _itemsAlertsFilterShowing = data.sublist(0, 5);
    }
  }

  Widget _viewMore({required VoidCallback onTap}) => ViewMoreButton(
        isVisible: _selectedClassifications.isEmpty
            ? _itemsAlertsShowing.length >= 5 &&
                _itemsAlertsShowing.length < _itemsCount
            : _itemsAlertsFilterShowing.length >= 5 &&
                _itemsAlertsFilterShowing.length < _itemsCountFilter,
        isLoadingMore: _isLoadingMore,
        onTap: onTap,
      );

  @override
  void dispose() {
    _selectedClassifications.clear();
    super.dispose();
  }
}
