import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/features/auth/presentation/widgets/auth_footer.dart';
import 'package:movin/features/auth/presentation/widgets/auth_header.dart';
import 'package:movin/features/auth/presentation/widgets/auth_layout.dart';
import 'package:movin/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:movin/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:movin/features/auth/presentation/widgets/auth_text_field.dart';

import '../../../../core/utils/validators.dart';
import '../bloc/auth_bloc.dart';
import 'forgot_password_page.dart';
import '../../../../core/utils/snackbars.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onGoRegister});
  final VoidCallback onGoRegister;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_form.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(AuthLoginRequested(email: _email.text.trim(), password: _pass.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) => p.status != c.status || p.message != c.message,
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          AppSnack.error(context, state.message ?? 'Gagal login');
        }
      },
      child: AuthLayout(
        child: Form(
          key: _form,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              const AuthHeader(
                title: "MOVIN",
                subtitle: "Ready for your next game?",
              ),
              const SizedBox(height: 40),

              AuthTextField(
                controller: _email,
                label: "Email Address",
                hint: "email@example.com",
                validator: Validators.email,
              ),

              const SizedBox(height: 16),

              AuthPasswordField(
                controller: _pass,
                validator: Validators.password,
              ),

              const SizedBox(height: 20),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return AuthPrimaryButton(
                    label: "Masuk",
                    onPressed: _submit,
                    loading: state.status == AuthStatus.loading,
                  );
                },
              ),

              const SizedBox(height: 40),

              AuthFooter(
                text: "Belum punya akun?",
                actionText: "Daftar",
                onTap: widget.onGoRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}