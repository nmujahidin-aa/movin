import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/routes.dart';
import '../bloc/auth_bloc.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (r) => false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: index == 0
                ? LoginPage(
                    key: const ValueKey('login'),
                    onGoRegister: () => setState(() => index = 1),
                  )
                : RegisterPage(
                    key: const ValueKey('register'),
                    onGoLogin: () => setState(() => index = 0),
                  ),
          ),
        ),
      ),
    );
  }
}