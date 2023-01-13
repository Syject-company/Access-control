import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_bloc.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_event.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_state.dart';
import 'package:safe_access/features/presentation/widgets/action_bar_no_buttons.dart';
import 'package:safe_access/features/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_access/features/presentation/widgets/dialog_confirm_view.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/nav_page_flat_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final RoundedLoadingButtonController _logoutController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (final BuildContext context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: _blocListener,
        builder: (final BuildContext context, final SettingsState state) {
          return SafeArea(
            child: Scaffold(
              appBar: const ActionBarNoButtons(
                title: StringsRes.settings,
              ),
              body: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Dimensions.padding24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: Dimensions.margin16.h,
                    ),
                    Image.asset(
                      IconsRes.settingsBack,
                      height: Dimensions.settingsBackImageHeight.h,
                      width: Dimensions.settingsBackImageWidth.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: Dimensions.margin16.h,
                    ),
                    NavPageFlatButton(
                      title: StringsRes.language,
                      icon: IconsRes.workersSearch,
                      onTap: () => context
                          .read<SettingsBloc>()
                          .add(const LaunchLanguagePage()),
                    ),
                  ],
                ),
              ),
              floatingActionButton: const FloatingButton(),
              bottomNavigationBar: BottomNavBar(
                navType: BottomNavTypeSelected.logOut,
                onLogOut: () =>
                    context.read<SettingsBloc>().add(const ShowLogOutDialog()),
              ),
            ),
          );
        },
      ),
    );
  }

  void _blocListener(final BuildContext context, final SettingsState state) {
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
              context.read<SettingsBloc>().add(const LogOut());
            },
          );
        },
      );
    } else if (state is LogOutError) {
      _logoutController.reset();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
