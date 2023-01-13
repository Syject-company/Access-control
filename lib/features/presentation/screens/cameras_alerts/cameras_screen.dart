import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/bloc/cameras_bloc.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/bloc/cameras_event.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/bloc/cameras_state.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/components/camera_alert_item_list.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/components/cameras_alert_count.dart';
import 'package:safe_access/features/presentation/widgets/action_bar_no_buttons.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';

class CamerasScreen extends StatefulWidget {
  const CamerasScreen({Key? key}) : super(key: key);

  @override
  CamerasScreenState createState() => CamerasScreenState();
}

class CamerasScreenState extends State<CamerasScreen> {
  List<CameraAlertResponseModel> _alerts = <CameraAlertResponseModel>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CamerasBloc>(
      create: (final BuildContext context) =>
          CamerasBloc()..add(const GetCameraAlerts()),
      child: BlocConsumer<CamerasBloc, CamerasState>(
        listener: _blocListener,
        builder: (final BuildContext context, final CamerasState state) {
          return SafeArea(
            child: Scaffold(
              appBar: const ActionBarNoButtons(
                title: StringsRes.cameras,
              ),
              body: _isLoading
                  ? const Center(
                      child: ProgIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.padding24.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: Dimensions.margin16.h,
                          ),
                          CamerasAlertCount(
                            alertsCount: _alerts.length,
                          ),
                          SizedBox(
                            height: Dimensions.margin16.h,
                          ),
                          Expanded(
                            child: CameraAlertItemList(
                              list: _alerts,
                              onItemTap: (CameraAlertResponseModel model) {
                                context.read<CamerasBloc>().add(
                                      LaunchCamerasAlertDetails(model: model),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
              floatingActionButton: const FloatingButton(
                bottomMargin: Dimensions.margin104,
              ),
            ),
          );
        },
      ),
    );
  }

  void _blocListener(final BuildContext context, final CamerasState state) {
    if (state is CameraAlertsGot) {
      _alerts = state.data;
      _isLoading = false;
    } else if (state is LoadingShown) {
      _isLoading = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
