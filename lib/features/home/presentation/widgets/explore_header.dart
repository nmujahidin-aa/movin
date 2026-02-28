import 'package:flutter/material.dart';
import 'package:movin/core/utils/greeting.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(greetingByTime(DateTime.now()), 
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1565C0),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "Book your next game",
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
        Row(
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.notifications_none,
            //       color: Color(0xFF1565C0)),
            // ),
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFE3F2FD),
              child: Icon(Icons.local_activity_sharp, color: Color(0xFF1565C0)),
            ),
          ],
        ),
      ],
    );
  }
}
