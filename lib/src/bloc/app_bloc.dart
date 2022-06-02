import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:international_recipes/src/constants/consts_variables.dart';
import 'package:international_recipes/src/database/hive.dart';
import 'package:international_recipes/src/models/recipe_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    // Load American Food Json File
    on<LoadAmericanRecipeEvent>((event, emit) async {
      try {
        emit(LoadingState());
        print('app started');
        final response =
            await rootBundle.loadString('assets/json/american_food.json');

        final data = jsonDecode(response) as List;
        List<Recipe> myrecipe = data.map((e) => Recipe.fromjson(e)).toList();
        americanecipes = myrecipe;
        allrecipes = allrecipes + myrecipe;

        emit(LoadedState());
      } catch (e) {
        debugPrint(e.toString());
        emit(const ErrorState(error: 'Something Wrong Happend!'));
      }
    });

    // Load Moroccan Food Json File
    on<LoadMoroccanRecipeEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final response =
            await rootBundle.loadString('assets/json/moroccan_food.json');

        final data = jsonDecode(response) as List;
        List<Recipe> myrecipe = data.map((e) => Recipe.fromjson(e)).toList();
        moroccanrecipes = myrecipe;
        allrecipes = allrecipes + myrecipe;

        emit(LoadedState());
      } catch (e) {
        debugPrint(e.toString());
        emit(const ErrorState(error: 'Something Wrong Happend!'));
      }
    });

    // Load Korean Food Json File
    on<LoadKoreanRecipeEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final response =
            await rootBundle.loadString('assets/json/korean_food.json');

        final data = jsonDecode(response) as List;
        List<Recipe> myrecipe = data.map((e) => Recipe.fromjson(e)).toList();
        koreanrecipes = myrecipe;
        allrecipes = allrecipes + myrecipe;

        emit(LoadedState());
      } catch (e) {
        debugPrint(e.toString());
        emit(const ErrorState(error: 'Something Wrong Happend!'));
      }
    });

    // Load French Food Json File
    on<LoadFrenchRecipeEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final response =
            await rootBundle.loadString('assets/json/french_food.json');

        final data = jsonDecode(response) as List;
        List<Recipe> myrecipe = data.map((e) => Recipe.fromjson(e)).toList();
        frenchrecipes = myrecipe;
        allrecipes = allrecipes + myrecipe;
        savedrecipes = HiveHelper.getsavedrecipes();

        // I us this algo to update the saved proprty in allrecipes list.
        // this is the worst algo you can use because it is N2.
        // but it is the only one I can think of right now.
        for (var element in allrecipes) {
          for (var savedelement in savedrecipes) {
            if (element.name.toLowerCase() == savedelement.name.toLowerCase()) {
              allrecipes[allrecipes.indexOf(element)] = savedelement;
            }
          }
        }

        emit(LoadedState());
      } catch (e) {
        debugPrint(e.toString());
        emit(const ErrorState(error: 'Something Wrong Happend!'));
      }
    });
    on<ModifyDataBaseEvent>(
      (event, emit) {
        emit(LoadingState());
        emit(ModifyDataBaseState());
      },
    );
  }
}
