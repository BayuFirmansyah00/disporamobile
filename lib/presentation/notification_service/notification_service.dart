import 'dart:io';
import 'package:ekraf_kuy/config/config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../notification_service/widgets/local_storage_service.dart';
import '../../models/Event.dart';
import '../../models/Article.dart';
import '../informasi_event_screen/informasi_event_screen.dart';
import '../informasi_article.dart/informasi_article_screen.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Global navigator key for navigation without context
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          final payload = response.payload!.split(':');
          if (payload.length == 2) {
            final type = payload[0];
            final id = payload[1];
            await _handleNotificationTap(type, id);
          }
        }
      },
    );

    // Request notification permission for Android 13+
    if (Platform.isAndroid) {
      final permission = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      if (permission != true) {
        print('Notification permission denied');
      }
    }
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String channelId = 'default_channel',
    String channelName = 'Default Notifications',
  }) async {
    // Check if notifications are enabled
    if (!await LocalStorageService.isNotificationEnabled()) {
      print('Notifications disabled, skipping.');
      return;
    }

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      styleInformation: BigTextStyleInformation(body),
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future<void> showChatNotification(String chatId, String sender, String message) async {
  final notificationId = chatId.hashCode & 0x7FFFFFFF;
  await showNotification(
    id: notificationId,
    title: 'Pesan Baru dari $sender',
    body: message,
    payload: 'chat:$chatId',
    channelId: 'chat_channel',
    channelName: 'Chat Notifications',
  );
}


  static Future<void> showEventNotification(Event event) async {
    // final notificationId = int.parse(event.id.hashCode.toString().substring(0, 8));
    final notificationId = event.id.hashCode & 0x7FFFFFFF; 
    await showNotification(
      id: notificationId,
      title: 'New Event: ${event.title}',
      body: event.description ?? 'Check out this new event!',
      payload: 'event:${event.id}',
      channelId: 'event_channel',
      channelName: 'Event Notifications',
    );
  }

  static Future<void> showArticleNotification(Article article) async {
    // final notificationId = int.parse(article.id.hashCode.toString().substring(0, 8));
    final notificationId = article.id.hashCode & 0x7FFFFFFF; 
    await showNotification(
      id: notificationId,
      title: 'New Article: ${article.title}',
      body: article.content ?? 'Read this new article!',
      payload: 'article:${article.id}',
      channelId: 'article_channel',
      channelName: 'Article Notifications',
    );
  }

  static Future<void> _handleNotificationTap(String type, String id) async {
    final context = navigatorKey.currentState?.context;
    if (context == null) {
      print('Navigator context is null');
      return;
    }

    try {
      if (type == 'event') {
        // Fetch event data from API
        final response = await http.get(Uri.parse('${Config.baseApiUrl}/${Config.eventsEndpoint}'));
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final event = await Event.fromJson(jsonData);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformasiEventScreen(
                data: event, // Pass the Event object directly
              ),
            ),
          );
        } else {
          print('Failed to fetch event: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memuat detail event')),
          );
        }
      } else if (type == 'article') {
        // Fetch article data from API
        final response = await http.get(Uri.parse('${Config.baseApiUrl}/${Config.articlesEndpoint}'));
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final article = await Article.fromJson(jsonData);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformasiArticleScreen(
                data: article, // Pass the Article object directly
              ),
            ),
          );
        } else {
          print('Failed to fetch article: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memuat detail artikel')),
          );
        }
      }
    } catch (e) {
      print('Error handling notification tap: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }
}