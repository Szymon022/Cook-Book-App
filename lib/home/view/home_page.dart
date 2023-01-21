import 'dart:io';

import 'package:cook_book_app/home/bloc/home_page_cubit.dart';
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
    return BlocProvider(
      create: (context) => HomePageCubit(routerCubit, recipeRepository),
      child: BlocBuilder<HomePageCubit, HomePageViewState>(
        builder: (context, state) {
          // I guess this is really bad, but cannot find another way to load new recipes
          BlocProvider.of<HomePageCubit>(context).loadRecipes();
          return Scaffold(
            appBar: _homeAppBar(),
            body: Column(
              children: [
                _homeContent(state.recipes),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.read<HomePageCubit>().createNewRecipe(),
            ),
          );
        },
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar();
  }

  Widget _homeContent(List<Recipe> recipes) {
    return Expanded(
      child: ListView.builder(
        itemCount: recipes.length + 1,
        itemBuilder: (context, index) {
          if (index == recipes.length) {
            return const SizedBox(height: 80);
          } else {
            Recipe recipe = recipes[index];
            return _RecipeItem(
              recipe: recipe,
              onRecipeTap: () =>
                  context.read<HomePageCubit>().goToRecipe(recipe),
            );
          }
        },
      ),
    );
  }
}

class _RecipeItem extends StatelessWidget {
  const _RecipeItem({required this.recipe, required this.onRecipeTap});

  final Recipe recipe;
  final void Function() onRecipeTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRecipeTap,
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
        _recipeTitleRow(),
        const SizedBox(height: 4),
        _recipeTagsRow(),
      ],
    );
  }

  Widget _recipeTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _recipeTitle(recipe.name),
        _timeIndicator(recipe.time),
      ],
    );
  }

  Widget _recipeTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
    );
  }

  Widget _timeIndicator(String time) {
    return Row(
      children: [
        const Icon(Icons.timer),
        const SizedBox(width: 4),
        Text(time),
      ],
    );
  }

  Widget _recipeTagsRow() {
    return Row(
      children: const [
        Text('Dinner'),
        SizedBox(width: 4),
        Text('Lunch'),
      ],
    );
  }
}
