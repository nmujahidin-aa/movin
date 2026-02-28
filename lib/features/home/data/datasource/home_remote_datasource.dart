

import 'package:dio/dio.dart';
import 'package:movin/features/home/data/models/activity_response_model.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  // Future<ActivityResponseModel> getActivities() async {
  //   final response = await dio.get('/sport-activities');

  //   return ActivityResponseModel.fromJson(response.data);
  // }

  Future<ActivityResponseModel> getActivities({required int page, required String tab,}) async {
    print("REQUEST PAGE: $page");
    final response = await dio.get(
      '/sport-activities',
      queryParameters: {
        "page": page,
        "tab": tab,
      },
    );

    return ActivityResponseModel.fromJson(response.data);
  }
}
