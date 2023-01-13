import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/core/values_holder/employers_data.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/position_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/core/values_holder/user_func_permission.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/components/worker_detail_field.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/bloc/search_state.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar_no_title_search_worker.dart';
import 'package:safe_access/features/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class WorkerDetails extends StatefulWidget {
  const WorkerDetails({
    Key? key,
    required this.model,
    required this.projectId,
  }) : super(key: key);

  final SearchWorkersResponseModel model;
  final int projectId;

  @override
  WorkerDetailsState createState() => WorkerDetailsState();
}

class WorkerDetailsState extends State<WorkerDetails> {
  //Note: if the worker data are changed in "WorkerEditDetails" need to get the "search result" list
  //Note:: and update the Worker item data in list

  String? _numberId;
  File? _imageFile;
  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    _numberId = widget.model.idNumber;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (BuildContext context, SearchState state) {
        if (state is WorkerDataEdited) {
          _numberId = state.numberId;
          _imageFile = state.image;
          _isEdited = true;
        }
      },
      builder: (BuildContext context, SearchState state) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              if (_isEdited) {
                context.read<SearchBloc>().add(const InformWorkersAfterEdit());
              }
              return true;
            },
            child: Scaffold(
              appBar: ActionBarNoTitleSearchWorker(
                onBackPress: () {
                  if (_isEdited) {
                    context
                        .read<SearchBloc>()
                        .add(const InformWorkersAfterEdit());
                  }
                  getIt<Navigation>().pop();
                },
              ),
              body: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: Dimensions.workerDetailsImage.w,
                          height: Dimensions.workerDetailsImage.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: _imageFile == null
                                ? widget.model.photoUrl != null &&
                                        widget.model.photoUrl!.isNotEmpty &&
                                        widget.model.photoUrl!
                                            .startsWith('http')
                                    ? GestureDetector(
                                        onTap: () =>
                                            showPhotoView(context: context),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.model.photoUrl ?? '',
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
                                            child: Image.asset(
                                              IconsRes.noPhoto,
                                              height: Dimensions
                                                  .workerNavButtonFirstIcon.h,
                                              width: Dimensions
                                                  .workerNavButtonFirstIcon.w,
                                              matchTextDirection: true,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
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
                                : Image(
                                    image: FileImage(_imageFile!),
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.margin16.h,
                      ),
                      TextView(
                        title:
                            '${widget.model.firstName ?? 'N/A'} ${widget.model.surname ?? 'N/A'}',
                        weight: FontWeight.w600,
                        size: TextSizes.sp19.sp,
                        color: ColorsRes.primaryText,
                        align: TextAlign.center,
                      ),
                      SizedBox(
                        height: Dimensions.margin24.h,
                      ),
                      WorkerDetailField(
                        title: StringsRes.passportIDCard,
                        data: _numberId ?? 'N/A',
                      ),
                      WorkerDetailField(
                        title: StringsRes.classification,
                        data: ItemsData.classifications.nameClassification(
                            widget.model.classification?.id),
                      ),
                      WorkerDetailField(
                        title: StringsRes.lastEntrance,
                        data: widget.model.lastEntrance?.formattedDate ?? 'N/A',
                      ),
                      WorkerDetailField(
                        title: StringsRes.employer,
                        data: getIt<EmployersData>()
                            .employers
                            .nameEmployer(widget.model.employerId),
                      ),
                      WorkerDetailField(
                        title: StringsRes.projectTitle,
                        data: getIt<ProjectsData>()
                            .projects
                            .nameProject(widget.projectId),
                      ),
                      WorkerDetailField(
                        title: StringsRes.position,
                        data: getIt<PositionsData>()
                            .positions
                            .namePosition(widget.model.positionId),
                      ),
                      WorkerDetailField(
                        title: StringsRes.registrationDate,
                        data: 'N/A',
                      ),
                      WorkerDetailField(
                        title: StringsRes.registrationUser,
                        data: 'N/A',
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavBar(
                navType: BottomNavTypeSelected.editProfile,
                onEdit: () {
                  if (getIt<UserFuncPermission>().isCanEditAddWorkers) {
                    context.read<SearchBloc>().add(LaunchWorkerEditDetails(
                        image: widget.model.photoUrl,
                        projectId: widget.projectId,
                        imageFile: _imageFile,
                        idType: widget.model.idType,
                        numberId: _numberId ?? ''));
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showPhotoView({
    required BuildContext context,
  }) =>
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            content: GestureDetector(
              onTap: () => getIt<Navigation>().pop(),
              child: CachedNetworkImage(
                imageUrl: widget.model.photoUrl ?? '',
                fit: BoxFit.contain,
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
              ),
            ),
          );
        },
      );
}
