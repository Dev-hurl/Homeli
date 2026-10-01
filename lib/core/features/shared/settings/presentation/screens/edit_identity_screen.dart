import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/service/identity_service.dart';
import 'package:homeli/core/features/auth/service/profile_service.dart';
import 'package:homeli/core/widgets/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditIdentityScreen extends StatefulWidget {
  const EditIdentityScreen({super.key});

  @override
  State<EditIdentityScreen> createState() => _EditIdentityScreenState();
}

class _EditIdentityScreenState extends State<EditIdentityScreen> {
  File? image; //image file
  final ImagePicker picker = ImagePicker(); //image picker
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailAddressController.dispose();
    _displayNameController.dispose();
    _occupationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _removePhoto() {
    //
  }

  //Image picker method
  Future<void> pickImage(ImageSource source) async {
    //pick from gallery or camera
    final pickedFile = await picker.pickImage(source: source);

    //update picker file
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  //Upload Image to supabase
  Future<void> uploadImage() async {
    if (image == null) return;

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return; // not signed in — shouldn't happen here, but guards the null check below

    final path = '$userId/avatar.jpg';

    try {
      await Supabase.instance.client.storage
          .from('avatars')
          .upload(path, image!, fileOptions: const FileOptions(upsert: true));

      final publicUrl = Supabase.instance.client.storage
          .from('avatars')
          .getPublicUrl(path);

      await Supabase.instance.client
          .from('identities')
          .update({'avatar_url': publicUrl})
          .eq('user_id', userId);

      await Supabase.instance.client
          .from('profiles')
          .update({'avatar_url': publicUrl})
          .eq('user_id', userId);

      if (!mounted) return;
      setState(() {
        _avatarUrl = publicUrl;
        image = null;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to upload image: $error')));
    }
  }

  String _originalFullName = '';
  String _originalPhone = '';
  String _originalEmail = '';
  String _originalDisplayName = '';
  String _originalOccupation = '';
  String _originalBio = '';
  String _avatarUrl = '';
  bool _isLoading = true;
  bool _isSaving = false;

  bool get _hasAnyChanges {
    final fullNameChanged =
        _fullNameController.text.trim() != _originalFullName;
    final phoneChanged = _phoneNumberController.text.trim() != _originalPhone;
    final emailChanged = _emailAddressController.text.trim() != _originalEmail;
    final displayNameChanged =
        _displayNameController.text.trim() != _originalDisplayName;
    final occupationChanged =
        _occupationController.text.trim() != _originalOccupation;
    final bioChanged = _bioController.text.trim() != _originalBio;

    return fullNameChanged ||
        phoneChanged ||
        emailChanged ||
        displayNameChanged ||
        occupationChanged ||
        bioChanged;
  }

  @override
  void initState() {
    super.initState();
    _loadIdentity();
    _loadProfile();
  }

  Future<void> _loadIdentity() async {
    try {
      final data = await IdentityService().fetchIdentity();
      _originalFullName = data['full_name'] ?? '';
      _originalPhone = data['phone'] ?? '';
      _originalEmail = data['email'] ?? '';
      _avatarUrl = data['avatar_url'] ?? '';
      _fullNameController.text = _originalFullName;
      _phoneNumberController.text = _originalPhone;
      _emailAddressController.text = _originalEmail;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load identity: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadProfile() async {
    try {
      final data = await ProfileService().fetchProfile();
      _originalDisplayName = data['display_name'] ?? '';
      _originalOccupation = data['occupation'] ?? '';
      _originalBio = data['bio'] ?? '';
      if ((data['avatar_url'] as String? ?? '').isNotEmpty &&
          _avatarUrl.isEmpty) {
        _avatarUrl = data['avatar_url'] ?? '';
      }
      _displayNameController.text = _originalDisplayName;
      _occupationController.text = _originalOccupation;
      _bioController.text = _originalBio;
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
    final newDisplayName = _displayNameController.text.trim();
    final newOccupation = _occupationController.text.trim();
    final newBio = _bioController.text.trim();
    final identityChanged =
        newFullName != _originalFullName || newPhone != _originalPhone;

    final profileChanged =
        newDisplayName != _originalDisplayName ||
        newOccupation != _originalOccupation ||
        newBio != _originalBio;
    final emailChanged = newEmail != _originalEmail;

    try {
      if (identityChanged) {
        await IdentityService().updateIdentity(
          fullName: newFullName,
          phone: newPhone,
        );
        _originalFullName = newFullName;
        _originalPhone = newPhone;
      }
      if (profileChanged) {
        await ProfileService().updateProfile(
          displayName: newDisplayName,
          occupation: newOccupation,
          bio: newBio,
        );
        _originalDisplayName = newDisplayName;
        _originalOccupation = newOccupation;
        _originalBio = newBio;
      }
      if (emailChanged) {
        await IdentityService().updateEmail(newEmail);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
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
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
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
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => pickImage(ImageSource.gallery),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            shape: BoxShape.circle,
                          ),
                          child: image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(image!, fit: BoxFit.cover),
                                )
                              : _avatarUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    _avatarUrl,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                    errorBuilder: (_, _, _) => Center(
                                      child: HugeIcon(
                                        icon:
                                            HugeIcons.strokeRoundedCameraAdd01,
                                        size: 20,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: HugeIcon(
                                    icon: HugeIcons.strokeRoundedCameraAdd01,
                                    size: 20,
                                    strokeWidth: 2,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 12),
                      Text(
                        'Larry Cho',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        'ID: HML-8842-CA',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        spacing: 12,
                        mainAxisAlignment: .center,
                        children: [
                          FilledButton.icon(
                            label: Text(
                              'Upload Photo',
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedUpload06,
                              color: colorScheme.secondaryContainer,
                              size: 18,
                            ),
                            onPressed: () => uploadImage(),
                            style: FilledButton.styleFrom(
                              elevation: 0,

                              backgroundColor: colorScheme.surfaceContainerLow,
                            ),
                          ),
                          FilledButton.icon(
                            label: Text(
                              'Remove Photo',
                              style: textTheme.labelLarge?.copyWith(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Credentials',
                              style: textTheme.headlineMedium?.copyWith(
                                color: colorScheme.secondaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 24),

                            CustomTextFormField(
                              controller: _fullNameController,
                              hintText: 'Larry Cho',
                              labelText: 'Full Name',
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
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Role-Specific Display Override',
                              style: textTheme.headlineMedium?.copyWith(
                                color: colorScheme.secondaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Customize how your identity appears when acting as a Lister vs. a Seeker without affecting your verified trust score.',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 24),
                            CustomTextFormField(
                              controller: _displayNameController,
                              hintText: 'New Residences',
                              labelText: 'Display Name',
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
                              controller: _occupationController,
                              hintText: 'Architect',
                              labelText: 'Occupation',
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
                            SizedBox(height: 16),
                            CustomTextFormField(
                              controller: _bioController,
                              hintText: 'Write a short bio about yourself',
                              labelText: 'Public Bio',
                              labelColor: colorScheme.secondaryContainer,
                              maxLines: 3,
                              prefixIcon: UnconstrainedBox(
                                child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedSmartPhone02,
                                  size: 18,
                                  color: colorScheme.onSurfaceVariant,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                FilledButton(
                  onPressed: (_isLoading || _isSaving || !_hasAnyChanges)
                      ? null
                      : _onSavePressed,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    disabledBackgroundColor: colorScheme.primary.withValues(
                      alpha: 0.3,
                    ),
                    minimumSize: Size(double.infinity, 52),
                  ),
                  child: _isSaving
                      ? CircularProgressIndicator(color: colorScheme.primary)
                      : Text(
                          'Save Changes',
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            // color: colorScheme.surface,
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
