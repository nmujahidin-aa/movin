import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:movin/features/profile/presentation/bloc/profile_event.dart';
import 'package:movin/features/profile/presentation/bloc/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Error")),
            );
          }

          if (state.status == ProfileStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated")),
            );
          }
        },
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.profile != null) {
            _name.text = state.profile!.name;
            _email.text = state.profile!.email;
            _phone.text = state.profile!.phone ?? "";
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  TextFormField(
                    controller: _phone,
                    decoration:
                        const InputDecoration(labelText: "Phone"),
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                        labelText: "New Password"),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _confirmPassword,
                    decoration: const InputDecoration(
                        labelText: "Confirm Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      final profile =
                          context.read<ProfileBloc>().state.profile;

                      context.read<ProfileBloc>().add(
                            ProfileUpdateRequested(
                              id: profile!.id,
                              name: _name.text,
                              email: _email.text,
                              password: _password.text.isEmpty
                                  ? null
                                  : _password.text,
                              confirmPassword:
                                  _confirmPassword.text.isEmpty
                                      ? null
                                      : _confirmPassword.text,
                              phone: _phone.text,
                            ),
                          );
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}