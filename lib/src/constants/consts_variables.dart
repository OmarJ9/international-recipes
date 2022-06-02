import 'package:flutter/material.dart';
import 'package:international_recipes/src/constants/assets_path.dart';
import 'package:sizer/sizer.dart';

import '../models/recipe_model.dart';

List<Tab> mytabs = [
  Tab(
    height: 70,
    text: 'All',
    icon: Image.asset(
      MyAssets.global,
      height: 6.h,
      fit: BoxFit.fitWidth,
    ),
  ),
  Tab(
    height: 70,
    text: 'America',
    icon: Image.asset(
      MyAssets.america,
      height: 6.h,
      fit: BoxFit.fitWidth,
    ),
  ),
  Tab(
    height: 70,
    text: 'Morocco',
    icon: Image.asset(
      MyAssets.morocco,
      height: 6.h,
      fit: BoxFit.fitWidth,
    ),
  ),
  Tab(
    height: 70,
    text: 'Korean',
    icon: Image.asset(
      MyAssets.southKorea,
      height: 6.h,
      fit: BoxFit.fitWidth,
    ),
  ),
  Tab(
    height: 70,
    text: 'France',
    icon: Image.asset(
      MyAssets.france,
      height: 6.h,
      fit: BoxFit.fitWidth,
    ),
  ),
];

List<Recipe> allrecipes = [];
List<Recipe> americanecipes = [];
List<Recipe> moroccanrecipes = [];
List<Recipe> koreanrecipes = [];
List<Recipe> frenchrecipes = [];
bool isfiltered = false;
List<Recipe> savedrecipes = [];
