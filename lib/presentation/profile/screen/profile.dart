import 'package:fintracker/core/router/app_name.dart';
import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/presentation/authentication/bloc/auth_bloc.dart';
import 'package:fintracker/presentation/authentication/bloc/auth_event.dart';
import 'package:fintracker/presentation/authentication/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnAuthenticate) {
              context.goNamed(AppName.loginName);
            }
          },
          builder: (context, state) {
            if (state is AuthAuthenticate) {
              final userName = state.user.username;
              final email = state.user.email;
              return Column(
                children: [
                  _ProfileHeader(userName, email),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _ProfileOption(
                          icon: Icons.edit_outlined,
                          title: 'Edit Profile',
                          onTap: () {},
                        ),

                        _ProfileOption(
                          icon: Icons.lock_outline,
                          title: 'Change Password',
                          onTap: () {},
                        ),

                        _ProfileOption(
                          icon: Icons.notifications_none_outlined,
                          title: 'Notifications',
                          onTap: () {},
                        ),

                        _ProfileOption(
                          icon: Icons.dark_mode_outlined,
                          title: 'Theme',
                          trailing: 'System',
                          onTap: () {},
                        ),

                        _ProfileOption(
                          icon: Icons.language_outlined,
                          title: 'Currency',
                          trailing: 'USD',
                          onTap: () {},
                        ),

                        _ProfileOption(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          onTap: () {},
                        ),

                        _ProfileOption(
                          icon: Icons.logout,
                          title: 'Logout',
                          isLogout: true,
                          onTap: () {
                            context.read<AuthBloc>().add(AuthSignOut());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String userName;

  final String email;
  const _ProfileHeader(this.userName, this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 22),
      decoration: const BoxDecoration(
        color: AppColors.primarys,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            padding: const EdgeInsets.all(3),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/logo/profile.png'),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            userName,
            style: TextStyle(
              color: AppColors.background,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 2),

          Text(email, style: TextStyle(color: AppColors.card, fontSize: 11)),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  final bool isLogout;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFEDEDED), width: 0.7),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: isLogout ? Colors.red : Colors.black87),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isLogout ? Colors.red : Colors.black87,
                ),
              ),
            ),

            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),

            if (trailing != null) const SizedBox(width: 10),

            if (!isLogout)
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
