class Activity {
  final int id;
  final String title;
  final String address;
  final DateTime activityDate;
  final String startTime;
  final String endTime;
  final String sportName;
  final String cityName;
  final int slot;
  final int joinedCount;
  final bool isFull;
  final int price;

  const Activity({
    required this.id,
    required this.title,
    required this.address,
    required this.activityDate,
    required this.startTime,
    required this.endTime,
    required this.sportName,
    required this.cityName,
    required this.slot,
    required this.joinedCount,
    required this.isFull,
    required this.price,
  });
}
