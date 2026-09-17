import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/models/role_setup_data.dart';
import 'package:homeli/core/features/auth/presentation/widgets/role_setup_card.dart';

class RoleSetupScreen extends StatefulWidget {
  const RoleSetupScreen({super.key});

  @override
  State<RoleSetupScreen> createState() => _RoleSetupScreenState();
}

class _RoleSetupScreenState extends State<RoleSetupScreen> {
  String? _selectedRoleName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How will you use Homeli?',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Select your primary role. You can switch or add another role anytime from your profile.',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16),
              ...roleSetup.map(
                (role) => Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: RoleSetupCard(
                    roleSetup: role,
                    isSelected: _selectedRoleName == role.roleName,
                    onTap: () =>
                        setState(() => _selectedRoleName = role.roleName),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
