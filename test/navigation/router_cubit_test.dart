import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/navigation/router_state.dart';
import 'package:cook_book_app/storage/entity/recipe.dart';

import '../utils/stub_recipe.dart';

void main() {
  Recipe recipe = StubRecipe();

  blocTest<RouterCubit, RouterState>(
    'emits [] on create',
    build: () => RouterCubit(),
    expect: () => [],
  );

  blocTest<RouterCubit, RouterState>(
    'emits [HomePageState] when navigateToHome() is called',
    build: () => RouterCubit(),
    act: (cubit) => cubit.navigateToHome(),
    expect: () => [const HomePageState()],
  );

  blocTest<RouterCubit, RouterState>(
    'emits [EditRecipePageState] when navigateToEditRecipe() is called',
    build: () => RouterCubit(),
    act: (cubit) => cubit.navigateToEditRecipe(),
    expect: () => [const EditRecipePageState()],
  );

  blocTest<RouterCubit, RouterState>(
    'emits [EditRecipePageState] with recipe when navigateToEditRecipe() is called with given recipe',
    build: () => RouterCubit(),
    act: (cubit) => cubit.navigateToEditRecipe(recipe),
    expect: () => [EditRecipePageState(recipe)],
  );

  blocTest<RouterCubit, RouterState>(
    'emits [RecipePageState] with proper recipe when navigateToRecipe() is called',
    build: () => RouterCubit(),
    act: (cubit) => cubit.navigateToRecipe(recipe),
    expect: () => [RecipePageState(recipe)],
  );

  blocTest<RouterCubit, RouterState>(
    'emits [HomePageState] when popExtra() is called',
    build: () => RouterCubit(),
    act: (cubit) => cubit.popExtra(),
    expect: () => [const HomePageState()],
  );
}
