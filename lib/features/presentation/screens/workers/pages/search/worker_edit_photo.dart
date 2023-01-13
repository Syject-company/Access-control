import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/components/worker_photo_capture_text.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_state.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class WorkerEditPhoto extends StatefulWidget {
  const WorkerEditPhoto({
    Key? key,
    required this.image,
    required this.imageFile,
  }) : super(key: key);
  final String? image;
  final File? imageFile;

  @override
  WorkerEditPhotoState createState() => WorkerEditPhotoState();
}

class WorkerEditPhotoState extends State<WorkerEditPhoto> {
  final RoundedLoadingButtonController _changeController =
      RoundedLoadingButtonController();

  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  bool _isSuccessCaptured = false;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (BuildContext context, SearchState state) {
        if (state is WorkerPhotoUpdated) {
          _imageFile = state.image;
          _isSuccessCaptured = true;
        }
      },
      builder: (BuildContext context, SearchState state) {
        return SafeArea(
          child: Scaffold(
            appBar: ActionBar(
              title: StringsRes.editPhoto,
            ),
            body: Padding(
              padding: EdgeInsets.all(Dimensions.padding24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: Dimensions.margin164.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _pickImage(
                        onPhotoTaken: (File image) {
                          context.read<SearchBloc>().add(
                                UpdateWorkerPhoto(image: image),
                              );
                        },
                      );
                    },
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          _photoAvatar(),
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
                  _changeButton(onTap: () {
                    context.read<SearchBloc>().add(
                          ChangeWorkerPhoto(image: _imageFile!),
                        );
                    _backAndClose;
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _photoAvatar() {
    return SizedBox(
      width: Dimensions.workerEditPhotoImage.w,
      height: Dimensions.workerEditPhotoImage.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (_imageFile == null)
              if (widget.image != null && widget.image!.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: widget.image ?? '',
                  fit: BoxFit.fill,
                  placeholder: (BuildContext context, String url) =>
                      const ProgIndicator(),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          Container(
                    width: Dimensions.accessImage.w,
                    height: Dimensions.accessImage.w,
                    color: ColorsRes.imageBack,
                    child: Image.asset(
                      IconsRes.noPhoto,
                      height: Dimensions.workerNavButtonFirstIcon.h,
                      width: Dimensions.workerNavButtonFirstIcon.w,
                      matchTextDirection: true,
                    ),
                  ),
                )
              else
                Container(
                  width: Dimensions.accessImage.w,
                  height: Dimensions.accessImage.w,
                  color: ColorsRes.imageBack,
                  child: Image.asset(
                    IconsRes.noPhoto,
                    height: Dimensions.workerNavButtonFirstIcon.h,
                    width: Dimensions.workerNavButtonFirstIcon.w,
                    matchTextDirection: true,
                  ),
                )
            else
              Image(image: FileImage(_imageFile!), fit: BoxFit.cover),
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
    );
  }

  Widget _changeButton({required VoidCallback onTap}) => SolidButton(
        label: StringsRes.update,
        onTap: onTap,
        controller: _changeController,
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

  void get _backAndClose => getIt<Navigation>().pop();
}
