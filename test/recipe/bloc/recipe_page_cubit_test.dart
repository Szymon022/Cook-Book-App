import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_page_view_state.dart';
import 'package:cook_book_app/storage/entity/recipe.dart';
import 'package:cook_book_app/storage/files/file_eradicator.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mocks.dart';
import '../../utils/stub_recipe.dart';

void main() {
  Recipe recipe = StubRecipe();
  RouterCubit routerCubit = MockRouterCubit();
  RecipeRepository recipeRepository = MockRecipeRepository();
  FileEradicator fileEradicator = MockFileEradicator();

  blocTest(
    'sets RecipePageViewState(recipe) as initial state',
    setUp: () {
      clearInteractions(routerCubit);
      clearInteractions(recipeRepository);
      clearInteractions(fileEradicator);
    },
    build: () =>
        RecipeCubit(routerCubit, recipeRepository, fileEradicator, recipe),
    expect: () => [],
    verify: (cubit) {
      cubit.state == RecipePageViewState(recipe);
    },
  );

  blocTest(
    'calls RouterCubit navigateToEditRecipe on editRecipe',
    setUp: () {
      clearInteractions(routerCubit);
      clearInteractions(recipeRepository);
      clearInteractions(fileEradicator);
    },
    build: () =>
        RecipeCubit(routerCubit, recipeRepository, fileEradicator, recipe),
    act: (cubit) => cubit.editRecipe(),
    expect: () => [],
    verify: (_) =>
        verify(() => routerCubit.navigateToEditRecipe(recipe)).called(1),
  );

  blocTest(
    'calls RouterCubit popExtra on goBack',
    setUp: () {
      clearInteractions(routerCubit);
      clearInteractions(recipeRepository);
      clearInteractions(fileEradicator);
    },
    build: () =>
        RecipeCubit(routerCubit, recipeRepository, fileEradicator, recipe),
    act: (cubit) => cubit.goBack(),
    expect: () => [],
    verify: (_) => verify(() => routerCubit.popExtra()).called(1),
  );

  blocTest(
    'calls RecipeRepository deleteRecipe(uuid) method on deleteRecipe',
    setUp: () {
      clearInteractions(routerCubit);
      clearInteractions(recipeRepository);
      clearInteractions(fileEradicator);
    },
    build: () =>
        RecipeCubit(routerCubit, recipeRepository, fileEradicator, recipe),
    act: (cubit) => cubit.deleteRecipe(),
    expect: () => [],
    verify: (_) =>
        verify(() => recipeRepository.deleteRecipe(recipe.uuid)).called(1),
  );

  blocTest(
    'calls RouterCubit popExtra on deleteRecipe',
    setUp: () {
      clearInteractions(routerCubit);
      clearInteractions(recipeRepository);
      clearInteractions(fileEradicator);
    },
    build: () =>
        RecipeCubit(routerCubit, recipeRepository, fileEradicator, recipe),
    act: (cubit) => cubit.deleteRecipe(),
    expect: () => [],
    verify: (_) => verify(() => routerCubit.popExtra()).called(1),
  );

  blocTest(
    'calls FileEradicator eradicator on deleteRecipe',
    setUp: () {
      clearInteractions(routerCubit);
      clearInteractions(recipeRepository);
      clearInteractions(fileEradicator);
    },
    build: () =>
        RecipeCubit(routerCubit, recipeRepository, fileEradicator, recipe),
    act: (cubit) => cubit.deleteRecipe(),
    expect: () => [],
    verify: (_) =>
        verify(() => fileEradicator.eradicate(recipe.imagePath)).called(1),
  );
}
