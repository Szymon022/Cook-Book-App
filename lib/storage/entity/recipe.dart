import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe {
  const Recipe(this.name, this.time, this.energy);

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final String energy;
}
