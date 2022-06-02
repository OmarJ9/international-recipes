import 'package:hive/hive.dart';
import 'package:international_recipes/src/constants/consts_variables.dart';
import 'package:international_recipes/src/models/recipe_model.dart';

class HiveHelper {
  static Future<void> saverecipe(Recipe recipe) async {
    Box<Recipe> mybox = Hive.box('savedrecipe');
    mybox.add(recipe);
    savedrecipes = getsavedrecipes();
  }

  static List<Recipe> getsavedrecipes() {
    Box<Recipe> mybox = Hive.box('savedrecipe');
    return mybox.values.toList();
  }

  static void deleterecipe(Recipe recipe) async {
    Box<Recipe> mybox = Hive.box('savedrecipe');
    final recipeToDelete = mybox.values.firstWhere(
        (element) => element.name.toLowerCase() == recipe.name.toLowerCase());
    await recipeToDelete.delete();
    savedrecipes = getsavedrecipes();
  }

  static deleteallrecipes() async {
    Box<Recipe> mybox = Hive.box('savedrecipe');
    savedrecipes = [];
    for (var element in allrecipes) {
      element.saved = false;
    }
    await mybox.clear();
  }
}
