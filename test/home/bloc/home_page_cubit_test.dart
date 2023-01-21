import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/home/bloc/home_page_cubit.dart';
import 'package:cook_book_app/home/bloc/home_page_view_state.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/entity/recipe.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mocks.dart';
import '../../utils/stub_recipe.dart';

void main() {
  RouterCubit routerCubit = MockRouterCubit();
  RecipeRepository recipeRepository = MockRecipeRepository();
  List<Recipe> recipes = [
    StubRecipe(id: "1"),
    StubRecipe(id: "2"),
    StubRecipe(id: "3")
  ];
  when(() => recipeRepository.getAllRecipes()).thenAnswer((_) => recipes);

  blocTest(
    'calls RouterCubit navigateToRecipe on goToRecipe',
    setUp: () => clearInteractions(recipeRepository),
    build: () => HomePageCubit(routerCubit, recipeRepository),
    act: (cubit) => cubit.goToRecipe(recipes[0]),
    expect: () => [],
    verify: (_) =>
        verify(() => routerCubit.navigateToRecipe(recipes[0])).called(1),
  );

  blocTest(
    'calls RouterCubit navigateToEditRecipe on createNewRecipe',
    setUp: () => clearInteractions(recipeRepository),
    build: () => HomePageCubit(routerCubit, recipeRepository),
    act: (cubit) => cubit.createNewRecipe(),
    expect: () => [],
    verify: (_) => verify(() => routerCubit.navigateToEditRecipe()).called(1),
  );

  blocTest(
    'calls RouterCubit navigateToEditRecipe on editRecipe',
    setUp: () => clearInteractions(recipeRepository),
    build: () => HomePageCubit(routerCubit, recipeRepository),
    act: (cubit) => cubit.editRecipe(recipes[0]),
    expect: () => [],
    verify: (_) =>
        verify(() => routerCubit.navigateToEditRecipe(recipes[0])).called(1),
  );

  blocTest(
    'sets HomePageViewState([]) as initial state when no recipes available',
    setUp: () {
      clearInteractions(recipeRepository);
      when(() => recipeRepository.getAllRecipes()).thenAnswer((_) => []);
    },
    build: () => HomePageCubit(routerCubit, recipeRepository),
    expect: () => [],
    verify: (cubit) => {cubit.state == const HomePageViewState([])},
  );

  blocTest(
    'sets HomePageViewState(List<Recipe>) as initial state when recipes available',
    setUp: () {
      clearInteractions(recipeRepository);
      when(() => recipeRepository.getAllRecipes()).thenAnswer((_) => recipes);
    },
    build: () => HomePageCubit(routerCubit, recipeRepository),
    expect: () => [],
    verify: (cubit) => {cubit.state == HomePageViewState(recipes)},
  );

  blocTest(
    'calls RecipeRepository::getAllRecipes on init',
    setUp: () => clearInteractions(recipeRepository),
    build: () => HomePageCubit(routerCubit, recipeRepository),
    expect: () => [],
    verify: (cubit) {
      verify(() => recipeRepository.getAllRecipes()).called(1);
    },
  );
}
