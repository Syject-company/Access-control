import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class DateRangeCalendar extends StatelessWidget {
  const DateRangeCalendar({
    Key? key,
    required this.timeRange,
    required this.timeRangeText,
    this.title = StringsRes.dateRange,
  }) : super(key: key);

  final Function(DateTimeRange range) timeRange;
  final String? timeRangeText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextView(
          title: title,
          weight: FontWeight.w400,
          size: TextSizes.sp16.sp,
        ),
        SizedBox(
          height: Dimensions.margin8.h,
        ),
        TextButton(
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            await _getDate(context: context).then((DateTimeRange? date) {
              if (date != null) {
                timeRange(date);
              }
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Container(
            width: double.maxFinite,
            height: Dimensions.buttonHeight50.h,
            // alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(Dimensions.padding12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: ColorsRes.switchIcon,
                width: Dimensions.padding2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextView(
                  title: timeRangeText ?? StringsRes.dateRangeHint,
                  weight: FontWeight.w400,
                  size: TextSizes.sp14.sp,
                  color: timeRangeText != null
                      ? ColorsRes.primaryText
                      : ColorsRes.subText,
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  color: ColorsRes.secondPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTimeRange?> _getDate({required BuildContext context}) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime.now().add(const Duration(days: -1095)).toLocal(),
      lastDate: DateTime.now().toLocal(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: ColorsRes.secondPrimary,
              onPrimary: Colors.yellow,
              surface: ColorsRes.calendarAccent,
              onSurface: ColorsRes.secondPrimary,
            ),
            textTheme: TextTheme(
              //Button "Save"
              button: TextStyle(fontSize: TextSizes.sp16.sp),
              //select range text
              overline: TextStyle(fontSize: TextSizes.sp16.sp),
              //start date - ends date
              headline5: TextStyle(fontSize: TextSizes.sp14.sp),
              //Days of week at top
              subtitle2: TextStyle(fontSize: TextSizes.sp16.sp),
              //month and month days in body
              bodyText2: TextStyle(fontSize: TextSizes.sp15.sp),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.padding8.h),
            child: child,
          ),
        );
      },
    );
  }
}
