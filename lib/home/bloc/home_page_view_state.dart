import 'package:equatable/equatable.dart';

import '../../storage/entity/recipe.dart';

class HomePageViewState extends Equatable {
  const HomePageViewState(this.recipes);

  final List<Recipe> recipes;

  @override
  List<Object?> get props => [recipes];
}
