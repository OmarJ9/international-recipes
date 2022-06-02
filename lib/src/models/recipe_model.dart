import 'package:hive/hive.dart';
part 'recipe_model.g.dart';

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double rate;
  @HiveField(3)
  final int min;
  @HiveField(4)
  final int cal;
  @HiveField(5)
  final String difficulty;
  @HiveField(6)
  final List<Ingredients> ingredients;
  @HiveField(7)
  final List<dynamic> steps;
  @HiveField(8)
  final String img;
  @HiveField(9)
  final String originalwebsite;
  @HiveField(10)
  bool saved = false;

  Recipe(
      {required this.name,
      required this.rate,
      required this.min,
      required this.cal,
      required this.difficulty,
      required this.ingredients,
      required this.steps,
      required this.img,
      required this.originalwebsite});

  factory Recipe.fromjson(Map<String, dynamic> json) {
    var ingdata = json["ingredients"] as List;
    List<Ingredients> myingredients =
        ingdata.map((i) => Ingredients.fromjson(i)).toList();
    return Recipe(
      name: json["name"],
      rate: json["rate"],
      min: json["min"],
      cal: json["cal"],
      difficulty: json["difficulty"],
      ingredients: myingredients,
      steps: json["steps"],
      img: json["img"],
      originalwebsite: json["original_website"],
    );
  }
}

@HiveType(typeId: 1)
class Ingredients extends HiveObject {
  @HiveField(0)
  final String quantity;
  @HiveField(1)
  final String name;
  Ingredients({
    required this.quantity,
    required this.name,
  });

  factory Ingredients.fromjson(Map<String, dynamic> json) {
    return Ingredients(
      quantity: json["quantity"],
      name: json["name"],
    );
  }
}
