import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movin/core/network/dio_client.dart';
import 'package:movin/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:movin/features/home/data/datasource/home_remote_datasource.dart';
import 'package:movin/features/home/data/repositories/home_repository_impl.dart';
import 'package:movin/features/home/domain/usecase/get_activities_usecase.dart';
import 'package:movin/features/home/presentation/bloc/home_bloc.dart';
import 'package:movin/features/home/presentation/bloc/home_event.dart';
import 'package:movin/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:movin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:movin/features/profile/domain/repository/profile_repository.dart';
import 'package:movin/features/profile/presentation/bloc/profile_bloc.dart';

import 'core/config/routes.dart';

import 'features/auth/data/datasource/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecase/check_auth_status_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MovinApp extends StatelessWidget {
  const MovinApp({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AuthLocalDataSource(const FlutterSecureStorage());
    final dioClient = DioClient(local);
    final dio = dioClient.dio;

    final authRepository = AuthRepositoryImpl(AuthRemoteDataSource(dio), local);
    final homeRepository = HomeRepositoryImpl(HomeRemoteDataSource(dio),);

    final profileRepository = ProfileRepositoryImpl(ProfileRemoteDataSource(dio));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository)
          ..add(const AuthObserveRequested()),
        ),
        BlocProvider<SplashCubit>(
          create: (_) => SplashCubit(
            CheckAuthStatusUseCase(authRepository),
          ),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(
            GetActivitiesUseCase(homeRepository),
          )..add(HomeRequested()),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(profileRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: dotenv.get('APP_NAME'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
