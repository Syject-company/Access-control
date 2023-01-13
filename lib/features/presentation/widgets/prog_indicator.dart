import 'package:flutter/material.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';

class ProgIndicator extends StatelessWidget {
  const ProgIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: Dimensions.progressSize,
        height: Dimensions.progressSize,
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(ColorsRes.secondPrimary),
        ),
      ),
    );
  }
}
