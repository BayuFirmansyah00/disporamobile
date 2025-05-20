import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoadingEntrepreneur = false;
  bool _isLoadingVisitor = false;
  final AuthService _authService = AuthService();

  Future<void> _handleGoogleLogin({required String desiredRole}) async {
    if (_isLoadingEntrepreneur || _isLoadingVisitor) return;

    setState(() {
      if (desiredRole == 'entrepreneur') {
        _isLoadingEntrepreneur = true;
      } else {
        _isLoadingVisitor = true;
      }
    });

    try {
      final result = await _authService.signInWithGoogle(desiredRole: desiredRole);
      final token = result['token'];
      final role = result['role'];
      final userId = result['user_id'];

      debugPrint('Login berhasil! Token: ${token.substring(0, 10)}... Role: $role, User ID: $userId');

      // Simpan token, role, dan user_id di SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    debugPrint('SharedPreferences dihapus');
      await prefs.setString('auth_token', token);
      debugPrint('Token disimpan: ${token.substring(0, 10)}...');
      final savedToken = await prefs.getString('auth_token');
      debugPrint('Token yang diambil: ${savedToken != null && savedToken.length > 10 ? savedToken.substring(0, 10) : savedToken}...');
      await prefs.setString('user_role', role);
      await prefs.setInt('user_id', userId);

      // Verifikasi data yang disimpan
      debugPrint('Data disimpan - Role: ${await prefs.getString('user_role')}');
      debugPrint('Data disimpan - User ID: ${await prefs.getInt('user_id')}');

      if (!mounted) return;

      // Navigasi berdasarkan role
      if (role == 'entrepreneur') {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.pelakuUsahaScreen,
          (route) => false,
        );
      } else if (role == 'visitor_logged') {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.visitorScreen,
          (route) => false,
        );
      } else {
        await _authService.signOut();
        if (mounted) {
          _showErrorMessage('Role tidak valid untuk login.');
        }
      }
    } catch (e) {
      debugPrint('Error login: $e');
      if (mounted) {
        _showErrorMessage(_authService.getErrorMessage(e.toString()));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingEntrepreneur = false;
          _isLoadingVisitor = false;
        });
      }
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.rocket_launch, size: 100, color: Colors.blue),
                    const SizedBox(height: 32),
                    const Text(
                      'Selamat Datang 👋',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Silakan pilih metode login',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _isLoadingEntrepreneur
                          ? null
                          : () => _handleGoogleLogin(desiredRole: 'entrepreneur'),
                      icon: _isLoadingEntrepreneur
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.login),
                      label: Text(_isLoadingEntrepreneur
                          ? 'Sedang Masuk...'
                          : 'Login sebagai Pelaku Usaha'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _isLoadingVisitor
                          ? null
                          : () => _handleGoogleLogin(desiredRole: 'visitor_logged'),
                      icon: _isLoadingVisitor
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.login),
                      label: Text(_isLoadingVisitor
                          ? 'Sedang Masuk...'
                          : 'Login sebagai Pengunjung'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}