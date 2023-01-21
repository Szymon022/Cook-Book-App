import 'dart:io';

import 'package:camera_bloc/camera_bloc.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../storage/entity/recipe.dart';
import '../bloc/edit_recipe_cubit.dart';
import '../bloc/edit_recipe_view_state.dart';

class EditRecipePage extends StatelessWidget {
  EditRecipePage({super.key, this.recipe}) {
    _uuid = recipe?.uuid ?? const Uuid().v1();
    _recipeName = recipe?.name ?? "";
    _preparationTime = recipe?.time ?? "";
    _energy = recipe?.energy ?? "";
    _imagePath = recipe?.imagePath ?? "";
    _description = recipe?.description ?? "";
  }

  final Recipe? recipe;
  late String _uuid;
  late String _recipeName;
  late String _preparationTime;
  late String _energy;
  late String _imagePath;
  late String _description;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RouterCubit routerCubit = context.read<RouterCubit>();
    RecipeRepository recipeRepository = RecipeRepositoryImpl();
    return BlocProvider(
      create: (context) => EditRecipeCubit(routerCubit, recipeRepository),
      child: BlocBuilder<EditRecipeCubit, EditRecipeViewState>(
        builder: (context, state) => Scaffold(
          appBar: _appBar(context, state),
          body: _content(context, state),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context, EditRecipeViewState state) {
    var cubit = context.read<EditRecipeCubit>();
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (state is ShouldNotShowCamera) {
            cubit.goBack();
          } else {
            cubit.onTakingPictureFinished();
          }
        },
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      actions: [
        if (state is ShouldNotShowCamera)
          IconButton(
            onPressed: () {
              if (recipe != null) {
                cubit.updateRecipe(Recipe(recipe!.uuid, _recipeName,
                    _preparationTime, _energy, _imagePath, _description));
              } else {
                cubit.saveRecipe(Recipe(_uuid, _recipeName, _preparationTime,
                    _energy, _imagePath, _description));
              }
            },
            icon: const Icon(Icons.check),
          ),
      ],
    );
  }

  Widget _content(BuildContext context, EditRecipeViewState state) {
    if (state is ShouldNotShowCamera) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _photoPicker(context),
            _forms(),
            const SizedBox(height: 16),
          ],
        ),
      );
    } else {
      EditRecipeCubit cubit = BlocProvider.of<EditRecipeCubit>(context);
      return CameraScreen(onTakePhoto: (file) {
        _imagePath = file.path;
        cubit.onTakingPictureFinished();
      });
    }
  }

  Widget _photoPicker(BuildContext context) {
    Widget content;
    if (_imagePath == "") {
      content = const Icon(
        Icons.camera_alt_outlined,
        color: Colors.white,
        size: 120,
      );
    } else {
      content = Image.file(
        File(_imagePath),
        fit: BoxFit.contain,
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: BlocProvider.of<EditRecipeCubit>(context).onTakingPictureStarted,
        child: Container(
          padding: const EdgeInsets.only(bottom: 16),
          width: double.infinity,
          height: 300,
          color: Colors.black,
          child: Align(
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }

  Widget _forms() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _titleForm(),
            const SizedBox(height: 8),
            Row(
              children: [
                _timeForm(),
                const SizedBox(width: 16),
                _energyForm(),
              ],
            ),
            const SizedBox(height: 8),
            _descriptionField()
          ],
        ),
      ),
    );
  }

  Widget _titleForm() {
    return TextFormField(
      onChanged: (name) => _recipeName = name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Recipe name",
      ),
      initialValue: _recipeName,
    );
  }

  Widget _timeForm() {
    return Expanded(
      child: TextFormField(
        onChanged: (preparationTime) => _preparationTime = preparationTime,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Prep time",
        ),
        initialValue: _preparationTime,
      ),
    );
  }

  Widget _energyForm() {
    return Expanded(
      child: TextFormField(
        onChanged: (energy) => _energy = energy,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Kcals",
        ),
        initialValue: _energy,
      ),
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      onChanged: (description) => _description = description,
      textInputAction: TextInputAction.newline,
      minLines: 6,
      maxLines: null,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
      initialValue: _description,
    );
  }
}
