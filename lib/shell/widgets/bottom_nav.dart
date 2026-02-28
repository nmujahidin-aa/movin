import 'package:flutter/material.dart';

class ExploreBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ExploreBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color.fromARGB(255, 231, 255, 19),
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xFF1565C0),
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Schedule",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
