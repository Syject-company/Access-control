import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    Key? key,
    required this.onToggle,
    required this.isOn,
  }) : super(key: key);

  final Function(bool value) onToggle;
  final bool isOn;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      height: Dimensions.switchHeight.h,
      width: Dimensions.switchWidth.w,
      padding: Dimensions.padding2.h,
      switchBorder: Border.all(
        color: ColorsRes.switchBorder,
        //width: Dimensions.padding2.h,
      ),
      toggleSize: Dimensions.toggleSize.h,
      activeColor: Colors.white,
      inactiveToggleColor: ColorsRes.switchIcon,
      activeToggleColor: ColorsRes.filterButton,
      inactiveColor: Colors.white,
      value: isOn,
      onToggle: onToggle,
    );
  }
}
