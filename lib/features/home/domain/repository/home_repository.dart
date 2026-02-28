import 'package:movin/features/home/data/models/activity_response_model.dart';

abstract class HomeRepository {
  Future<ActivityResponseModel> getActivities(int page);
}
