import 'dart:io';

import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_cubit.dart';
import 'package:cook_book_app/recipe/bloc/recipe_page_view_state.dart';
import 'package:cook_book_app/storage/files/file_eradicator.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/entity/recipe.dart';

enum RecipeAction { edit, delete }

class RecipePage extends StatelessWidget {
  const RecipePage(this.recipe, {Key? key}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    RouterCubit routerCubit = context.read<RouterCubit>();
    RecipeRepository recipeRepository = RecipeRepositoryImpl();
    FileEradicator eradicator = FileEradicatorImpl();
    return BlocProvider(
      create: (context) =>
          RecipeCubit(routerCubit, recipeRepository, eradicator, recipe),
      child: BlocBuilder<RecipeCubit, RecipePageViewState>(
        builder: (context, state) => Scaffold(
          appBar: _appBar(context),
          body: _content(state),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    var cubit = BlocProvider.of<RecipeCubit>(context);
    return AppBar(
      leading: IconButton(
        onPressed: cubit.goBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (_) {
            return const [
              PopupMenuItem<RecipeAction>(
                value: RecipeAction.edit,
                child: Text('Edit recipe'),
              ),
              PopupMenuItem<RecipeAction>(
                value: RecipeAction.delete,
                child: Text('Delete recipe'),
              ),
            ];
          },
          onSelected: (value) {
            if (value == RecipeAction.edit) {
              cubit.editRecipe();
            } else if (value == RecipeAction.delete) {
              _deleteRecipeDialog(context);
            }
          },
        )
      ],
    );
  }

  Future<void> _deleteRecipeDialog(BuildContext context) async {
    RecipeCubit cubit = BlocProvider.of<RecipeCubit>(context);
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Remove recipe'),
            content: const Text('Are you sure you want to delete this recipe?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  cubit.deleteRecipe();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  Widget _content(RecipePageViewState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipePhoto(),
          _recipeInformation(state),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _recipePhoto() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: Image.file(
          File(recipe.imagePath),
          height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _recipeInformation(RecipePageViewState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            state.recipeName,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 36),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.preparationTime, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              Text(state.energy, style: const TextStyle(fontSize: 24))
            ],
          ),
        ],
      ),
    );
  }
}
