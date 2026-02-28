import 'package:movin/features/home/domain/entities/activity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Activity> activities;
  final List<String> categories;
  HomeLoaded({
    required this.activities,
    required this.categories,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
