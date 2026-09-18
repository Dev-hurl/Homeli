import 'package:flutter/material.dart';
import 'package:homeli/core/constants/app_colors.dart';
import 'package:homeli/core/features/lister role/presentation/screens/lister_home_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/seeker_home_screen.dart';
import 'package:homeli/core/widgets/otp_keypad.dart';

class OtpVerification extends StatefulWidget {
  final String emailAddress;
  final String firstName;
  final String roleName;

  const OtpVerification({
    super.key,
    required this.emailAddress,
    required this.firstName,
    required this.roleName,
  });

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _otpErrorMessage;
  bool _hasSubmitted = false;

  String get _otpCode =>
      _otpControllers.map((controller) => controller.text).join();

  bool get _isOtpValid =>
      _otpCode.length == 6 && RegExp(r'^\d{6}$').hasMatch(_otpCode);

  void _validateOtp() {
    setState(() {
      _hasSubmitted = true;
      if (_otpCode.isEmpty || _otpCode.length < 6) {
        _otpErrorMessage = 'Please enter the 6-digit code';
      } else if (!RegExp(r'^\d{6}$').hasMatch(_otpCode)) {
        _otpErrorMessage = 'Invalid OTP code';
      } else {
        _otpErrorMessage = null;
      }
    });

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget.roleName == 'LISTER'
              ? const ListerHomeScreen()
              : SeekerHomeScreen(firstName: widget.firstName),
        ),
        (route) => false,
      );
    }
  }

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty && !RegExp(r'^\d$').hasMatch(value)) {
      _otpControllers[index].clear();
      return;
    }

    if (value.isNotEmpty && index < _otpControllers.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }

    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    setState(() {
      if (_otpCode.length == 6 && _isOtpValid) {
        _otpErrorMessage = null;
      } else if (_hasSubmitted) {
        _otpErrorMessage = _otpCode.isEmpty || _otpCode.length < 6
            ? 'Please enter the 6-digit code'
            : 'Invalid OTP code';
      }
    });
  }

  Color _getBorderColor(int index, ColorScheme colorScheme) {
    final fieldValue = _otpControllers[index].text;
    final hasValue = fieldValue.isNotEmpty;

    if (_isOtpValid) {
      return Colors.green;
    }

    if (_hasSubmitted && (!hasValue || !RegExp(r'^\d$').hasMatch(fieldValue))) {
      return AppColors.error;
    }

    if (_focusNodes[index].hasFocus) {
      return colorScheme.primary;
    }

    return colorScheme.secondary.withValues(alpha: 0.4);
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/Homeli Logo Inverted .png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    text: 'We sent a 6-digit code to ',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(
                        text: widget.emailAddress,
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              6,
                              (index) => SizedBox(
                                width: 50,
                                child: TextFormField(
                                  controller: _otpControllers[index],
                                  autofocus: false,
                                  readOnly: true,
                                  focusNode: _focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.none,
                                  maxLength: 1,
                                  buildCounter: (
                                    _, {
                                    required currentLength,
                                    required isFocused,
                                    maxLength,
                                  }) => SizedBox.shrink(),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: _getBorderColor(
                                          index,
                                          colorScheme,
                                        ),
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: _isOtpValid
                                            ? AppColors.success
                                            : colorScheme.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: AppColors.error,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: colorScheme.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) =>
                                      _onDigitChanged(value, index),
                                  validator: (value) {
                                    if (_otpCode.isEmpty ||
                                        _otpCode.length < 6) {
                                      return 'Please enter the 6-digit code';
                                    }
                                    if (!RegExp(r'^\d{6}$')
                                        .hasMatch(_otpCode)) {
                                      return 'Invalid OTP code';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (_otpErrorMessage != null && _hasSubmitted) ...[
                            SizedBox(height: 12),
                            Text(
                              _otpErrorMessage!,
                              style: textTheme.labelMedium?.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          SizedBox(height: 24),
                          Text(
                            'Resend code in 00:30',
                            style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _isOtpValid ? _validateOtp : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 52),
                              disabledBackgroundColor: colorScheme.primary
                                  .withValues(alpha: 0.5),
                              backgroundColor: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Verify OTP',
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow.withValues(
                      alpha: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: OtpKeypad(
                      onDigitTap: (digit) {
                        for (int i = 0; i < _otpControllers.length; i++) {
                          if (_otpControllers[i].text.isEmpty) {
                            _otpControllers[i].text = digit;
                            _onDigitChanged(digit, i);
                            break;
                          }
                        }
                      },
                      onBackspaceTap: () {
                        for (int i = _otpControllers.length - 1; i >= 0; i--) {
                          if (_otpControllers[i].text.isNotEmpty) {
                            _otpControllers[i].clear();
                            _onDigitChanged('', i);
                            break;
                          }
                        }
                      },
                      onBiometricTap: () {
                        // Handle biometric authentication here
                      },
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
