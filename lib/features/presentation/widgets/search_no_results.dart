import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class SearchNoResults extends StatelessWidget {
  const SearchNoResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4.sm,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                IconsRes.noResults,
                height: Dimensions.noResultsIcon.h,
                width: Dimensions.noResultsIcon.w,
                matchTextDirection: true,
              ),
              SizedBox(
                height: Dimensions.margin32.h,
              ),
              TextView(
                title: StringsRes.noResultsChangeParameters,
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
                align: TextAlign.center,
                color: ColorsRes.subText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
