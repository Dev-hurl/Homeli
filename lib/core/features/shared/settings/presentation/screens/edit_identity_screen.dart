import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/shared/widgets/circle_icon_button.dart';
import 'package:homeli/core/widgets/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

class EditIdentityScreen extends StatefulWidget {
  const EditIdentityScreen({super.key});

  @override
  State<EditIdentityScreen> createState() => _EditIdentityScreenState();
}

class _EditIdentityScreenState extends State<EditIdentityScreen> {
  final TextEditingController _legalNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _legalNameController.dispose();
    _phoneNumberController.dispose();
    _emailAddressController.dispose();
    super.dispose();
  }

  void _changePhoto() {
    //
  }

  void _removePhoto() {
    //
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Identity & Profile',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            size: 20,
            color: colorScheme.secondaryContainer,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(),
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.secondary.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              spacing: 12,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedCamera01,
                        size: 16,
                        strokeWidth: 2,
                        color: colorScheme.surface,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Larry Cho',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  spacing: 12,
                  mainAxisAlignment: .center,
                  children: [
                    FilledButton.icon(
                      label: Text(
                        'Change Photo',
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedUpload06,
                        color: colorScheme.secondaryContainer,
                        size: 18,
                      ),
                      onPressed: _changePhoto,
                      style: FilledButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        backgroundColor: colorScheme.surfaceContainerLow,
                      ),
                    ),
                    FilledButton.icon(
                      label: Text(
                        'Remove Photo',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedDelete01,
                        color: colorScheme.error,
                        size: 18,
                        strokeWidth: 2,
                      ),

                      onPressed: _removePhoto,
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        iconColor: colorScheme.error,
                        elevation: 0,
                        backgroundColor: colorScheme.surfaceContainerLow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credentials',
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.secondaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24),

                  CustomTextFormField(
                    controller: _legalNameController,
                    hintText: 'Larry Cho',
                    labelText: 'Full Legal Name',
                    labelColor: colorScheme.secondaryContainer,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _phoneNumberController,
                    hintText: '+234 801 234 56',
                    labelText: 'Phone Number',
                    labelColor: colorScheme.secondaryContainer,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _emailAddressController,
                    hintText: 'Larrycho@homeli.com',
                    labelText: 'Email Address',
                    labelColor: colorScheme.secondaryContainer,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
