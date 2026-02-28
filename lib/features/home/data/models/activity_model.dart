import '../../domain/entities/activity.dart';

class ActivityModel extends Activity {
  ActivityModel({
    required super.id,
    required super.title,
    required super.address,
    required super.activityDate,
    required super.startTime,
    required super.endTime,
    required super.sportName,
    required super.cityName,
    required super.slot,
    required super.joinedCount,
    required super.isFull,
    required super.price,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    final participants = json['participants'] as List? ?? [];

    final slot = json['slot'] ?? 0;
    final joined = participants.length;

    final sportCategory = json['sport_category'];

    final sportName =
        sportCategory != null && sportCategory['name'] != null
            ? sportCategory['name']
            : '';

    return ActivityModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      activityDate: DateTime.tryParse(json['activity_date'] ?? '') ?? DateTime.now(),
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      sportName: sportName,
      cityName: json['city']?['city_name'] ?? '-',
      slot: slot,
      joinedCount: joined,
      isFull: joined >= slot,
      price: json['price'] ?? 0,
    );
  }


  Activity toEntity() {
    return Activity(
      id: id,
      title: title,
      address: address,
      activityDate: activityDate,
      startTime: startTime,
      endTime: endTime,
      sportName: sportName,
      cityName: cityName,
      slot: slot,
      joinedCount: joinedCount,
      isFull: isFull,
      price: price,
    );
  }
}
