import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/recipe/bloc/edit_recipe_cubit.dart';
import 'package:cook_book_app/storage/entity/recipe.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_router_cubit.dart';

void main() {
  Recipe recipe = const Recipe('Recipe 1', '10 min', '300 kcals');
  MockRouterCubit routerCubit = MockRouterCubit();

  blocTest('calls RouterCubit popExtra on goBack method',
      build: () => EditRecipeCubit(routerCubit, recipe),
      act: (cubit) => cubit.goBack(),
      expect: () => [],
      verify: (_) {
        verify(() => routerCubit.popExtra()).called(1);
      });

  blocTest('calls RouterCubit popExtra on saveRecipe method',
      build: () => EditRecipeCubit(routerCubit, recipe),
      act: (cubit) => cubit.saveRecipe(recipe),
      expect: () => [],
      verify: (_) {
        verify(() => routerCubit.popExtra()).called(1);
      });
}
