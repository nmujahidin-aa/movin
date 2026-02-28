import 'package:movin/features/activity/data/datasource/activity_remote_datasource.dart';
import 'package:movin/features/activity/domain/repository/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> joinActivity(int activityId) async {
    return await remoteDataSource.joinActivity(activityId);
  }
}