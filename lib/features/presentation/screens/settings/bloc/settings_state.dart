import 'dart:ui';

abstract class SettingsState {
  SettingsState();
}

class SettingsInitial extends SettingsState {}

class LogOutDialogShown extends SettingsState {}

class LogOutError extends SettingsState {}

class LanguageUpdated extends SettingsState {
  LanguageUpdated({required this.locale});

  final Locale locale;
}
