import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/user_func_permission.dart';
import 'package:safe_access/core/values_holder/worker_register_notify_data.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/bloc/workers_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/bloc/workers_event.dart';
import 'package:safe_access/features/presentation/screens/workers/bloc/workers_state.dart';
import 'package:safe_access/features/presentation/widgets/action_bar_no_buttons.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/nav_page_flat_button.dart';
import 'package:safe_access/features/presentation/widgets/notification_block.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({Key? key}) : super(key: key);

  @override
  WorkersScreenState createState() => WorkersScreenState();
}

class WorkersScreenState extends State<WorkersScreen> {
  bool _isFirstNotifyShown = false;
  bool _isSecondNotifyShown = false;
  String _firstNotifyText = '';
  String _secondNotifyText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkTheNotification(context: context);
    return BlocProvider<WorkersBloc>(
      create: (final BuildContext context) => WorkersBloc(),
      child: BlocConsumer<WorkersBloc, WorkersState>(
        listener: _blocListener,
        builder: (final BuildContext context, final WorkersState state) {
          return SafeArea(
            child: Scaffold(
              appBar: const ActionBarNoButtons(
                title: StringsRes.workers,
              ),
              body: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.padding24.w,
                        vertical: Dimensions.padding16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.asset(
                          IconsRes.workersBack,
                          height: Dimensions.workerBackImageHeight.h,
                          width: Dimensions.workerBackImageWidth.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: Dimensions.margin16.h,
                        ),
                        NavPageFlatButton(
                          title: StringsRes.searchWorkers,
                          icon: IconsRes.workersSearch,
                          onTap: () => context
                              .read<WorkersBloc>()
                              .add(const LaunchSearch()),
                        ),
                        SizedBox(
                          height: Dimensions.margin16.h,
                        ),
                        NavPageFlatButton(
                          title: StringsRes.registerWorker,
                          icon: IconsRes.addWorker,
                          onTap: () {
                            if (getIt<UserFuncPermission>()
                                .isCanEditAddWorkers) {
                              context
                                  .read<WorkersBloc>()
                                  .add(const LaunchRegistration());
                            } else {
                              _showToastWarning();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: Dimensions.margin16.h,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      visible: _isFirstNotifyShown,
                      child: NotificationBlock(
                        msg: _firstNotifyText,
                        onTap: () => context
                            .read<WorkersBloc>()
                            .add(const HideFirstNotify()),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Dimensions.margin85.h,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      visible: _isSecondNotifyShown,
                      child: NotificationBlock(
                        msg: _secondNotifyText,
                        onTap: () => context
                            .read<WorkersBloc>()
                            .add(const HideSecondNotify()),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: const FloatingButton(
                bottomMargin: Dimensions.margin67,
              ),
            ),
          );
        },
      ),
    );
  }

  void _blocListener(final BuildContext context, final WorkersState state) {
    if (state is FirstNotifyHidden) {
      _isFirstNotifyShown = false;
    } else if (state is SecondNotifyHidden) {
      _isSecondNotifyShown = false;
    }
  }

  void _checkTheNotification({required BuildContext context}) {
    final WorkerRegisterNotifyData? arguments =
        ModalRoute.of(context)!.settings.arguments as WorkerRegisterNotifyData?;
    if (arguments != null) {
      _isFirstNotifyShown = arguments.isNeedShowFirst;
      _isSecondNotifyShown = arguments.isNeedShowSecond;
      _firstNotifyText = arguments.firstText;
      _secondNotifyText = arguments.secondText;
    }
  }

  void _showToastWarning() => Fluttertoast.showToast(
        msg: StringsRes.noPermission,
        backgroundColor: Colors.grey,
        fontSize: TextSizes.sp16.sp,
      );

  @override
  void dispose() {
    super.dispose();
  }
}
