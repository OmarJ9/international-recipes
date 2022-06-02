import 'package:flutter/material.dart';
import 'package:international_recipes/src/models/recipe_model.dart';
import 'package:international_recipes/src/screens/detailed_screen.dart';
import 'package:international_recipes/src/screens/homescreen.dart';
import 'package:international_recipes/src/screens/savedscreen.dart';
import 'package:international_recipes/src/screens/webpage_screen.dart';
import 'constants/strings.dart';

class AppRoute {
  AppRoute();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homescreen:
        {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      case detailedscreen:
        final recipe = settings.arguments as Recipe;
        {
          return MaterialPageRoute(
              builder: (_) => DetailedScreen(
                    recipe: recipe,
                  ));
        }
      case webscreen:
        final website = settings.arguments as String;
        {
          return MaterialPageRoute(
              builder: (_) => WebPageScreen(website: website));
        }
      case savedscreen:
        {
          return MaterialPageRoute(builder: (_) => const SavedScreen());
        }

      default:
        throw 'No Page Found!!';
    }
  }
}
