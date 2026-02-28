import 'package:movin/features/home/data/models/activity_response_model.dart';
import '../repository/home_repository.dart';

class GetActivitiesUseCase {
  final HomeRepository repository;

  GetActivitiesUseCase(this.repository);

  Future<ActivityResponseModel> call(int page) {
    return repository.getActivities(page);
  }
}
