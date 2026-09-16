import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/models/role_setup_data.dart';

class RoleSetupCard extends StatelessWidget {
  final bool isSelected;
  const RoleSetupCard({super.key, this.isSelected = false, });


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          children: [
            Row(children: [

            ],)
          ],
        ),
      ),
    );
  }
}
