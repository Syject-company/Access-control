import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_bloc.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_event.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_state.dart';
import 'package:safe_access/features/presentation/screens/home/components/pages_nav_button.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show ListSizeTest;

class HomePagesNav extends StatefulWidget {
  const HomePagesNav({
    Key? key,
  }) : super(key: key);

  @override
  HomePagesNavState createState() => HomePagesNavState();
}

class HomePagesNavState extends State<HomePagesNav> {
  int accessAlertCount = 0;
  int cameraAlertCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is AccessAlertCount) {
          accessAlertCount = state.alertCount;
        } else if (state is CameraAlertCount) {
          cameraAlertCount = state.alertCount;
        }
      },
      builder: (BuildContext context, HomeState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PagesNavButton(
                      //Todo: need to pass list accessAlerts from server or use FutureBuilder
                      title: StringsRes.accessAlerts,
                      icon: IconsRes.accessAlert,
                      alertCount: accessAlertCount,
                      key: const ValueKey<String>(StringsRes.accessAlerts),
                      onTap: () => context
                          .read<HomeBloc>()
                          .add(const LaunchPage(route: RouteName.accessAlert)),
                    ),
                    SizedBox(
                      height: Dimensions.margin14.h,
                    ),
                    PagesNavButton(
                      title: StringsRes.workers,
                      icon: IconsRes.workers,
                      key: const ValueKey<String>(StringsRes.workers),
                      onTap: () => context
                          .read<HomeBloc>()
                          .add(const LaunchPage(route: RouteName.workers)),
                    ),
                    SizedBox(
                      height: Dimensions.margin14.h,
                    ),
                    //Note: placed here temporary
                    PagesNavButton(
                      title: StringsRes.settings,
                      icon: IconsRes.settings,
                      onTap: () => context
                          .read<HomeBloc>()
                          .add(const LaunchPage(route: RouteName.settings)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Todo: need to pass list Events list from server or use FutureBuilder
                    PagesNavButton(
                      title: StringsRes.events,
                      icon: IconsRes.events,
                      key: const ValueKey<String>(StringsRes.events),
                      onTap: () {
                        if (getIt<ProjectsData>()
                            .projects
                            .isPermittedPerformAction) {
                          context
                              .read<HomeBloc>()
                              .add(const LaunchPage(route: RouteName.events));
                        }
                      },
                    ),
                    SizedBox(
                      height: Dimensions.margin14.h,
                    ),
                    PagesNavButton(
                      title: StringsRes.cameras,
                      icon: IconsRes.cameras,
                      alertCount: cameraAlertCount,
                      key: const ValueKey<String>(StringsRes.cameras),
                      onTap: () => context
                          .read<HomeBloc>()
                          .add(const LaunchPage(route: RouteName.cameras)),
                    ),
                    SizedBox(
                      height: Dimensions.margin14.h,
                    ),
                    //Note: hidden temporary
                    SizedBox(
                      height: Dimensions.navButtonHeight.h,
                    ),
                    /*       PagesNavButton(
                  title: StringsRes.support,
                  icon: IconsRes.support,
                  key: const ValueKey<String>(StringsRes.support,),
                  onTap: () => context
                      .read<HomeBloc>()
                      .add(const LaunchPage(route: RouteName.support)),
                ),*/
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
