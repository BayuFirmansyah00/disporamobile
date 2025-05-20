import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/Config.dart';
import '../ConversationScreen.dart/ConversationScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> _chatMessages = [];
  bool isLoadingChats = false;

  @override
  void initState() {
    super.initState();
    _fetchChats();
  }

  Future<void> _fetchChats() async {
    if (!mounted) return;

    setState(() {
      isLoadingChats = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userRole = prefs.getString('user_role');
    final userId = prefs.getInt('user_id');

    if (token == null || userRole == null || userId == null) {
      if (mounted) {
        setState(() {
          isLoadingChats = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Token, role, atau user ID tidak ditemukan')),
        );
      }
      return;
    }

    final baseUrl = userRole == 'visitor_logged' ? '/visitor/chats' : '/entrepreneur/chats';

    try {
      final response = await http.get(
        Uri.parse('${Config.baseApiUrl}$baseUrl'),
        headers: {'Authorization': 'Bearer $token'},
      );

      debugPrint('Fetch Chats Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200 && mounted) {
        final data = jsonDecode(response.body);
        setState(() {
          // Handle the response data
          if (data is List) {
            // Explicitly cast each item to Map<String, dynamic>
            _chatMessages = data.map((item) => item as Map<String, dynamic>).toList();
          } else if (data is Map && data['data'] is List) {
            _chatMessages = (data['data'] as List).map((item) => item as Map<String, dynamic>).toList();
          } else {
            _chatMessages = [];
          }
          isLoadingChats = false;
        });
      } else if (mounted) {
        setState(() {
          isLoadingChats = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil daftar chat: ${response.body}')),
        );
      }
    } catch (e) {
      debugPrint('Fetch Chats Error: $e');
      if (mounted) {
        setState(() {
          isLoadingChats = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: isLoadingChats
          ? const Center(child: CircularProgressIndicator())
          : _chatMessages.isEmpty
              ? const Center(child: Text('Belum ada percakapan'))
              : ListView.builder(
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    final thread = _chatMessages[index];
                    return ListTile(
                      title: Text(thread['partner_name']?.toString() ?? 'Unknown Partner'),
                      subtitle: Text(thread['last_message']?.toString() ?? 'Belum ada pesan'),
                      onTap: () {
                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConversationScreen(
                                threadId: thread['thread_id'],
                                partnerId: thread['partner_id'],
                                partnerName: thread['partner_name']?.toString() ?? 'Unknown Partner',
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
    );
  }
}