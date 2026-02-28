import 'package:movin/features/home/data/models/activity_response_model.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<ActivityResponseModel> getActivities(int page) {
    return remote.getActivities(page: page, tab: 'This Week');
  }
}
