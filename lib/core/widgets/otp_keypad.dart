import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class OtpKeypad extends StatelessWidget {
  final ValueChanged<String> onDigitTap;
  final VoidCallback onBackspaceTap;
  final VoidCallback? onBiometricTap;

  const OtpKeypad({
    super.key,
    required this.onDigitTap,
    required this.onBackspaceTap,
    this.onBiometricTap,
  });

  static const _keys = [
    ['1'],
    ['2'],
    ['3'],
    ['4'],
    ['5'],
    ['6'],
    ['7'],
    ['8'],
    ['9'],
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget buildDigitKey(String digit) {
      return Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.secondary.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onDigitTap(digit),
          child: Center(
            child: Text(
              digit,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    Widget buildIconKey({required dynamic icon, required VoidCallback? onTap}) {
      return Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.secondary.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Center(
            child: HugeIcon(icon: icon, color: colorScheme.onSurface, size: 22),
          ),
        ),
      );
    }

    final keypadItems = <Widget>[];
    for (final row in _keys) {
      for (final digit in row) {
        keypadItems.add(buildDigitKey(digit));
      }
    }
    keypadItems.add(
      buildIconKey(
        icon: HugeIcons.strokeRoundedFingerAccess,
        onTap: onBiometricTap,
      ),
    );
    keypadItems.add(buildDigitKey('0'));
    keypadItems.add(
      buildIconKey(
        icon: HugeIcons.strokeRoundedCancelCircle,
        onTap: onBackspaceTap,
      ),
    );

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      mainAxisSpacing: 8,
      crossAxisSpacing: 12,
      childAspectRatio: 2,
      physics: NeverScrollableScrollPhysics(),
      children: keypadItems,
    );
  }
}
