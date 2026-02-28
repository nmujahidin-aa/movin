import 'package:movin/features/auth/domain/entities/auth_session.dart';

import '../repository/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<AuthSession?> call() async {
    final session = await repository.getSavedSession();
    return session;
  }
}
