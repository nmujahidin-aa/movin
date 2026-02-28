import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movin/core/config/routes.dart';
import 'package:movin/features/splash/presentation/bloc/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 1)); 
    if (!mounted) return;

    context.read<SplashCubit>().checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) =>
          current is SplashGoHome || current is SplashGoAuth,
      listener: (context, state) {
        if (!mounted) return;

        if (state is SplashGoHome) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is SplashGoAuth) {
          Navigator.pushReplacementNamed(context, AppRoutes.auth);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset(
            'assets/lottie/ball.json',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
            repeat: true,
          ),
        )
      ),
    );
  }
}
