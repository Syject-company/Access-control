import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/components/worker_search_item_list.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_state.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';
import 'package:safe_access/features/presentation/widgets/view_more_button.dart';

class WorkersSearchResults extends StatefulWidget {
  const WorkersSearchResults({
    Key? key,
    required this.items,
    required this.projectId,
    required this.idNumber,
    required this.positionIds,
    required this.employerIds,
    required this.classificationIds,
  }) : super(key: key);

  final List<SearchWorkersResponseModel> items;
  final int projectId;
  final List<int> positionIds;
  final String idNumber;
  final List<int> classificationIds;
  final List<int> employerIds;

  @override
  WorkersSearchResultsState createState() => WorkersSearchResultsState();
}

class WorkersSearchResultsState extends State<WorkersSearchResults> {
  List<SearchWorkersResponseModel> _itemsAll = <SearchWorkersResponseModel>[];
  List<SearchWorkersResponseModel> _items = <SearchWorkersResponseModel>[];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _itemsAll = widget.items;
    _workers(data: widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: _blocListener,
      builder: (BuildContext context, SearchState state) {
        return SafeArea(
          child: Scaffold(
            appBar: ActionBar(
              title: StringsRes.searchResults,
            ),
            body: _isLoading
                ? const Center(
                    child: ProgIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      right: Dimensions.padding24.w,
                      left: Dimensions.padding24.w,
                      top: Dimensions.padding16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Visibility(
                            visible: _items.isNotEmpty, child: _workersFound),
                        SizedBox(
                          height: Dimensions.margin16.h,
                        ),
                        Flexible(
                          child: WorkerSearchItemList(
                            list: _items,
                            onItemTap: (int index) {
                              context.read<SearchBloc>().add(
                                  LaunchWorkerDetails(
                                      model: _items[index],
                                      projectId: widget.projectId));
                            },
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.margin13.h,
                        ),
                        _viewMore(
                          onTap: () => context.read<SearchBloc>().add(
                                ViewMoreItemsResult(
                                    allItems: _itemsAll,
                                    viewedItemsCont: _items.length),
                              ),
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: const FloatingButton(),
            bottomNavigationBar: BottomNavBar(
              navType: BottomNavTypeSelected.newSearch,
              onNewSearch: () =>
                  context.read<SearchBloc>().add(const StartNewSearch()),
            ),
          ),
        );
      },
    );
  }

  void _blocListener(final BuildContext context, final SearchState state) {
    if (state is MoreItemsResultViewed) {
      _items.addAll(state.newItems);
    } else if (state is WorkersAfterEditInformed) {
      _isLoading = true;
      context.read<SearchBloc>().add(GetWorkersAfterEdit(
            projectId: widget.projectId,
            idNumber: widget.idNumber,
            positionIds: widget.positionIds,
            employerIds: widget.employerIds,
            classificationIds: widget.classificationIds,
          ));
    } else if (state is WorkersAfterEditGot) {
      _isLoading = false;
      _items.clear();
      _itemsAll.clear();
      _itemsAll = state.items;
      _workers(data: state.items);
    }
  }

  void _workers({required List<SearchWorkersResponseModel> data}) {
    if (data.length <= 5) {
      _items = data;
    } else {
      _items = data.sublist(0, 5);
    }
  }

  Widget get _workersFound => TextView(
        title: _itemsAll.length.showingCount(_items.length),
        size: TextSizes.sp13.sp,
        weight: FontWeight.w400,
        align: TextAlign.center,
        color: ColorsRes.primaryText,
      );

  Widget _viewMore({required VoidCallback onTap}) => ViewMoreButton(
        isVisible: _items.length >= 5 && _items.length < _itemsAll.length,
        isLoadingMore: false,
        onTap: onTap,
      );
}
