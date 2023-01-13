import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SupportEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class ColorChange extends SupportEvent {
  ColorChange({required this.color});

  final Color color;

  @override
  List<Object> get props => <Object>[color];
}

class ColorChangeTwo extends SupportEvent {
  ColorChangeTwo({required this.color});

  final Color color;

  @override
  List<Object> get props => <Object>[color];
}
