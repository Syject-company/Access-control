import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SupportState extends Equatable {
  const SupportState();

  @override
  List<Object> get props => <Object>[];
}

class SupportInitial extends SupportState {}

class ColorChanged extends SupportState {
  const ColorChanged({required this.color});

  final Color color;

  @override
  List<Object> get props => <Object>[color];
}
