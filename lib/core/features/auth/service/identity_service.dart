import 'package:supabase_flutter/supabase_flutter.dart';

import 'identity_cache.dart';

class IdentityService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final IdentityCache _cache = IdentityCache();

  Future<Map<String, String>> getIdentity({bool forceRefresh = false}) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return {'full_name': '', 'phone': '', 'email': ''};
    }

    if (!forceRefresh) {
      final cached = await _cache.read();
      if (cached != null && cached['user_id'] == user.id) {
        return {
          'full_name': cached['full_name'] as String? ?? '',
          'phone': cached['phone'] as String? ?? '',
          'email': user.email ?? '',
          'avatar_url': cached['avatar_url'] as String? ?? '',
        };
      }
    }

    final userId = user.id;
    final identity = await _supabase
        .from('identities')
        .select('full_name, phone, avatar_url')
        .eq('user_id', userId)
        .maybeSingle();

    final row = identity ?? <String, dynamic>{};
    await _cache.save({'user_id': userId, ...row});

    return {
      'full_name': row['full_name'] as String? ?? '',
      'phone': row['phone'] as String? ?? '',
      'email': user.email ?? '',
      'avatar_url': row['avatar_url'] as String? ?? '',
    };
  }

  Future<Map<String, String>> fetchIdentity() => getIdentity();

  Future<void> updateNameAndPhone({
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

    await getIdentity(forceRefresh: true);
  }

  Future<void> updateIdentity({
    required String fullName,
    required String phone,
  }) {
    return updateNameAndPhone(fullName: fullName, phone: phone);
  }

  Future<void> updateEmail(String newEmail) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw StateError('No active user found.');
    }

    await _supabase.auth.updateUser(UserAttributes(email: newEmail));
  }

  Future<void> clearCache() => _cache.clear();
}
