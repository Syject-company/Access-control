import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/home/home_screen.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_bloc.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_event.dart';
import 'package:safe_access/features/presentation/screens/settings/bloc/settings_state.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/dialog_confirm_view.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/nav_page_flat_button.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (BuildContext context, SettingsState state) {
        if (state is LanguageUpdated) {
          context.setLocale(state.locale);
          _navToHomeScreen();
        }
      },
      builder: (BuildContext context, SettingsState state) {
        return SafeArea(
          child: Scaffold(
            key: UniqueKey(),
            appBar: ActionBar(
              title: StringsRes.language,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.padding24.w),
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
                    title: StringsRes.english,
                    icon: IconsRes.englishFlag,
                    isArrowShown: false,
                    isIgnoringClick: context.locale == const Locale('en'),
                    onTap: () => showDialogView(
                      context: context,
                      lang: StringsRes.english,
                      locale: const Locale('en'),
                      lanCode: 'en',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.margin16.h,
                  ),
                  NavPageFlatButton(
                    title: StringsRes.hebrew,
                    icon: IconsRes.israelFlag,
                    isIgnoringClick: context.locale == const Locale('he'),
                    isArrowShown: false,
                    onTap: () => showDialogView(
                      context: context,
                      lang: StringsRes.hebrew,
                      locale: const Locale('he'),
                      lanCode: 'he',
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: const FloatingButton(
              bottomMargin: Dimensions.margin67,
            ),
          ),
        );
      },
    );
  }

  Future<void> showDialogView({
    required BuildContext context,
    required String lang,
    required Locale locale,
    required String lanCode,
  }) =>
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext ctx) {
          return DialogConfirmView(
            title: '${StringsRes.changeLanguage.tr()}${lang.tr()}?',
            content: StringsRes.youCanSwitchLanguage,
            topButtonText: StringsRes.changeLanguageButton,
            controller: RoundedLoadingButtonController(),
            topOnTap: () {
              context
                  .read<SettingsBloc>()
                  .add(UpdateLanguage(lanCode: lanCode, locale: locale));
            },
          );
        },
      );

  void _navToHomeScreen() {
    //Note: The Key and not const To redraw the Screens
    getIt<Navigation>().navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute<HomeScreen>(
            builder: (BuildContext context) => HomeScreen(key: UniqueKey())),
        (Route<dynamic> route) => false);
  }
}
