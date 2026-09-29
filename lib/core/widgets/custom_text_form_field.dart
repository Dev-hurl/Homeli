import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.labelColor,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.fillColor,
    this.showPasswordToggle = false,
    this.readOnly = false,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final Color? labelColor;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final bool showPasswordToggle;
  final bool readOnly;
  final int maxLines;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final Widget? effectiveSuffixIcon;
    if (widget.showPasswordToggle) {
      effectiveSuffixIcon = IconButton(
        onPressed: () => setState(() => _isObscure = !_isObscure),
        icon: HugeIcon(
          icon: _isObscure
              ? HugeIcons.strokeRoundedViewOff
              : HugeIcons.strokeRoundedView,
          size: 20,
          color: colorScheme.secondary,
        ),
        splashRadius: 20,
      );
    } else {
      effectiveSuffixIcon = widget.suffixIcon;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null && widget.labelText!.isNotEmpty) ...[
          Text(
            widget.labelText!,
            style: textTheme.labelLarge?.copyWith(
              color: widget.labelColor ?? colorScheme.secondaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            maxLines: widget.maxLines,
            minLines: 1,
            readOnly: widget.readOnly,
            controller: widget.controller,
            obscureText: widget.showPasswordToggle
                ? _isObscure
                : widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            validator: widget.validator,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: widget.fillColor ?? colorScheme.surfaceContainerLow,
              prefixIcon: widget.prefixIcon,
              suffixIcon: effectiveSuffixIcon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.secondary, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.error, width: 1.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
