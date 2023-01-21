import 'package:cook_book_app/storage/entity/recipe.dart';

class StubRecipe extends Recipe {
  StubRecipe({
    String id = "1",
    String name = "Recipe",
    String time = "0 min",
    String energy = "00 kcal",
    String imageUrl = "file/image/",
    String description = "Description",
  }) : super(id, name + id, id + time, id + energy, imageUrl + id,
            description + id);
}
