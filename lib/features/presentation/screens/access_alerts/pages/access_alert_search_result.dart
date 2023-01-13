import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_bloc.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_event.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_state.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/components/alert_item_list.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';
import 'package:safe_access/features/presentation/widgets/view_more_button.dart';

class AccessAlertSearchResult extends StatefulWidget {
  const AccessAlertSearchResult({
    Key? key,
    required this.items,
    required this.isNotHandled,
    required this.itemsCount,
    required this.projectId,
    required this.identificationNumber,
    required this.isActiveProject,
  }) : super(key: key);

  final List<AccessAlertResponseModel> items;
  final bool isNotHandled;
  final int itemsCount;
  final int projectId;
  final bool? isActiveProject;
  final String? identificationNumber;

  @override
  AccessAlertSearchResultState createState() => AccessAlertSearchResultState();
}

class AccessAlertSearchResultState extends State<AccessAlertSearchResult> {
  late List<AccessAlertResponseModel> _itemsAlertsShowing =
      <AccessAlertResponseModel>[];

  late List<AccessAlertResponseModel> _itemsAlertsAll =
      <AccessAlertResponseModel>[];

  late int _offset;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _isNotEmptyGotLoadMore = false;

  @override
  void initState() {
    super.initState();
    _isNotEmptyGotLoadMore = widget.items.isNotEmpty;
    _itemsAlertsAll.addAll(widget.items);
    _offset = _itemsAlertsAll.length;
    _alerts(data: widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccessAlertsBloc, AccessAlertsState>(
      listener: _blocListener,
      builder: (BuildContext context, AccessAlertsState state) {
        return SafeArea(
            child: Scaffold(
          appBar: ActionBar(
            title: StringsRes.searchResults,
          ),
          body: _isLoading
              ? const Center(
                  child: ProgIndicator(),
                )
              : Scrollbar(
                  isAlwaysShown: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.padding22.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: Dimensions.margin16.h,
                        ),
                        _alertsCount,
                        SizedBox(
                          height: Dimensions.margin16.h,
                        ),
                        Flexible(
                          child: AlertItemList(
                            list: _itemsAlertsShowing,
                            onItemTap: (AccessAlertResponseModel model) {
                              context.read<AccessAlertsBloc>().add(
                                    LaunchAccessAlertSearchDetails(
                                      model: model,
                                      isNotHandled: widget.isNotHandled,
                                    ),
                                  );
                            },
                          ),
                        ),
                        _viewMore(
                          onTap: () {
                            if (_itemsAlertsShowing.length ==
                                _itemsAlertsAll.length) {
                              context.read<AccessAlertsBloc>()
                                ..add(const ShowHideLoadMoreIndicator(
                                    isShown: true))
                                ..add(GetSearchAccessAlerts(
                                  offset: _offset,
                                  projectId: widget.projectId,
                                  identificationNumber:
                                      widget.identificationNumber,
                                  isActiveProject: widget.isActiveProject,
                                ));
                            } else {
                              context.read<AccessAlertsBloc>().add(
                                  SearchViewMoreItemsResult(
                                      allItems: _itemsAlertsAll,
                                      viewedItemsCont:
                                          _itemsAlertsShowing.length));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          floatingActionButton: const FloatingButton(),
          bottomNavigationBar: BottomNavBar(
            navType: BottomNavTypeSelected.newSearch,
            onNewSearch: () =>
                context.read<AccessAlertsBloc>().add(const StartNewSearch()),
          ),
        ));
      },
    );
  }

  void _blocListener(
      final BuildContext context, final AccessAlertsState state) {
    if (state is AlertSearchHandled) {
      _isLoading = true;
      context.read<AccessAlertsBloc>().add(GetSearchAccessAlerts(
            offset: 0,
            projectId: widget.projectId,
            identificationNumber: widget.identificationNumber,
            isActiveProject: widget.isActiveProject,
          ));
    } else if (state is SearchMoreItemsResultViewed) {
      _itemsAlertsShowing.addAll(state.newItems);
    } else if (state is SearchAccessAlertsGotLoadMore) {
      _itemsAlertsAll.addAll(state.model);
      _offset = _itemsAlertsAll.length;
      _isNotEmptyGotLoadMore = state.model.isNotEmpty;
      context.read<AccessAlertsBloc>()
        ..add(const ShowHideLoadMoreIndicator(isShown: false))
        ..add(SearchViewMoreItemsResult(
            allItems: _itemsAlertsAll,
            viewedItemsCont: _itemsAlertsShowing.length));
    } else if (state is SearchAccessAlertsHandledListUpdated) {
      _offset = 0;
      _itemsAlertsShowing.clear();
      _itemsAlertsAll.clear();
      _itemsAlertsAll.addAll(state.model);
      _alerts(data: state.model);
      _isLoading = false;
    } else if (state is LoadMoreIndicatorSearchShownHidden) {
      _isLoadingMore = state.isShown;
    }
  }

  Widget get _alertsCount => Visibility(
        visible: _itemsAlertsShowing.isNotEmpty,
        child: TextView(
          title: widget.itemsCount.showingCount(_itemsAlertsShowing.length),
          size: TextSizes.sp13.sp,
          weight: FontWeight.w400,
          color: ColorsRes.exceptionsTitle,
        ),
      );

  Widget _viewMore({required VoidCallback onTap}) => ViewMoreButton(
        isVisible: _itemsAlertsShowing.length >= 5 &&
            _itemsAlertsShowing.length < widget.itemsCount &&
            _isNotEmptyGotLoadMore,
        isLoadingMore: _isLoadingMore,
        onTap: onTap,
      );

  void _alerts({required List<AccessAlertResponseModel> data}) {
    if (data.length <= 5) {
      _itemsAlertsShowing = data;
    } else {
      _itemsAlertsShowing = data.sublist(0, 5);
    }
  }
}
