import 'package:movin/features/home/data/models/activity_model.dart';

class ActivityResponseModel {
  final int currentPage;
  final List<ActivityModel> activities;

  ActivityResponseModel({
    required this.currentPage,
    required this.activities,
  });

  factory ActivityResponseModel.fromJson(
      Map<String, dynamic> json) {
    final result = json['result'];

    final data = result['data'] as List ? ?? [];

    return ActivityResponseModel(
      currentPage: result['current_page'],
      activities: data
          .map((e) => ActivityModel.fromJson(e))
          .toList(),
    );
  }
}
