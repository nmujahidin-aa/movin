import 'package:flutter/material.dart';
import 'package:movin/features/home/presentation/pages/home_page.dart';
import 'package:movin/features/profile/presentation/pages/profile_page.dart';
import 'widgets/bottom_nav.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int currentIndex = 0;

  final pages = const [
    HomePage(),
    _SchedulePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: ExploreBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class _SchedulePage extends StatelessWidget {
  const _SchedulePage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Schedule Page"));
  }
}

// class _ProfilePage extends StatelessWidget {
//   const _ProfilePage();

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text("Profile Page"));
//   }
// }
