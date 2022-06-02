part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class LoadAmericanRecipeEvent extends AppEvent {}

class LoadMoroccanRecipeEvent extends AppEvent {}

class LoadKoreanRecipeEvent extends AppEvent {}

class LoadFrenchRecipeEvent extends AppEvent {}

class ModifyDataBaseEvent extends AppEvent {}
