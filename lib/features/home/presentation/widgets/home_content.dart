import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/core/config/routes.dart';
import 'package:movin/features/home/domain/entities/activity.dart';
import 'package:movin/features/home/presentation/bloc/home_bloc.dart';
import 'package:movin/features/home/presentation/bloc/home_event.dart';
import 'package:movin/features/home/presentation/widgets/activity_card.dart';
import 'package:movin/features/home/presentation/widgets/activity_filter_section.dart';
import 'package:movin/features/home/presentation/widgets/activity_tab_filter.dart';
import 'package:movin/features/home/presentation/widgets/explore_header.dart';

class HomeContent extends StatefulWidget {
  final List<Activity> activities;
  final List<String> categories;

  const HomeContent({
    super.key,
    required this.activities,
    required this.categories,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedTab = "This Week";
  String selectedCategory = "All";
  String searchQuery = "";

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<HomeBloc>().add(HomeRequested());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredByCategory = widget.activities.where((a) {
      final matchCategory =
          selectedCategory == "All"
              ? true
              : a.sportName == selectedCategory;

      final matchSearch =
          a.title.toLowerCase().contains(searchQuery.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();

    final finalFiltered = _applyTabFilter(filteredByCategory, selectedTab);


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: const ExploreHeader(),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // const SizedBox(height: 12),

              // _SearchBar(
              //   onChanged: (value) {
              //     setState(() {
              //       searchQuery = value;
              //     });
              //   },
              // ),

              const SizedBox(height: 8),

              ActivityFilterSection(
                categories: widget.categories,
                selected: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              ActivityTabFilter(
                selected: selectedTab,
                onChanged: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                  context.read<HomeBloc>().add(HomeTabChanged(value));
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: finalFiltered.isEmpty
              ? _EmptyState(tab: selectedTab)
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: finalFiltered.length,
                  itemBuilder: (context, index) {
                    return ActivityCard(
                      activity: finalFiltered[index],
                      onJoin:(){
                        Navigator.pushNamed(
                          context, 
                          AppRoutes.activityDetail,
                          arguments: finalFiltered[index],
                        );
                      }
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search activities...",
          prefixIcon: const Icon(Icons.search, color: Colors.blue),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          filled: true,
          fillColor: const Color.fromARGB(255, 173, 173, 173),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
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
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return activities.where((a) {
      return a.activityDate.isAfter(
              startOfWeek.subtract(const Duration(seconds: 1))) &&
          a.activityDate.isBefore(
              endOfWeek.add(const Duration(days: 1)));
    }).toList();
  }

  return activities;
}

class _EmptyState extends StatelessWidget {
  final String tab;

  const _EmptyState({required this.tab});

  @override
  Widget build(BuildContext context) {
    String message;

    switch (tab) {
      case "This Week":
        message = "Tidak ada daftar agenda minggu ini";
        break;
      case "Upcoming":
        message = "Tidak ada daftar agenda mendatang";
        break;
      case "Finished":
        message = "Belum ada agenda yang selesai";
        break;
      default:
        message = "Belum ada data tersedia";
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.event_busy_outlined,
            size: 60,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}


