import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/models/role_setup_data.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_up_screen.dart';
import 'package:homeli/core/features/auth/presentation/widgets/role_setup_card.dart';

class RoleSetupScreen extends StatefulWidget {
  const RoleSetupScreen({super.key});

  @override
  State<RoleSetupScreen> createState() => _RoleSetupScreenState();
}

class _RoleSetupScreenState extends State<RoleSetupScreen> {
  String? _selectedRoleName;

  void _onContinuePressed() {
    if (_selectedRoleName != null) {

      final user = roleSetup.firstWhere((role) => role.roleName == _selectedRoleName);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(roleName: _selectedRoleName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How will you use Homeli?',
                  style: textTheme.headlineMedium?.copyWith(
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
            
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onContinuePressed,
                  style: ElevatedButton.styleFrom(
                   elevation: 0,
                    minimumSize: Size(double.infinity, 52),
                    disabledBackgroundColor: colorScheme.primary.withValues(
                      alpha: 0.5,
                    ),
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _selectedRoleName == null
                        ? 'Continue'
                        : 'Continue as ${_selectedRoleName!.toLowerCase()}',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
