abstract class HomeEvent {}

class HomeRequested extends HomeEvent {}

class HomeSearchChanged extends HomeEvent {
  final String query;
  HomeSearchChanged(this.query);
}

class HomeCategoryChanged extends HomeEvent {
  final String category;
  HomeCategoryChanged(this.category);
}

class HomeTabChanged extends HomeEvent {
  final String tab;
  HomeTabChanged(this.tab);
}

class HomeRefreshed extends HomeEvent {}
