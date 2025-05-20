import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/Config.dart';

class ConversationScreen extends StatefulWidget {
  final int threadId;
  final int partnerId;
  final String partnerName;

  const ConversationScreen({
    super.key,
    required this.threadId,
    required this.partnerId,
    required this.partnerName,
  });

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  List<dynamic> messages = [];
  bool isLoading = true;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? userRole;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user_role');
      userId = prefs.getInt('user_id');
      _fetchMessages();
    });
  }

  Future<void> _fetchMessages() async {
    if (userRole == null || userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final baseUrl = userRole == 'visitor_logged' ? '/visitor' : '/entrepreneur';

    try {
      final response = await http.get(
        Uri.parse('${Config.baseApiUrl}$baseUrl/chats/${widget.threadId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Fetch Messages Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages = data['messages'] ?? [];
          isLoading = false;
        });
        _scrollToBottom();
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'] ?? 'Gagal mengambil pesan')),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Fetch Messages Error: ${e}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesan tidak boleh kosong')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final baseUrl = userRole == 'visitor_logged' ? '/visitor' : '/entrepreneur';

    try {
      final response = await http.post(
        Uri.parse('${Config.baseApiUrl}$baseUrl/chats'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'recipient_id': widget.partnerId,
          'message': message,
        }),
      );

      if (response.statusCode == 201) {
        _messageController.clear();
        _fetchMessages(); // Refresh pesan
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'] ?? 'Gagal mengirim pesan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _deleteMessage(int messageId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final baseUrl = userRole == 'visitor_logged' ? '/visitor' : '/entrepreneur';

    try {
      final response = await http.delete(
        Uri.parse('${Config.baseApiUrl}$baseUrl/chats/$messageId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _fetchMessages(); // Refresh pesan setelah penghapusan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pesan berhasil dihapus')),
        );
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'] ?? 'Gagal menghapus pesan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.partnerName),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : messages.isEmpty
                    ? const Center(child: Text('Belum ada pesan'))
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isSender = message['sender_id'] == userId;
                          return Dismissible(
                            key: Key(message['id'].toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) => _deleteMessage(message['id']),
                            child: Align(
                              alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSender ? Colors.blue[100] : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: isSender
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(message['message']),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateTime.parse(message['created_at'])
                                          .toLocal()
                                          .toString()
                                          .substring(0, 16),
                                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ketik pesan...',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}