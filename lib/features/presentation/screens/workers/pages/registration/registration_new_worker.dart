import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/components/worker_photo_capture_text.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_state.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/notification_block.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class RegistrationNewWorker extends StatefulWidget {
  const RegistrationNewWorker({
    Key? key,
    required this.projectId,
    required this.project,
    required this.typeId,
    required this.passportOrID,
  }) : super(key: key);

  final int projectId;
  final String project;
  final int typeId;
  final String passportOrID;

  @override
  RegistrationNewWorkerState createState() => RegistrationNewWorkerState();
}

class RegistrationNewWorkerState extends State<RegistrationNewWorker> {
  final RoundedLoadingButtonController _registerController =
      RoundedLoadingButtonController();

  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  bool _isSuccessCaptured = false;
  bool _isNotifyShown = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: _blocListener,
      builder: (BuildContext context, RegistrationState state) {
        return SafeArea(
            child: Scaffold(
          appBar: ActionBar(
            title: StringsRes.registerWorker,
          ),
          body: Padding(
            padding: EdgeInsets.all(Dimensions.padding24.w),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextView(
                      title: StringsRes.step2,
                      weight: FontWeight.w400,
                      size: TextSizes.sp16.sp,
                      align: TextAlign.center,
                      color: ColorsRes.steelBlueText,
                    ),
                    SizedBox(
                      height: Dimensions.margin5.h,
                    ),
                    Image.asset(
                      IconsRes.step2,
                      matchTextDirection: true,
                    ),
                    SizedBox(
                      height: Dimensions.margin112.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _pickImage(
                          onPhotoTaken: (File image) {
                            context.read<RegistrationBloc>().add(
                                  UpdateWorkerPhoto(image: image),
                                );
                          },
                        );
                      },
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: Dimensions.workerEditPhotoImage.w,
                              height: Dimensions.workerEditPhotoImage.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    if (_imageFile == null)
                                      Container(
                                        width: Dimensions.accessImage.w,
                                        height: Dimensions.accessImage.w,
                                        color: ColorsRes.imageBack,
                                        child: Image.asset(
                                          IconsRes.noPhoto,
                                          height: Dimensions
                                              .workerNavButtonFirstIcon.h,
                                          width: Dimensions
                                              .workerNavButtonFirstIcon.w,
                                          matchTextDirection: true,
                                        ),
                                      )
                                    else
                                      Image(
                                          image: FileImage(_imageFile!),
                                          fit: BoxFit.cover),
                                    Visibility(
                                      visible: !_isSuccessCaptured,
                                      child: Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          color: ColorsRes.addPhoto,
                                          height: Dimensions.addPhotoHeight.h,
                                          alignment: Alignment.center,
                                          child: TextView(
                                            title: StringsRes.addPhoto,
                                            size: TextSizes.sp13.sp,
                                            weight: FontWeight.w600,
                                            align: TextAlign.center,
                                            color: ColorsRes.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.margin32.h,
                            ),
                            WorkerPhotoCaptureText(
                              textType: _isSuccessCaptured
                                  ? WorkerPhotoCaptureTextType.captureSuccessful
                                  : WorkerPhotoCaptureTextType.clickCapture,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    _registerButton(onTap: () {
                      _registerController.start();
                      context.read<RegistrationBloc>().add(
                            RegisterNewWorker(
                              image: _imageFile!,
                              projectId: widget.projectId,
                              selectedProject: widget.project,
                              typeId: widget.typeId,
                              selectedPassportOrID: widget.passportOrID,
                            ),
                          );
                    }),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Visibility(
                    visible: _isNotifyShown,
                    child: NotificationBlock(
                      msg: StringsRes.notSufficient,
                      onTap: () => context
                          .read<RegistrationBloc>()
                          .add(const HideNotify()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  void _blocListener(
      final BuildContext context, final RegistrationState state) {
    if (state is WorkerPhotoUpdated) {
      _imageFile = state.image;
      _isSuccessCaptured = true;
      _isNotifyShown = false;
    } else if (state is UpdatedWorkerPhotoRefused) {
      _registerController.reset();
      _imageFile = null;
      _isSuccessCaptured = false;
      _isNotifyShown = true;
    } else if (state is NotifyHidden) {
      _isNotifyShown = false;
    } else if (state is RegisterButtonReset) {
      _registerController.reset();
    }
  }

  Widget _registerButton({required VoidCallback onTap}) => SolidButton(
        label: StringsRes.register,
        onTap: onTap,
        controller: _registerController,
        isAnimateOnTap: false,
        isClickable: _isSuccessCaptured,
      );

  Future<void> _pickImage({required Function(File image) onPhotoTaken}) async {
    await _imagePicker
        .pickImage(source: ImageSource.camera, maxHeight: 220, maxWidth: 220)
        .then((XFile? value) async {
      if (value != null) {
        logInfo('Worker photo has been successfully taken');
        onPhotoTaken(File(value.path));
      } else {
        await Fluttertoast.showToast(
          msg: StringsRes.photoNotTaken,
          backgroundColor: Colors.grey,
          fontSize: TextSizes.sp16.sp,
        );
      }
    });
  }
}
