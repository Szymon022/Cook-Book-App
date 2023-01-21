import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe {
  const Recipe(this.uuid, this.name, this.time, this.energy, this.imagePath,
      this.description);

  @HiveField(3)
  final String uuid;

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final String energy;

  @HiveField(4)
  final String imagePath;

  @HiveField(5)
  final String description;
}
