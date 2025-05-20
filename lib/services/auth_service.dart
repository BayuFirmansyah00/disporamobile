import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../config/config.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: Config.googleClientId,
  );

  Future<Map<String, dynamic>> signInWithGoogle({required String desiredRole}) async {
    try {
      // Check internet connection
      final hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        throw Exception('network');
      }

      debugPrint('Memulai proses login Google sebagai $desiredRole...');

      // Start Google Sign-In
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        debugPrint('Login dibatalkan oleh pengguna');
        throw Exception('Proses login dibatalkan oleh pengguna.');
      }

      debugPrint('Google Sign-In berhasil: ${gUser.email}');

      // Get auth details
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      if (gAuth.idToken == null) {
        debugPrint('ID Token dari Google adalah null!');
        throw Exception('Gagal mendapatkan ID token dari Google.');
      }

      debugPrint('ID Token dari Google: ${gAuth.idToken!.substring(0, 10)}...');

      // Kirim token Google dan desired_role ke backend
      final response = await http.post(
        Uri.parse('${Config.baseApiUrl}/auth/google/mobile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_token': gAuth.idToken,
          'desired_role': desiredRole,
        }),
      );

      debugPrint('Response dari backend: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode != 200) {
        await _googleSignIn.signOut();
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to authenticate on server: ${response.statusCode}');
      }

      final responseData = jsonDecode(response.body);
      debugPrint('Login successful! Role: ${responseData['user']['role']}, ID: ${responseData['user']['id']}');

      // Pastikan user.id ada di respons
      if (responseData['user']['id'] == null) {
        throw Exception('ID pengguna tidak ditemukan di respons backend.');
      }

      return {
        'token': responseData['access_token'] ?? '',
        'role': responseData['user']['role'] ?? desiredRole,
        'user_id': responseData['user']['id'], // Tambahkan user_id
      };
    } catch (e) {
      debugPrint('Error: $e');
      await _googleSignIn.signOut();
      rethrow;
    }
  }

  Future<void> signOut() async {
    debugPrint('Menjalankan proses logout...');
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      // Bersihkan SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_role');
      await prefs.remove('user_id');

      debugPrint('Logout berhasil, SharedPreferences dibersihkan');
    } catch (e) {
      debugPrint('Error saat logout: $e');
      rethrow;
    }
  }

  String getErrorMessage(String error) {
    if (error.contains('network')) {
      return 'Tidak ada koneksi internet.';
    } else if (error.contains('dibatalkan')) {
      return 'Login dibatalkan.';
    } else if (error.contains('Akun Anda terdaftar sebagai')) {
      return error.split(':').last.trim();
    } else if (error.contains('ID Token tidak valid')) {
      return 'Token tidak valid. Coba login kembali.';
    }
    return 'Terjadi kesalahan: ${error.split(':').last.trim()}';
  }

  final _firebaseErrorMessages = {
    'account-exists-with-different-credential': 'Akun sudah terdaftar dengan metode lain.',
    'invalid-credential': 'Kredensial tidak valid.',
    'user-disabled': 'Akun dinonaktifkan.',
    'user-not-found': 'Akun tidak ditemukan.',
    'wrong-password': 'Password salah.',
    'invalid-verification-code': 'Kode verifikasi salah.',
    'invalid-verification-id': 'ID verifikasi salah.',
  };
}