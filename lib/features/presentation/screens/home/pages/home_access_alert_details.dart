import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_bloc.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_event.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_state.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class HomeAccessAlertDetails extends StatefulWidget {
  const HomeAccessAlertDetails({
    Key? key,
    required this.model,
    required this.image,
    required this.isCanHandle,
  }) : super(key: key);

  final AccessAlertResponseModel model;
  final String image;
  final bool isCanHandle;

  @override
  HomeAccessAlertDetailsState createState() => HomeAccessAlertDetailsState();
}

class HomeAccessAlertDetailsState extends State<HomeAccessAlertDetails> {
  late String _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is TheAlertImageReloaded) {
          _image = state.imageUrl;
        }
      },
      builder: (BuildContext context, HomeState state) {
        if (!context.read<HomeBloc>().isClosed) {
          context
              .read<HomeBloc>()
              .add(const ShowFCMDataLoading(isShown: false));
        }
        return SafeArea(
          child: Scaffold(
            appBar: ActionBar(
              title: StringsRes.accessAlertDetails,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_image.isNotEmpty && _image.startsWith('http'))
                  CachedNetworkImage(
                      imageUrl: _image,
                      height: Dimensions.accessDetailsImage.h,
                      fit: BoxFit.cover,
                      placeholder: (BuildContext context, String url) =>
                          const ProgIndicator(),
                      errorWidget:
                          (BuildContext cxt, String url, dynamic error) {
                        context
                            .read<HomeBloc>()
                            .add(ReloadTheAlertImage(imageUrl: _image));
                        return Image.asset(
                          IconsRes.noImage,
                          height: Dimensions.accessDetailsImage.h,
                          fit: BoxFit.cover,
                        );
                      })
                else
                  Image.asset(
                    IconsRes.noImage,
                    height: Dimensions.accessDetailsImage.h,
                    fit: BoxFit.cover,
                  ),
                SizedBox(
                  height: Dimensions.margin16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.padding24.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextView(
                        title: ItemsData.classifications
                            .nameClassification(widget.model.classificationId),
                        weight: FontWeight.w600,
                        size: TextSizes.sp19.sp,
                      ),
                      SizedBox(
                        height: Dimensions.margin8.h,
                      ),
                      TextView(
                        title: widget.model.createDate != null
                            ? widget.model.createDate!.formattedDate
                            : 'N/A',
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                        color: ColorsRes.darkGreyText,
                      ),
                      SizedBox(
                        height: Dimensions.margin16.h,
                      ),
                      Row(
                        children: <Widget>[
                          TextView(
                            title: StringsRes.camera,
                            weight: FontWeight.w400,
                            size: TextSizes.sp13.sp,
                          ),
                          TextView(
                            title:
                                '${widget.model.alertDetails?.hardware?.identifier} ${widget.model.alertDetails?.hardware?.serialNumber}',
                            weight: FontWeight.w700,
                            size: TextSizes.sp13.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.margin5.h,
                      ),
                      TextView(
                        title: widget.model.alertDetails.address,
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                        color: ColorsRes.darkGreyText,
                      ),
                      Visibility(
                        visible: widget.model.person?.firstName != null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: Dimensions.margin16.h,
                            ),
                            TextView(
                              title:
                                  '${widget.model.person?.firstName ?? ''} ${widget.model.person?.surname ?? ''}',
                              weight: FontWeight.w700,
                              size: TextSizes.sp13.sp,
                            ),
                            SizedBox(
                              height: Dimensions.margin5.h,
                            ),
                            TextView(
                              title:
                                  '${widget.model.person?.identificationNumber ?? ''}, ${widget.model.personsProjects?.position?.name ?? ''}, ${widget.model.personsProjects?.employer?.name ?? ''}',
                              weight: FontWeight.w400,
                              size: TextSizes.sp13.sp,
                              color: ColorsRes.secondaryText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SolidButton(
                  label: StringsRes.handleAlert,
                  onTap: () => context.read<HomeBloc>().add(HandleAccessAlert(
                      id: widget.model.id ?? 0,
                      alertType: widget.model.alertType ?? 'unauthorized')),
                  isAnimateOnTap: false,
                  isClickable: widget.isCanHandle,
                  controller: RoundedLoadingButtonController(),
                ),
                SizedBox(
                  height: Dimensions.margin24.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
