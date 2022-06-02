part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class LoadingState extends AppState {}

class LoadedState extends AppState {}

class ErrorState extends AppState {
  final String error;
  const ErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class ModifyDataBaseState extends AppState {}
