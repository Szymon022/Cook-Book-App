import 'dart:core';

import '../recipe.dart';

class EditRecipeViewState {
  EditRecipeViewState(Recipe? recipe)
      : _recipeName = recipe?.name,
        _recipeTime = recipe?.time,
        _energy = recipe?.energy;

  String? _recipeName;
  String? _recipeTime;
  String? _energy;
}
