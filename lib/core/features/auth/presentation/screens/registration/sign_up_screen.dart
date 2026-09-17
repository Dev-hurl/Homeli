import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Begin Your Santuary Journey',
                style: textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Curated architectural living & design-forward stays worldwide.',
                style: textTheme.bodyMedium,
              ),

              SizedBox(height: 24),
              Row(
                spacing: 12,
                children: [
                  _SocialButton(
                    icon: SvgPicture.asset('assets/icons/Google.svg'),
                    label: 'Google',
                    onTap: () {},
                  ),
                  _SocialButton(
                    icon: SvgPicture.asset('assets/icons/Apple.svg'),
                    label: 'Apple',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: icon,
        label: Text(label, style: textTheme.labelMedium),
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.surfaceContainerLowest,
          foregroundColor: colorScheme.onSurfaceVariant,
          padding: EdgeInsets.symmetric(vertical: 12),
          side: BorderSide(color: colorScheme.surfaceContainerLow),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
