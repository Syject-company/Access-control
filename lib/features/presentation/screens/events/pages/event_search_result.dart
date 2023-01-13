import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_bloc.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_event.dart';
import 'package:safe_access/features/presentation/screens/events/bloc/events_state.dart';
import 'package:safe_access/features/presentation/screens/events/components/event_search_item_list.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';
import 'package:safe_access/features/presentation/widgets/view_more_button.dart';

class EventSearchResult extends StatefulWidget {
  const EventSearchResult({
    Key? key,
    required this.items,
    required this.allEventsCount,
    required this.projectId,
  }) : super(key: key);

  final List<EventsSearchResponseModel> items;
  final int allEventsCount;
  final int projectId;

  @override
  EventSearchResultState createState() => EventSearchResultState();
}

class EventSearchResultState extends State<EventSearchResult> {
  late List<EventsSearchResponseModel> _itemsEventsAll =
      <EventsSearchResponseModel>[];

  late List<EventsSearchResponseModel> _itemsEventsShowing =
      <EventsSearchResponseModel>[];

  int _offset = 20;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _itemsEventsAll.addAll(widget.items);
    _events(data: _itemsEventsAll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, EventsState>(
      listener: _blocListener,
      builder: (BuildContext context, EventsState state) {
        return SafeArea(
            child: Scaffold(
          appBar: ActionBar(
            title: StringsRes.searchResults,
          ),
          body: Scrollbar(
            isAlwaysShown: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.padding24.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Visibility(
                    visible: _itemsEventsShowing.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: Dimensions.margin16.h,
                        ),
                        _eventsCount,
                        SizedBox(
                          height: Dimensions.margin16.h,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: EventSearchItemList(
                      list: _itemsEventsShowing,
                    ),
                  ),
                  _viewMore(
                    onTap: () {
                      if (_itemsEventsShowing.length == _offset) {
                        context.read<EventsBloc>()
                          ..add(const ShowHideLoadMoreIndicator(isShown: true))
                          ..add(GetEventsAlerts(
                              offset: _offset, projectId: widget.projectId));
                      } else {
                        context.read<EventsBloc>().add(ViewMoreItemsResult(
                            allItems: _itemsEventsAll,
                            viewedItemsCont: _itemsEventsShowing.length));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: const FloatingButton(),
          bottomNavigationBar: BottomNavBar(
            navType: _itemsEventsShowing.isNotEmpty
                ? BottomNavTypeSelected.newSearchDownload
                : BottomNavTypeSelected.newSearch,
            onNewSearch: () =>
                context.read<EventsBloc>().add(const StartNewSearch()),
            onDownload: () => context
                .read<EventsBloc>()
                .add(SaveEventReport(items: _itemsEventsAll)),
          ),
        ));
      },
    );
  }

  void _blocListener(final BuildContext context, final EventsState state) {
    if (state is MoreItemsResultViewed) {
      _itemsEventsShowing.addAll(state.newItems);
    } else if (state is EventsGotLoadMore) {
      _offset += 20;
      _itemsEventsAll.addAll(state.model);
      context.read<EventsBloc>()
        ..add(const ShowHideLoadMoreIndicator(isShown: false))
        ..add(ViewMoreItemsResult(
          allItems: _itemsEventsAll,
          viewedItemsCont: _itemsEventsShowing.length,
        ));
    } else if (state is LoadMoreIndicatorShownHidden) {
      _isLoadingMore = state.isShown;
    }
  }

  Widget get _eventsCount => Visibility(
        visible: _itemsEventsShowing.isNotEmpty,
        child: TextView(
          title: widget.allEventsCount.showingCount(_itemsEventsShowing.length),
          size: TextSizes.sp13.sp,
          weight: FontWeight.w400,
          color: ColorsRes.exceptionsTitle,
        ),
      );

  Widget _viewMore({required VoidCallback onTap}) => ViewMoreButton(
        isVisible: _itemsEventsShowing.length >= 5 &&
            _itemsEventsShowing.length < widget.allEventsCount,
        isLoadingMore: _isLoadingMore,
        onTap: onTap,
      );

  void _events({required List<EventsSearchResponseModel> data}) {
    if (data.length <= 5) {
      _itemsEventsShowing = data;
    } else {
      _itemsEventsShowing = data.sublist(0, 5);
    }
  }
}
