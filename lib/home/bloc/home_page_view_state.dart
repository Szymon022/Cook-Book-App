import 'package:equatable/equatable.dart';

import '../../recipe/recipe.dart';

class HomePageViewState extends Equatable {
  const HomePageViewState(List<Recipe> recipes) : _recipes = recipes;

  final List<Recipe>? _recipes;

  @override
  List<Object?> get props => [_recipes];
}
