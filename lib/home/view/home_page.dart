import 'dart:io';

import 'package:cook_book_app/home/bloc/home_page_cubit.dart';
import 'package:cook_book_app/home/view/debouncer.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/entity/recipe.dart';
import '../bloc/home_page_view_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RouterCubit routerCubit = context.read<RouterCubit>();
    final RecipeRepository recipeRepository = RecipeRepositoryImpl();
    var shouldReloadRecipesList = true;
    return BlocProvider(
      create: (context) => HomePageCubit(routerCubit, recipeRepository),
      child: BlocBuilder<HomePageCubit, HomePageViewState>(
        builder: (context, state) {
          // I guess this is really bad approach because of poor navigation handling
          if (shouldReloadRecipesList) {
            BlocProvider.of<HomePageCubit>(context).loadRecipes();
            shouldReloadRecipesList = !shouldReloadRecipesList;
          }
          return Scaffold(
            appBar: _homeAppBar(context),
            body: Column(
                children: [Expanded(child: _homeContent(state.recipes))]),
            floatingActionButton: FloatingActionButton(
              onPressed:
                  BlocProvider.of<HomePageCubit>(context).createNewRecipe,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  AppBar _homeAppBar(BuildContext context) {
    Debouncer searchBarDebouncer = Debouncer(milliseconds: 300);
    HomePageCubit cubit = BlocProvider.of<HomePageCubit>(context);
    return AppBar(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  searchBarDebouncer.run(() => cubit.loadRecipes(query));
                },
                autocorrect: false,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => cubit.surpriseMe(),
          child: const Text('Random', style: TextStyle(color: Colors.white)),
          // icon: const Icon(Icons.restaurant),
        ),
      ],
    );
  }

  Widget _homeContent(List<Recipe> recipes) {
    return ListView.builder(
      itemCount: recipes.length + 1,
      itemBuilder: (context, index) {
        if (index == recipes.length) {
          return const SizedBox(height: 80);
        } else {
          Recipe recipe = recipes[index];
          return _RecipeItem(
            recipe: recipe,
            onRecipeTap: (recipe) =>
                context.read<HomePageCubit>().goToRecipe(recipe),
          );
        }
      },
    );
  }
}

class _RecipeItem extends StatelessWidget {
  const _RecipeItem({required this.recipe, required this.onRecipeTap});

  final Recipe recipe;
  final void Function(Recipe recipe) onRecipeTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onRecipeTap(recipe),
      child: Center(
        child: Card(
          elevation: 4,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: _recipePhoto(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: _recipeHeader(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recipePhoto() {
    return Image.file(
      File(recipe.imagePath),
      height: 300,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }

  Widget _recipeHeader() {
    return Column(
      children: [
        _title(recipe.name),
        const SizedBox(height: 8),
        _prepTimeAndCaloriesRow(recipe.time, recipe.energy),
      ],
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
    );
  }

  Widget _prepTimeAndCaloriesRow(String prepTime, String calories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Cooking time: $prepTime',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 16),
        Text(
          'Calories: $calories',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
