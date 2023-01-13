import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/app_info.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_bloc.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_event.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_state.dart';
import 'package:safe_access/features/presentation/screens/home/components/home_pages_nav.dart';
import 'package:safe_access/features/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_access/features/presentation/widgets/dialog_confirm_view.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  final RoundedLoadingButtonController _logoutController =
      RoundedLoadingButtonController();

  bool _isFCMDataLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (final BuildContext context) =>
          _homeBloc..add(const ResponseProjEmplPosition()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: _blocListener,
        builder: (final BuildContext context, final HomeState state) {
          return _isFCMDataLoading
              ? const Material(
                  color: ColorsRes.backGround,
                  child: Center(
                    child: ProgIndicator(),
                  ),
                )
              : SafeArea(
                  child: Scaffold(
                    body: Padding(
                      padding: EdgeInsets.all(
                        Dimensions.padding19.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextView(
                            title: StringsRes.appName,
                            weight: FontWeight.w700,
                            size: TextSizes.sp32.sp,
                            color: ColorsRes.steelBlueText,
                          ),
                          SizedBox(
                            height: Dimensions.margin3.h,
                          ),
                          TextView(
                            title:
                                '${StringsRes.version}${getIt<AppInfo>().appVersion ?? ''}',
                            weight: FontWeight.w400,
                            size: TextSizes.sp16.sp,
                            color: ColorsRes.subText,
                          ),
                          SizedBox(
                            height: Dimensions.margin20.h,
                          ),
                          Image.asset(
                            IconsRes.homeBack,
                            height: Dimensions.homeBackImageHeight.h,
                            width: Dimensions.homeBackImageWidth.w,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: Dimensions.margin20.h,
                          ),
                          BlocProvider<HomeBloc>.value(
                            value: _homeBloc,
                            child: const HomePagesNav(),
                          ),
                        ],
                      ),
                    ),
                    bottomNavigationBar: BottomNavBar(
                      navType: BottomNavTypeSelected.logOut,
                      onLogOut: () => context
                          .read<HomeBloc>()
                          .add(const ShowLogOutDialog()),
                    ),
                  ),
                );
        },
      ),
    );
  }

  void _blocListener(final BuildContext context, final HomeState state) {
    if (state is LogOutDialogShown) {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext ctx) {
          return DialogConfirmView(
            title: StringsRes.procLogOut,
            content: StringsRes.ifYouLogOut,
            topButtonText: StringsRes.logOut,
            controller: _logoutController,
            topOnTap: () {
              _logoutController.start();
              context.read<HomeBloc>().add(const LogOut());
            },
          );
        },
      );
    } else if (state is LogOutError) {
      _logoutController.reset();
    } else if (state is ProjEmplPositionRespond) {
      context.read<HomeBloc>().add(const UpdateFirebaseToken());
    } else if (state is FirebaseTokenUpdated) {
      context.read<HomeBloc>().add(const CheckFCMDataEmpty());
    } else if (state is FCMDataLoadingShown) {
      _isFCMDataLoading = state.isShown;
    }
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }
}
