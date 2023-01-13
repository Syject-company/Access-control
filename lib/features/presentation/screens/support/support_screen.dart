import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/screens/support/bloc/support_bloc.dart';
import 'package:safe_access/features/presentation/screens/support/bloc/support_state.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  SupportScreenState createState() => SupportScreenState();
}

class SupportScreenState extends State<SupportScreen> {
  Color color = Colors.black38;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SupportBloc>(
        create: (final BuildContext context) => SupportBloc(),
        child: BlocConsumer<SupportBloc, SupportState>(
          listener: _blocListener,
          builder: (final BuildContext context, final SupportState state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Support',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36.sp,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _blocListener(final BuildContext context, final SupportState state) {
    if (state is ColorChanged) {
      color = state.color;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
