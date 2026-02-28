import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/utils/snackbars.dart';
import '../bloc/auth_bloc.dart';

import '../widgets/auth_layout.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_footer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onGoLogin});
  final VoidCallback onGoLogin;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_form.currentState?.validate() ?? false)) return;

    context.read<AuthBloc>().add(
          AuthRegisterRequested(
            name: _name.text.trim(),
            email: _email.text.trim(),
            password: _pass.text, 
            confirmPassword: _confirmPass.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (p, c) =>
            p.status != c.status || p.message != c.message,
        listener: (context, state) {
          if (state.status == AuthStatus.failure) {
            AppSnack.error(
                context, state.message ?? 'Gagal daftar');
          }
        },
        child: Form(
          key: _form,
          child: ListView(
            children: [
              const SizedBox(height: 40),

              const AuthHeader(
                title: "Buat Akun",
                subtitle: "Join and start your journey",
              ),

              const SizedBox(height: 40),

              AuthTextField(
                controller: _name,
                label: "Full Name",
                hint: "Enter your name",
                validator: (v) =>
                    Validators.requiredField(v,
                        message: 'Nama wajib diisi'),
              ),

              const SizedBox(height: 16),

              AuthTextField(
                controller: _email,
                label: "Email Address",
                hint: "name@example.com",
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),

              const SizedBox(height: 16),

              AuthPasswordField(
                controller: _pass,
                label: "Password",
                validator: Validators.password,
              ),

              const SizedBox(height: 24),
              AuthPasswordField(
                controller: _confirmPass,
                label: "Confirm Password",
                validator: (value) {
                  if (value != _pass.text) {
                    return "Password tidak cocok";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return AuthPrimaryButton(
                    label: "Daftar",
                    onPressed: _submit,
                    loading:
                        state.status == AuthStatus.loading,
                  );
                },
              ),

              const SizedBox(height: 40),

              AuthFooter(
                text: "Sudah punya akun? ",
                actionText: "Masuk",
                onTap: widget.onGoLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
