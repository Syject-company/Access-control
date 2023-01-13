import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WorkersState extends Equatable {
  const WorkersState();

  @override
  List<Object> get props => <Object>[];
}

class WorkersInitial extends WorkersState {}

class FirstNotifyHidden extends WorkersState {
  const FirstNotifyHidden({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}

class SecondNotifyHidden extends WorkersState {
  const SecondNotifyHidden({required this.updateKey});

  final Key updateKey;

  @override
  List<Object> get props => <Object>[updateKey];
}
