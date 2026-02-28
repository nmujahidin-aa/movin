import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/features/home/domain/entities/activity.dart';
import '../../domain/usecase/get_activities_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetActivitiesUseCase getActivities;
  bool _isFetching = false;

  int _currentPage = 1;
  bool _hasReachedMax = false;
  String _selectedTab = "This Week";

  final List<Activity> _allActivities = [];

  HomeBloc(this.getActivities) : super(HomeInitial()) {
    on<HomeRequested>(_onRequested);
    on<HomeTabChanged>(_onTabChanged);
  }

  Future<void> _onRequested(
    HomeRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (_hasReachedMax || _isFetching) return;

    _isFetching = true;

    final response = await getActivities(_currentPage);
    final newActivities = response.activities;

    if (newActivities.isEmpty) {
      _hasReachedMax = true;
    } else {
      _currentPage++;
      _allActivities.addAll(newActivities);
    }

    final filtered =
        _applyTabFilter(_allActivities, _selectedTab);

    emit(HomeLoaded(
      activities: filtered,
      categories: _buildCategories(_allActivities),
    ));

    _isFetching = false;
  }

  Future<void> _onTabChanged(
    HomeTabChanged event,
    Emitter<HomeState> emit,
  ) async {
    _selectedTab = event.tab;

    final filtered =
        _applyTabFilter(_allActivities, _selectedTab);

    if (filtered.isEmpty && !_hasReachedMax) {
      add(HomeRequested());
    } else {
      emit(HomeLoaded(
        activities: filtered,
        categories: _buildCategories(_allActivities),
      ));
    }
  }

  List<String> _buildCategories(
      List<Activity> activities) {
    return {
      "All",
      ...activities
          .map((e) => e.sportName ?? "")
          .where((e) => e.isNotEmpty),
    }.toList();
  }

  List<Activity> _applyTabFilter(
      List<Activity> activities,
      String selectedTab,
  ) {
    final now = DateTime.now();

    if (selectedTab == "Finished") {
      return activities
          .where((a) => a.activityDate.isBefore(now))
          .toList();
    }

    if (selectedTab == "Upcoming") {
      return activities
          .where((a) => a.activityDate.isAfter(now))
          .toList();
    }

    if (selectedTab == "This Week") {
      final startOfWeek =
          now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek =
          startOfWeek.add(const Duration(days: 6));

      return activities.where((a) {
        return a.activityDate.isAfter(
                startOfWeek.subtract(
                    const Duration(seconds: 1))) &&
            a.activityDate.isBefore(
                endOfWeek.add(
                    const Duration(days: 1)));
      }).toList();
    }

    return activities;
  }
}