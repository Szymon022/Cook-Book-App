import 'package:equatable/equatable.dart';

import '../../../storage/entity/recipe.dart';

class RecipeDetailsViewState extends Equatable {
  const RecipeDetailsViewState(this.recipe);

  final Recipe recipe;

  String get uuid => recipe.uuid;

  String get recipeName => recipe.name;

  String get preparationTime => recipe.time;

  String get energy => recipe.energy;

  String get description => recipe.description;

  String get imagePath => recipe.imagePath;

  @override
  List<Object> get props => [recipe];
}
