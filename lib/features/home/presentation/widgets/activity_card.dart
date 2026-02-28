import 'package:flutter/material.dart';
import '../../domain/entities/activity.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onJoin;

  const ActivityCard({
    super.key,
    required this.activity,
    this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = activity.slot - activity.joinedCount;
    final formattedDate = DateFormat('EEE, MMM d yyyy').format(activity.activityDate);
    final formattedStart = DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(activity.startTime));
    final formattedEnd = DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(activity.endTime));

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          const SizedBox(height: 6),

          Text(
            "${activity.sportName}",
            style: const TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.blue,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "${activity.cityName}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.blue,
              ),
              const SizedBox(width: 6),
              Text(
                "$formattedDate • $formattedStart - $formattedEnd",
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(
                Icons.money,
                size: 14,
                color: Colors.blue,
              ),
              const SizedBox(width: 6),
              Text(
                "Rp. ${activity.price}",
                style: const TextStyle(
                  color: Color(0xFF1565C0),
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                activity.isFull
                    ? "FULL"
                    : "$remaining spots left",
                style: TextStyle(
                  color: activity.isFull
                      ? Colors.red
                      : const Color(0xFF1565C0),
                  fontWeight: FontWeight.w600,
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: activity.isFull ? null : onJoin,
                child: const Text(
                  "Join",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
