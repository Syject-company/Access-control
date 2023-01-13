import 'package:equatable/equatable.dart';

abstract class WorkersEvent extends Equatable {
  const WorkersEvent();

  @override
  List<Object> get props => <Object>[];
}

class LaunchSearch extends WorkersEvent {
  const LaunchSearch();

  @override
  List<Object> get props => <Object>[];
}

class LaunchRegistration extends WorkersEvent {
  const LaunchRegistration();

  @override
  List<Object> get props => <Object>[];
}

class HideFirstNotify extends WorkersEvent {
  const HideFirstNotify();

  @override
  List<Object> get props => <Object>[];
}

class HideSecondNotify extends WorkersEvent {
  const HideSecondNotify();

  @override
  List<Object> get props => <Object>[];
}