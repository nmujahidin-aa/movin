import 'package:movin/features/activity/domain/repository/activity_repository.dart';

class JoinActivityUseCase {
  final ActivityRepository repository;

  JoinActivityUseCase(this.repository);

  Future<void> call(int activityId) async {
    return await repository.joinActivity(activityId);
  }
}