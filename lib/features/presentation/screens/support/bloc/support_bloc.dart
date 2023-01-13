import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:safe_access/features/presentation/screens/support/bloc/support_event.dart';
import 'package:safe_access/features/presentation/screens/support/bloc/support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportInitial()) {
    on<ColorChange>(
      (ColorChange event, Emitter<SupportState> emit) {
        emit(ColorChanged(color: _color));
      },
    );
    on<ColorChangeTwo>(
      (ColorChangeTwo event, Emitter<SupportState> emit) {
        emit(ColorChanged(color: event.color));
      },
    );
  }

  Color get _color => Colors.deepPurpleAccent;
}
