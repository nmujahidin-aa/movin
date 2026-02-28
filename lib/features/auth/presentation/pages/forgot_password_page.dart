import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/utils/snackbars.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_form.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(AuthResetPasswordRequested(email: _email.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lupa Password')),
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (p, c) => p.status != c.status || p.message != c.message,
        listener: (context, state) {
          if (state.status == AuthStatus.resetEmailSent) {
            AppSnack.success(context, 'Email reset password dikirim');
            Navigator.pop(context);
          } else if (state.status == AuthStatus.failure) {
            AppSnack.error(context, state.message ?? 'Gagal mengirim email reset');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Text(
                  'Masukkan email akun kamu, kami akan kirim link reset password.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _email,
                  validator: Validators.email,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _submit,
                    child: const Text('Kirim'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}