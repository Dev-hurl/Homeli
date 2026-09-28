import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/providers/role_provider.dart';
import 'package:homeli/core/features/auth/service/auth_service.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  Future<void> _onLogout() async {
    try {
      await AuthService().logout();
      if (!mounted) return;

      context.read<UserRoleProvider>().setRole(UserRole.seeker);
      context.go(AppRouter.signIn);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to log out. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final role = context.watch<UserRoleProvider>().activeRole;
    final isLister = role == UserRole.lister;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedHelpCircle,
                    color: colorScheme.secondaryContainer,
                    strokeWidth: 2,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(
                              'assets/images/avatar.png',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.verified,
                                size: 12,
                                color: colorScheme.secondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Larry Cho',
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainerHigh,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        size: 10,
                                        color: colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        'Gold Trust',
                                        style: textTheme.labelSmall?.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              'sophia.chen@studio-arch.com',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.read<UserRoleProvider>().setRole(
                        isLister ? UserRole.seeker : UserRole.lister,
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.surfaceContainerHigh,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLister
                                  ? 'Switch to Seeker View'
                                  : 'Switch to Lister View',
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              size: 16,
                              color: colorScheme.secondaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'IDENTITY & ROLES',
              children: [
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedIdentification,
                  title: 'Edit Identity & Profile',
                  subtitle: 'Name, phone, avatar, role bio',
                  onTap: () => context.push(AppRouter.editIdentityScreen),
                ),
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedUserGroup,
                  title: 'Dual-Role Management',
                  subtitle: 'Active as Seeker & Lister',
                  onTap: () {},
                ),
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedShieldUser,
                  title: 'Trust & Verification',
                  subtitle: 'Gov ID, Work, Phone, Background',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'PREFERENCES & EXPERIENCES',
              children: [
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedNotification01,
                  title: 'Notification Settings',
                  subtitle: 'Push, SMS & Instant Tour Alerts',
                  trailingSwitch: true,
                  switchValue: true,
                  onSwitchChanged: (_) {},
                ),
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedCoins01,
                  title: 'Currency & Region',
                  subtitle: 'USD (\$) • New York, EST',
                  onTap: () {},
                ),
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedRuler,
                  title: 'Search & Distance Units',
                  subtitle: 'Miles (mi)',
                  onTap: () {},
                ),
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedMoon02,
                  title: 'Dark Mode',
                  subtitle: 'System standard (Off)',
                  trailingSwitch: true,
                  switchValue: false,
                  onSwitchChanged: (_) {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'SECURITY & PAYOUTS',
              children: [
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedFingerPrint,
                  title: 'Login Security & Biometrics',
                  subtitle: 'Face ID Enabled',
                  trailingSwitch: true,
                  switchValue: true,
                  onSwitchChanged: (_) {},
                ),
                if (isLister)
                  _SettingsRow(
                    icon: HugeIcons.strokeRoundedBank,
                    title: 'Direct Payouts & Escrow',
                    subtitle: 'Chase •••• 4120 Connected',
                    onTap: () {},
                  ),
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedSquareLock02,
                  title: 'Privacy & Permissions',
                  subtitle: 'Location while using app',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'SUPPORT & LEGAL',
              children: [
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedHeadphones,
                  title: 'Homeli Support',
                  subtitle: '24/7 Priority Dedicated Line',
                  onTap: () {},
                ),
                if (isLister)
                  _SettingsRow(
                    icon: HugeIcons.strokeRoundedShieldUser,
                    title: 'Host Guarantee & Protection',
                    subtitle: '\$50,000 policy applied automatically',
                    onTap: () {},
                  ),
                _SettingsRow(
                  icon: HugeIcons.strokeRoundedInformationCircle,
                  title: 'App Version',
                  subtitle: 'v2.4.0 (Build 384)',
                  trailingText: 'Up to date',
                  onTap: null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onLogout,
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 52),
                  backgroundColor: colorScheme.error,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedLogout02,
                      size: 16,
                      color: colorScheme.surface,
                      strokeWidth: 2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Log Out',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.surface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Delete Account & Privacy Data',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.error,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: colorScheme.secondary.withValues(alpha: 0.05),
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool trailingSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final String? trailingText;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailingSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: UnconstrainedBox(
                child: HugeIcon(
                  icon: icon,
                  size: 18,
                  color: colorScheme.secondary,
                  strokeWidth: 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (trailingSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeThumbColor: colorScheme.secondaryContainer,
                inactiveThumbColor: colorScheme.secondaryContainer,
              )
            else if (trailingText != null)
              Text(
                trailingText!,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            else if (onTap != null)
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}
