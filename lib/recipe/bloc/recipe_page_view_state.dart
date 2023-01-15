import 'package:equatable/equatable.dart';

import '../recipe.dart';

class RecipePageViewState extends Equatable {
  const RecipePageViewState(this.recipe);

  final Recipe recipe;

  String get recipeName => recipe.name;

  String get preparationTime => recipe.time;

  String get energy => recipe.energy;

  @override
  List<Object> get props => [recipe];
}
