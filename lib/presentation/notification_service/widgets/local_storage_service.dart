import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<void> saveLastArticleId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_article_id', id);
  }

  static Future<int?> getLastArticleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_article_id');
  }

  static Future<void> saveLastEventId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_event_id', id);
  }

  static Future<int?> getLastEventId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_event_id');
  }

  static Future<void> setNotificationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_enabled', enabled);
  }

  static Future<bool> isNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notif_enabled') ?? true;
  }

  static Future<void> saveLastChatId(String chatId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_chat_id', chatId);
  }

  static Future<String?> getLastChatId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_chat_id');
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role'); // misalnya disimpan saat login
  }
}
