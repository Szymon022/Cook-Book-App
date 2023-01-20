import 'package:bloc_test/bloc_test.dart';
import 'package:cook_book_app/recipe/bloc/edit_recipe_cubit.dart';
import 'package:cook_book_app/storage/entity/recipe.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_router_cubit.dart';
import '../../utils/stubs.dart';

void main() {
  Recipe recipe = StubRecipe();
  MockRouterCubit routerCubit = MockRouterCubit();
  MockRecipeRepository recipeRepository = MockRecipeRepository();

  blocTest('calls RouterCubit popExtra on goBack method',
      setUp: () {
        clearInteractions(routerCubit);
        clearInteractions(recipeRepository);
      },
      build: () => EditRecipeCubit(routerCubit, recipeRepository, recipe),
      act: (cubit) => cubit.goBack(),
      expect: () => [],
      verify: (_) {
        verify(() => routerCubit.popExtra()).called(1);
      });

  blocTest('calls RouterCubit popExtra on saveRecipe method',
      setUp: () {
        clearInteractions(routerCubit);
        clearInteractions(recipeRepository);
      },
      build: () => EditRecipeCubit(routerCubit, recipeRepository, recipe),
      act: (cubit) => cubit.saveRecipe(recipe),
      expect: () => [],
      verify: (_) {
        verify(() => routerCubit.popExtra()).called(1);
      });

  blocTest('calls RecipeRepository saveRecipe on saveRecipe method',
      setUp: () {
        clearInteractions(routerCubit);
        clearInteractions(recipeRepository);
      },
      build: () => EditRecipeCubit(routerCubit, recipeRepository, recipe),
      act: (cubit) => cubit.saveRecipe(recipe),
      expect: () => [],
      verify: (_) {
        verify(() => recipeRepository.saveRecipe(recipe)).called(1);
      });

  blocTest('calls RouterCubit popExtra on updateRecipe method',
      setUp: () {
        clearInteractions(routerCubit);
        clearInteractions(recipeRepository);
      },
      build: () => EditRecipeCubit(routerCubit, recipeRepository, recipe),
      act: (cubit) => cubit.updateRecipe(recipe),
      expect: () => [],
      verify: (_) {
        verify(() => routerCubit.popExtra()).called(1);
      });

  blocTest('calls RecipeRepository updateRecipe on updateRecipe method',
      setUp: () {
        clearInteractions(routerCubit);
        clearInteractions(recipeRepository);
      },
      build: () => EditRecipeCubit(routerCubit, recipeRepository, recipe),
      act: (cubit) => cubit.updateRecipe(recipe),
      expect: () => [],
      verify: (_) {
        verify(() => recipeRepository.updateRecipe(recipe.uuid, recipe))
            .called(1);
      });
}
