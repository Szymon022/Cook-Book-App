import 'dart:io';

import 'package:camera_bloc/camera_bloc.dart';
import 'package:cook_book_app/navigation/router_cubit.dart';
import 'package:cook_book_app/storage/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../storage/entity/recipe.dart';
import '../bloc/edit_recipe_cubit.dart';
import '../bloc/edit_recipe_view_state.dart';

class EditRecipePage extends StatelessWidget {
  EditRecipePage({super.key, this.recipe}) {
    _uuid = recipe?.uuid ?? const Uuid().v1();
    _recipeName = recipe?.name ?? "";
    _preparationTime = recipe?.time ?? "";
    _calories = recipe?.energy ?? "";
    _imagePath = recipe?.imagePath ?? "";
    _description = recipe?.description ?? "";
  }

  final Recipe? recipe;
  late String _uuid;
  late String _recipeName;
  late String _preparationTime;
  late String _calories;
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
              bool isImageMissing = _imagePath.isNotEmpty;
              if (!isImageMissing) {
                _showImageMissingDialog(context);
                return;
              }
              bool areFormsValid = _formKey.currentState!.validate();
              if (!areFormsValid) return;
              if (recipe != null) {
                cubit.updateRecipe(Recipe(
                  recipe!.uuid,
                  _recipeName.trim(),
                  _preparationTime.trim(),
                  _calories.trim(),
                  _imagePath,
                  _description.trim(),
                ));
              } else {
                cubit.saveRecipe(Recipe(
                  _uuid,
                  _recipeName.trim(),
                  _preparationTime.trim(),
                  _calories.trim(),
                  _imagePath,
                  _description.trim(),
                ));
              }
            },
            icon: const Icon(Icons.check),
          ),
      ],
    );
  }

  Future<void> _showImageMissingDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please provide image to the Recipe'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        );
      },
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
            const SizedBox(height: 12),
            _titleForm(),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _timeForm(),
                const SizedBox(width: 16),
                _energyForm(),
              ],
            ),
            const SizedBox(height: 12),
            _descriptionField()
          ],
        ),
      ),
    );
  }

  Widget _titleForm() {
    return TextFormField(
      onChanged: (name) {
        _recipeName = name;
        _formKey.currentState?.validate();
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Recipe name",
      ),
      initialValue: _recipeName,
      validator: (title) {
        RegExp wordsAndSpacesOnlyRegexp = RegExp(r'^[a-zA-Z\s\D]+$');
        if (title == null || !wordsAndSpacesOnlyRegexp.hasMatch(title)) {
          return 'Name must contain only words separated by spaces';
        }
        return null;
      },
    );
  }

  Widget _timeForm() {
    return Expanded(
      child: TextFormField(
        onChanged: (preparationTime) {
          _preparationTime = preparationTime;
          _formKey.currentState?.validate();
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Preparation time",
        ),
        initialValue: _preparationTime,
        validator: (time) {
          RegExp prepTimeRegex = RegExp(r'^[1-9]+[0-9]*(\s)+(min|h)$');
          if (time == null || !prepTimeRegex.hasMatch(time)) {
            return 'Number + min/h';
          }
          return null;
        },
      ),
    );
  }

  Widget _energyForm() {
    return Expanded(
      child: TextFormField(
        onChanged: (calories) {
          _calories = calories;
          _formKey.currentState?.validate();
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Calories",
        ),
        initialValue: _calories,
        validator: (energy) {
          RegExp caloriesRegex = RegExp(r'^[1-9]+[0-9]*(\s)+(kcal)$');
          if (energy == null || !caloriesRegex.hasMatch(energy)) {
            return 'Number + kcal';
          }
          return null;
        },
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
        labelText: "Description",
        alignLabelWithHint: true,
      ),
      initialValue: _description,
    );
  }
}
