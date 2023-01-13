import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => <Object>[];
}

class ShowLogOutDialog extends SettingsEvent {
  const ShowLogOutDialog();

  @override
  List<Object> get props => <Object>[];
}

class LogOut extends SettingsEvent {
  const LogOut();

  @override
  List<Object> get props => <Object>[];
}

class LaunchLanguagePage extends SettingsEvent {
  const LaunchLanguagePage();

  @override
  List<Object> get props => <Object>[];
}

class UpdateLanguage extends SettingsEvent {
  const UpdateLanguage({
    required this.lanCode,
    required this.locale,
  });

  final String lanCode;
  final Locale locale;

  @override
  List<Object> get props => <Object>[lanCode, locale];
}
