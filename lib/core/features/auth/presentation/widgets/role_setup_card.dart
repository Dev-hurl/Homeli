import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/models/role_setup_model.dart';

class RoleSetupCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  const RoleSetupCard({
    super.key,
    this.isSelected = false,
    required this.roleSetup,
    this.onTap,
  });

  final RoleSetupModel roleSetup;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colorScheme.primaryContainer
                : Colors.transparent,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Column(
            spacing: 12,
            children: [
              Row(
                spacing: 12,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: roleSetup.roleIcon,
                  ),
                  Column(
                    spacing: 6,
                    children: [
                      Text(
                        roleSetup.roleName,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.primaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        roleSetup.rolePurpose,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  RadioGroup<bool>(
                    groupValue: isSelected ? true : null,
                    onChanged: (_) => onTap?.call(),
                    child: Radio<bool>(
                      value: true,
                      fillColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            return colorScheme.primary;
                          }
                          return null;
                        },
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(WidgetState.focused)) {
                            return colorScheme.surfaceContainerHigh;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                roleSetup.subtitle,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
