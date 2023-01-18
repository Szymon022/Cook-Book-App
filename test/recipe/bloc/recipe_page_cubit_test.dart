import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_page_view_state.dart';
import 'package:cook_book_app/recipe/recipe.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_router_cubit.dart';

void main() {
  Recipe recipe = const Recipe('Recipe 1', '30 min', '100 kcals');
  RouterCubit routerCubit = MockRouterCubit();

  blocTest(
    'sets RecipePageViewState(recipe) as initial state',
    build: () => RecipeCubit(routerCubit, recipe),
    expect: () => [],
    verify: (cubit) {
      cubit.state == RecipePageViewState(recipe);
    },
  );

  blocTest(
    'calls RouterCubit navigateToEditRecipe on editRecipe',
    build: () => RecipeCubit(routerCubit, recipe),
    act: (cubit) => cubit.editRecipe(),
    expect: () => [],
    verify: (_) =>
        verify(() => routerCubit.navigateToEditRecipe(recipe)).called(1),
  );

  blocTest(
    'calls RouterCubit popExtra on goBack',
    build: () => RecipeCubit(routerCubit, recipe),
    act: (cubit) => cubit.goBack(),
    expect: () => [],
    verify: (_) => verify(() => routerCubit.popExtra()).called(1),
  );
}
