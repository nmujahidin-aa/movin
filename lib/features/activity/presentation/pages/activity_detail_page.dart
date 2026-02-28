import 'package:flutter/material.dart';
import 'package:movin/features/home/domain/entities/activity.dart';

import 'package:intl/intl.dart';

class ActivityDetailPage extends StatelessWidget {
  final Activity activity;

  const ActivityDetailPage({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('EEE, MMM dd yyyy').format(activity.activityDate);

    final formattedStart =
        DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(activity.startTime));

    final formattedEnd =
        DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(activity.endTime));

    final remaining = activity.slot - activity.joinedCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Column(
          children: [
            /// ===== CONTENT =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE
                    Text(
                      activity.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// INFO CARD
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE7F3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [

                          /// LOCATION
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  activity.cityName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// DATE
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  size: 18, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(formattedDate),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// TIME
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 18, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text("$formattedStart - $formattedEnd"),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// SLOT
                          Row(
                            children: [
                              const Icon(Icons.group,
                                  size: 18, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text("$remaining Slots Available"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// PESERTA SECTION
                    const Text(
                      "Peserta",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE7F3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          "Belum ada participants",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ===== BOTTOM BUTTON =====
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // TODO: join activity
                  },
                  child: Text(
                    "RP. ${activity.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}