import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homeli/core/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _legalName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bool isObscure = true;

  @override
  void dispose() {
    super.dispose();
    _legalName.dispose();
    _emailAddress.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                children: [
                  Expanded(
                    child: _SocialButton(
                      iconPath: 'assets/icons/Google.svg',
                      label: 'Google',
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SocialButton(
                      iconPath: 'assets/icons/Apple.svg',
                      label: 'Apple',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      endIndent: 12,
                    ),
                  ),
                  Text(
                    'OR SIGN UP WITH EMAIL',
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      endIndent: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              //TextFormFields
              Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    //FUllNAME
                    CustomTextFormField(
                      controller: _legalName,
                      labelText: 'Full Legal Name',
                      hintText: 'Timothy Carter',
                      prefixIcon: UnconstrainedBox(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedUser,
                          size: 18,
                          color: colorScheme.secondary,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full legal name';
                        }
                        return null;
                      },
                    ),

                    //Email Address
                    CustomTextFormField(
                      controller: _emailAddress,
                      labelText: 'Email Address',
                      hintText: 'user@homeli.com',
                      prefixIcon: UnconstrainedBox(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedMail01,
                          size: 18,
                          color: colorScheme.secondary,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),

                    //Password
                    CustomTextFormField(
                      controller: _password,
                      labelText: 'Password',
                      hintText: 'Create a strong password',
                      obscureText: true,
                      showPasswordToggle: true,
                      prefixIcon: UnconstrainedBox(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedSquareLockPassword,
                          size: 18,
                          color: colorScheme.secondary,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
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

class _SocialButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onTap;
  const _SocialButton({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(iconPath, width: 20, height: 20),
                SizedBox(width: 12),
                Text(
                  label,
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
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
