import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class SupabaseConfig {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'http://127.0.0.1:54321',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM0MTI4MDB9.CRXP1A_c_n1L8w6TfQ_Q26i5jWb6YV4W5yT0dZ_demo',
  );

  static Future<void> initialize() async {
    // Supabase initialization with offline/local fallback
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        publishableKey: supabaseAnonKey,
        debug: false,
      );
    } catch (_) {
      // Allows running offline when Supabase daemon is not started
    }
  }

  static bool get isConfigured {
    try {
      Supabase.instance.client;
      return true;
    } catch (_) {
      return false;
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
}
