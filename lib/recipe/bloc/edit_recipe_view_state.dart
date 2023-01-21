import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class EditRecipeViewState extends Equatable {}

class ShouldShowCamera extends EditRecipeViewState {
  @override
  List<Object?> get props => [];
}

class ShouldNotShowCamera extends EditRecipeViewState {
  @override
  List<Object?> get props => [];
}
