import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/core/config/routes.dart';
import 'package:movin/features/auth/presentation/bloc/auth_bloc.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import 'package:movin/core/widgets/confirm_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthBloc>().state.session;
    final user = session?.user;


    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil(
            AppRoutes.auth,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeader(
                name: user?.name ?? "Guest",
                email: user?.email ?? "-",
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [

                    ProfileMenuItem(
                      icon: Icons.edit_outlined,
                      title: "Edit Profile",
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.editProfile);
                      },
                    ),
     
                    ProfileMenuItem(
                      icon: Icons.calendar_today_outlined,
                      title: "My Schedule",
                      onTap: () {},
                    ),

                    ProfileMenuItem(
                      icon: Icons.notifications_none_outlined,
                      title: "Notifications",
                      onTap: () {},
                    ),

                    ProfileMenuItem(
                      icon: Icons.help_outline,
                      title: "Help Center",
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),

                    ProfileMenuItem(
                      icon: Icons.logout,
                      title: "Logout",
                      isLogout: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmDialog(
                            title: "Konfirmasi Logout",
                            message: "Apakah kamu yakin ingin keluar?",
                            confirmText: "Ya, Logout",
                            confirmColor: Colors.red,
                            onConfirm: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthLogoutRequested());
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}