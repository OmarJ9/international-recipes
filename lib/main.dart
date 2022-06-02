import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:international_recipes/src/bloc/app_bloc.dart';
import 'package:international_recipes/src/constants/colors.dart';
import 'package:international_recipes/src/models/recipe_model.dart';
import 'package:international_recipes/src/route.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(IngredientsAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Recipe>('savedrecipe');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => BlocProvider(
        create: (context) => AppBloc()
          ..add(LoadAmericanRecipeEvent())
          ..add(LoadMoroccanRecipeEvent())
          ..add(LoadKoreanRecipeEvent())
          ..add(LoadFrenchRecipeEvent()),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                headline1: GoogleFonts.lato(
                    color: MyColors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800),
                subtitle1: GoogleFonts.lato(
                    color: MyColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300),
              )),
          onGenerateRoute: AppRoute().generateRoute,
          initialRoute: '/',
        ),
      ),
    );
  }
}
