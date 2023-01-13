import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_state.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/dropdown_field.dart';
import 'package:safe_access/features/presentation/widgets/input_text_passport_id.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    Key? key,
    required this.projects,
    required this.lastProject,
  }) : super(key: key);

  //Note: only active projects
  final List<ProjectResponseModel> projects;
  final String? lastProject;

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormFieldState<String>> _projectsFieldKey =
      GlobalKey<FormFieldState<String>>();
  final RoundedLoadingButtonController _nextController =
      RoundedLoadingButtonController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _iDController = TextEditingController();

  bool _isPassportChecked = false;
  bool _isIDChecked = true;
  bool _isNextClickable = false;
  String? _project;
  String _passportID = '';
  bool _isErrorNeedShow = false;

  @override
  void initState() {
    super.initState();
    _project = widget.lastProject;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      create: (final BuildContext context) => RegistrationBloc(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: _blocListener,
        builder: (final BuildContext context, final RegistrationState state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: ActionBar(
                title: StringsRes.registerWorker,
              ),
              body: Padding(
                padding: EdgeInsets.all(Dimensions.padding24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextView(
                      title: StringsRes.step1,
                      weight: FontWeight.w400,
                      size: TextSizes.sp16.sp,
                      align: TextAlign.center,
                      color: ColorsRes.steelBlueText,
                    ),
                    SizedBox(
                      height: Dimensions.margin5.h,
                    ),
                    Image.asset(
                      IconsRes.step1,
                      matchTextDirection: true,
                    ),
                    SizedBox(
                      height: Dimensions.margin43.h,
                    ),
                    DropdownField(
                      title: StringsRes.project,
                      dropdownFieldKey: _projectsFieldKey,
                      items: widget.projects.namesActive,
                      hint: StringsRes.selectProject,
                      lastProjectName: _project,
                      onChanged: (String? value) async {
                        _project = value;
                        if (value != null) {
                          await getIt<Storage>().setWorkerLastSelectedProject(value);
                        }
                        context.read<RegistrationBloc>().add(
                            CheckNextButtonClickable(
                                project: _project ?? '',
                                passportID: _passportID,
                                isReachLimit: false));
                      },
                    ),
                    SizedBox(
                      height: Dimensions.margin13.h,
                    ),
                    InputTextPassportId(
                      title: StringsRes.enterIDPassportRequired,
                      isPassportChecked: _isPassportChecked,
                      onTapPassport: () => context.read<RegistrationBloc>().add(
                            const SelectPassportOrIDField(
                              isPassportSelected: true,
                              isIdSelected: false,
                            ),
                          ),
                      passportController: _passportController,
                      isIDChecked: _isIDChecked,
                      onTapID: () => context.read<RegistrationBloc>().add(
                            const SelectPassportOrIDField(
                              isPassportSelected: false,
                              isIdSelected: true,
                            ),
                          ),
                      iDController: _iDController,
                      onChanged: (String value, bool isReachLimit) {
                        _passportID = value;
                        context
                            .read<RegistrationBloc>()
                            .add(CheckNextButtonClickable(
                              project: _project ?? '',
                              passportID: _passportID,
                              isReachLimit: isReachLimit,
                            ));
                      },
                      isErrorNeedShow: _isErrorNeedShow,
                    ),
                    const Spacer(),
                    _nextButton(context: context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _blocListener(
      final BuildContext context, final RegistrationState state) {
    if (state is PassportOrIDFieldSelected) {
      _isPassportChecked = state.isPassportSelected;
      _isIDChecked = state.isIdSelected;
      if (_passportController.text.isNotEmpty) {
        _passportController.clear();
      }
      if (_iDController.text.isNotEmpty) {
        _iDController.clear();
      }
      _isNextClickable = false;
      _isErrorNeedShow = false;
    } else if (state is NextButtonClickableChecked) {
      _isNextClickable = state.project.isNotEmpty &&
          state.passportID.isEnable(_isPassportChecked);
      _isErrorNeedShow = state.isReachLimit;
    }
  }

  Widget _nextButton({required BuildContext context}) => SolidButton(
        label: StringsRes.next,
        controller: _nextController,
        isAnimateOnTap: false,
        isClickable: _isNextClickable,
        onTap: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          final String _value =
              textInputted(_passportController.text, _iDController.text);
          if (_value.isValid) {
            context.read<RegistrationBloc>().add(
                  NavigateToNextPage(
                    projectId: widget.projects.projectId(_project ?? ''),
                    project: _project ?? '',
                    typeId: _isIDChecked ? 1 : 2,
                    passportOrID: _value,
                  ),
                );
          }
        },
      );

  @override
  void dispose() {
    _passportController.dispose();
    _iDController.dispose();
    super.dispose();
  }
}
