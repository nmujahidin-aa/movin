import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movin/core/network/dio_client.dart';
import 'package:movin/features/activity/data/datasource/activity_remote_datasource.dart';
import 'package:movin/features/activity/data/repositories/activity_repository_impl.dart';
import 'package:movin/features/activity/domain/usecase/join_activity_usecase.dart';
import 'package:movin/features/activity/presentation/bloc/activity_detail_bloc.dart';
import 'package:movin/features/activity/presentation/pages/activity_detail_page.dart';
import 'package:movin/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:movin/features/auth/presentation/pages/auth_page.dart';
import 'package:movin/features/home/domain/entities/activity.dart';
import 'package:movin/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:movin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:movin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:movin/features/splash/presentation/pages/splash_page.dart';
import 'package:movin/features/auth/presentation/pages/auth_page.dart';
import 'package:movin/features/home/presentation/pages/home_page.dart';
import 'package:movin/shell/main_shell_page.dart';
import 'package:movin/features/profile/presentation/pages/edit_profile_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String editProfile = '/edit-profile';

  static const String activityDetail = '/activity-detail';

  static const String transaction = '/transaction';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainShellPage());
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage(),);
      
      // Routes for activity detail page
      case AppRoutes.activityDetail:
        final activity = settings.arguments as Activity;

        final secureStorage = const FlutterSecureStorage();
        final localDataSource = AuthLocalDataSource(secureStorage);
        final dioClient = DioClient(localDataSource);

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ActivityDetailBloc(
              JoinActivityUseCase(
                ActivityRepositoryImpl(
                  ActivityRemoteDataSource(dioClient.dio),
                ),
              ),
            ),
            child: ActivityDetailPage(activity: activity),
          ),
        );
      

      // Routes for transaction page
      // case AppRoutes.transaction:
      //   final activityId = settings.arguments as int;
      //   return MaterialPageRoute(
      //     builder: (_) => TransactionPage(activityId: activityId),
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 not found')),
          ),
        );
    }
  }
}