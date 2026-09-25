import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/service/auth_service.dart';
import 'package:homeli/core/widgets/custom_text_form_field.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:hugeicons/hugeicons.dart';

class SignUpScreen extends StatefulWidget {
  final String roleName;
  const SignUpScreen({super.key, required this.roleName});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _legalName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TapGestureRecognizer _signInRecognizer = TapGestureRecognizer();

  final bool isObscure = true;
  String? _checked;

  Future<void> _onCreateAccountPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        await AuthService().signUpWithEmailPassword(
          legalName: _legalName.text.trim(),
          email: _emailAddress.text.trim(),
          password: _password.text,
          role: widget.roleName,
        );
        if (mounted) {
          context.push(
            AppRouter.otpVerification,
            extra: OtpRouteArguments(
              firstName: _legalName.text,
              emailAddress: _emailAddress.text,
              role: widget.roleName == 'LISTER'
                  ? UserRole.lister
                  : UserRole.seeker,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error : $e')));
        }
      }
    }
  }

  @override
  void dispose() {
    _signInRecognizer.dispose();
    _legalName.dispose();
    _emailAddress.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                          final email = value?.trim() ?? '';
                          final emailPattern = RegExp(
                            r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                          );
                          if (email.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!emailPattern.hasMatch(email)) {
                            return 'Please enter a valid email address';
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
                SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: _checked == 'checked',
                      fillColor: WidgetStateProperty.all(colorScheme.primary),
                      checkColor: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _checked = value! ? 'checked' : null;
                        });
                      },
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: textTheme.labelMedium,
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ' and ', style: textTheme.labelMedium),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onCreateAccountPressed,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: colorScheme.primary,
                    minimumSize: Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Create your Homeli Account',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: textTheme.labelMedium,
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          recognizer: _signInRecognizer
                            ..onTap = () {
                              context.push(AppRouter.signIn);
                            },
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
          borderRadius: BorderRadius.circular(12),
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
