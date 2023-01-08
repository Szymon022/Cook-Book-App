import 'package:equatable/equatable.dart';

import '../recipe/recipe.dart';

abstract class RouterState extends Equatable {
  const RouterState();

  @override
  List<Object?> get props => [];
}

class HomePageState extends RouterState {
  const HomePageState();

  @override
  List<Object?> get props => [];
}

class EditRecipePageState extends RouterState {
  const EditRecipePageState([this.recipe]);

  final Recipe? recipe;

  @override
  List<Object?> get props => [recipe];
}

class RecipePageState extends RouterState {
  const RecipePageState(this.recipe);

  final Recipe recipe;

  @override
  List<Object?> get props => [recipe];
}
