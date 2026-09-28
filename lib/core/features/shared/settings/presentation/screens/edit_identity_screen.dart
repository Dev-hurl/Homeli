import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/service/identity_service.dart';
import 'package:homeli/core/widgets/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditIdentityScreen extends StatefulWidget {
  const EditIdentityScreen({super.key});

  @override
  State<EditIdentityScreen> createState() => _EditIdentityScreenState();
}

class _EditIdentityScreenState extends State<EditIdentityScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
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

  String _originalFullName = '';
  String _originalPhone = '';
  String _originalEmail = '';
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadIdentity();
  }

  Future<void> _loadIdentity() async {
    try {
      final data = await IdentityService().fetchIdentity();
      _originalFullName = data['full_name']!;
      _originalPhone = data['phone']!;
      _originalEmail = data['email']!;
      _fullNameController.text = _originalFullName;
      _phoneNumberController.text = _originalPhone;
      _emailAddressController.text = _originalEmail;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load profile: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _onSavePressed() async {
    setState(() => _isSaving = true);
    final newFullName = _fullNameController.text.trim();
    final newPhone = _phoneNumberController.text.trim();
    final newEmail = _emailAddressController.text.trim();
    final identityChanged =
        newFullName != _originalFullName || newPhone != _originalPhone;
    final emailChanged = newEmail != _originalEmail;

    try {
      if (identityChanged) {
        await IdentityService().updateNameAndPhone(
          fullName: newFullName,
          phone: newPhone,
        );
        _originalFullName = newFullName;
        _originalPhone = newPhone;
      }
      if (emailChanged) {
        await IdentityService().updateEmail(newEmail);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              emailChanged
                  ? 'Saved. Check your new email to confirm the change.'
                  : 'Saved.',
            ),
          ),
        );
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
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
                          horizontal: 12,
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
                          horizontal: 12,
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
            padding: EdgeInsets.all(16),
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
                    controller: _fullNameController,
                    hintText: 'Larry Cho',
                    labelText: 'Full full Name',
                    labelColor: colorScheme.secondaryContainer,
                    prefixIcon: UnconstrainedBox(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedUser,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _phoneNumberController,
                    hintText: '+234 801 234 56',
                    labelText: 'Phone Number',
                    labelColor: colorScheme.secondaryContainer,
                    prefixIcon: UnconstrainedBox(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedSmartPhone02,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    readOnly: true,
                    controller: _emailAddressController,
                    hintText: 'Larrycho@homeli.com',
                    labelText: 'Email Address',
                    labelColor: colorScheme.secondaryContainer,
                    prefixIcon: UnconstrainedBox(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedMail01,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32,),
          FilledButton(
            onPressed: _onSavePressed,
            style: FilledButton.styleFrom(
              elevation: 0,
              disabledBackgroundColor: colorScheme.surfaceContainerLow,
              minimumSize: Size(double.infinity, 52),
            ),
            child: Text(
              'Save Changes',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
