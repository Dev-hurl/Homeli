import 'package:supabase_flutter/supabase_flutter.dart';

class IdentityService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, String>> fetchIdentity() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return {'full_name': '', 'phone': '', 'email': ''};
    }

    final userId = user.id;
    final identity = await _supabase
        .from('identities')
        .select('full_name, phone, avatar_url')
        .eq('user_id', userId)
        .maybeSingle();

    return {
      'full_name': identity?['full_name'] as String? ?? '',
      'phone': identity?['phone'] as String? ?? '',
      'email': user.email ?? '',
      'avatar_url': identity?['avatar_url'] as String? ?? '',
    };
  }

  Future<void> updateIdentity({
    required String fullName,
    required String phone,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('No active user found.');
    }

    await _supabase
        .from('identities')
        .update({
          'full_name': fullName,
          'phone': phone,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('user_id', userId);
  }

  Future<void> updateEmail(String newEmail) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw StateError('No active user found.');
    }

    await _supabase.auth.updateUser(UserAttributes(email: newEmail));
  }
}
