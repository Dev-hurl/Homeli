import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, String>> fetchProfile() async {
    final userId = _supabase.auth.currentUser!.id;

    final profile = await _supabase
        .from('profiles')
        .select('display_name, occupation, bio')
        .eq('user_id', userId)
        .maybeSingle();

    return {
      'display_name': profile?['display_name'] as String? ?? '',
      'occupation': profile?['occupation'] as String? ?? '',
      'bio': profile?['bio'] as String? ?? '',
    };
  }

  Future<void> updateProfile({
    required String displayName,
    required String occupation,
    required String bio,
  }) async {
    final userId = _supabase.auth.currentUser!.id;
    await _supabase
        .from('profiles')
        .update({
          'display_name': displayName,
          'occupation': occupation,
          'bio': bio,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('user_id', userId);
  }
}
