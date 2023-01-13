import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/data/entities/responses/worker_data_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_state.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/dialog_confirm_view.dart';
import 'package:safe_access/features/presentation/widgets/input_text_passport_id.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class WorkerEditDetails extends StatefulWidget {
  const WorkerEditDetails({
    Key? key,
    required this.image,
    required this.projectId,
    required this.model,
    required this.idNumber,
    required this.idType,
    required this.imageFile,
  }) : super(key: key);

  final String? image;
  final int projectId;
  final int idType;
  final String idNumber;
  final WorkerDataResponseModel? model;
  final File? imageFile;

  @override
  WorkerEditDetailsState createState() => WorkerEditDetailsState();
}

class WorkerEditDetailsState extends State<WorkerEditDetails> {
  final RoundedLoadingButtonController _saveController =
      RoundedLoadingButtonController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _iDController = TextEditingController();

  File? _imageFile;
  bool _isPassportChecked = false;
  bool _isIDChecked = true;
  bool _isErrorNeedShow = false;
  String _passportIdValue = '';

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: _blocListener,
      builder: (BuildContext context, SearchState state) {
        return SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: ActionBar(
            title: StringsRes.editWorker,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: Dimensions.margin32.h,
              bottom: Dimensions.margin24.h,
              left: Dimensions.margin24.h,
              right: Dimensions.margin24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<SearchBloc>().add(
                          LaunchWorkerEditPhoto(
                            image: widget.image,
                            imageFile: _imageFile,
                          ),
                        );
                  },
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: Dimensions.workerEditDetailsImage.w,
                          height: Dimensions.workerEditDetailsImage.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: _imageFile == null
                                ? widget.image != null &&
                                        widget.image!.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: widget.image ?? '',
                                        fit: BoxFit.cover,
                                        placeholder: (BuildContext context,
                                                String url) =>
                                            const ProgIndicator(),
                                        errorWidget: (BuildContext context,
                                                String url, dynamic error) =>
                                            Container(
                                          width: Dimensions.accessImage.w,
                                          height: Dimensions.accessImage.w,
                                          color: ColorsRes.imageBack,
                                        ),
                                      )
                                    : Container(
                                        width: Dimensions.accessImage.w,
                                        height: Dimensions.accessImage.w,
                                        color: ColorsRes.imageBack,
                                      )
                                : Image(
                                    image: FileImage(_imageFile!),
                                    fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.margin8.h,
                        ),
                        TextView(
                          title: StringsRes.editPhoto,
                          size: TextSizes.sp13.sp,
                          weight: FontWeight.w400,
                          align: TextAlign.center,
                          color: ColorsRes.steelBlueText,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.margin24.h,
                ),
                InputTextPassportId(
                  title: StringsRes.enterIDPassport,
                  isPassportChecked: _isPassportChecked,
                  onTapPassport: () => context.read<SearchBloc>().add(
                        const SelectPassportOrIDField(
                            isPassportSelected: true, isIdSelected: false),
                      ),
                  passportController: _passportController,
                  isIDChecked: _isIDChecked,
                  onTapID: () => context.read<SearchBloc>().add(
                        const SelectPassportOrIDField(
                            isPassportSelected: false, isIdSelected: true),
                      ),
                  iDController: _iDController,
                  onChanged: (String value, bool isReachLimit) =>
                      context.read<SearchBloc>().add(CheckFieldChanges(
                            value: value,
                            isReachLimit: isReachLimit,
                          )),
                  isErrorNeedShow: _isErrorNeedShow,
                ),
                const Spacer(),
                _saveButton(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _showDialogView(context: context);
                  },
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  void _blocListener(final BuildContext context, final SearchState state) {
    if (state is PassportOrIDFieldSelected) {
      _isPassportChecked = state.isPassportSelected;
      _isIDChecked = state.isIdSelected;
      if (_passportController.text.isNotEmpty) {
        _passportController.clear();
      }
      if (_iDController.text.isNotEmpty) {
        _iDController.clear();
      }
      _isErrorNeedShow = false;
    } else if (state is WorkerPhotoChanged) {
      _imageFile = state.image;
    } else if (state is FieldChangesChecked) {
      _passportIdValue = state.value;
      _isErrorNeedShow = state.isReachLimit;
    }
  }

  Widget _saveButton({required VoidCallback onTap}) => SolidButton(
        label: StringsRes.saveProfile,
        onTap: onTap,
        controller: _saveController,
        isAnimateOnTap: false,
        isClickable: _imageFile != null || _passportIdValue.isNotEmpty,
      );

  Future<void> _showDialogView({
    required BuildContext context,
  }) =>
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext ctx) {
          return DialogConfirmView(
            title: StringsRes.warning,
            content: StringsRes.overrideWorkerIdentification,
            topButtonText: StringsRes.overrideData,
            controller: RoundedLoadingButtonController(),
            topOnTap: () {
              getIt<Navigation>().pop();
              context.read<SearchBloc>().add(OverrideWorkerData(
                    image: _imageFile,
                    identificationType: _passportIdValue.isNotEmpty
                        ? _isIDChecked
                            ? 1
                            : 2
                        : widget.idType,
                    identificationNumber: _passportIdValue.isNotEmpty
                        ? _isIDChecked
                            ? _iDController.text
                            : _passportController.text
                        : widget.idNumber,
                    projectId: widget.projectId,
                    personId: widget.model?.person?.id ?? 0,
                  ));
            },
          );
        },
      );

  @override
  void dispose() {
    _passportController.dispose();
    _iDController.dispose();
    super.dispose();
  }
}
