import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //Sign in with Email
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //Sign up with Email
  Future<AuthResponse> signUpWithEmailPassword({
    required String legalName,
    required String email,
    required String password,
    required String role,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'legal_name': legalName, 'role': role},
    );
  }

  //SignIn with google

  //Logout
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  //Current User email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
