import 'package:dio/dio.dart';

class ActivityRemoteDataSource {
  final Dio dio;

  ActivityRemoteDataSource(this.dio);

  Future<void> joinActivity(int activityId) async {
    await dio.post(
      "/sport-activities/$activityId",
    );
  }
}