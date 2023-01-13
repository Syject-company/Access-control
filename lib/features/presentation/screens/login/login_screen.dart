import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/login/bloc/login_bloc.dart';
import 'package:safe_access/features/presentation/screens/login/bloc/login_event.dart';
import 'package:safe_access/features/presentation/screens/login/bloc/login_state.dart';
import 'package:safe_access/features/presentation/widgets/dialog_view.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  final RoundedLoadingButtonController _logInController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<LogInBloc>(
          create: (final BuildContext context) => LogInBloc(),
          child: BlocConsumer<LogInBloc, LogInState>(
            listener: _blocListener,
            builder: (final BuildContext context, final LogInState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    IconsRes.logo,
                    height: Dimensions.logoSize.w,
                    width: Dimensions.logoSize.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: Dimensions.margin16.h,
                  ),
                  _appTitle,
                  SizedBox(
                    height: Dimensions.margin64.sp,
                  ),
                  _logInButton(
                    onTap: () {
                      context.read<LogInBloc>().add(LogInAzure());
                      _logInController.reset();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _blocListener(final BuildContext context, final LogInState state) {
    if (state is AzureLoggedIn) {
      _logInController.success();
      context.read<LogInBloc>().add(GetUserData());
    } else if (state is ErrorShown) {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return _dialog(
            onTap: () => getIt<Navigation>().pop(),
            error: state.error,
          );
        },
      );
    }else if (state is UserDataErrorChecked){
      _logInController.reset();
    }
  }

  Widget get _appTitle => TextView(
        title: StringsRes.appName,
        size: TextSizes.logo.sp,
        weight: FontWeight.w700,
        align: TextAlign.center,
      );

  Widget _logInButton({required VoidCallback onTap}) => SolidButton(
        label: StringsRes.logIn,
        onTap: onTap,
        controller: _logInController,
      );

  Widget _dialog({required VoidCallback onTap, required String error}) =>
      DialogView(
        title: StringsRes.logIn,
        content: error,
        rightOnTap: onTap,
        rightButtonText: StringsRes.close,
      );

  @override
  void dispose() {
    super.dispose();
  }
}
