import 'dart:convert';
import 'package:ekraf_kuy/config/config.dart';
import 'package:http/http.dart' as http;
import '../../../models/Article.dart';
import '../../../models/Event.dart';
import 'local_storage_service.dart';
import '../notification_service.dart';

Future<void> checkNewArticlesAndEvents() async {
  // Check if notifications are enabled
  if (!await LocalStorageService.isNotificationEnabled()) {
    print('Notifications are disabled, skipping check.');
    return;
  }

  // Fetch and process articles
  try {
    final articleResponse = await http.get(Uri.parse('${Config.baseApiUrl}/${Config.articlesEndpoint}'));
    print('Article Request URL: ${articleResponse.request?.url}');
    print('Article Response Status: ${articleResponse.statusCode}');
    print('Article Response Body: ${articleResponse.body}');

    if (articleResponse.statusCode == 200) {
      final jsonData = jsonDecode(articleResponse.body) as Map<String, dynamic>;
      final articleList = jsonData['articles'] as List<dynamic>;
      final articles = articleList.map((item) => Article.fromJson(item)).toList();

      if (articles.isNotEmpty) {
        final latestArticle = articles.first;
        final lastSavedId = await LocalStorageService.getLastArticleId() ?? 0;
        final currentArticleId = int.tryParse(latestArticle.id) ?? 0;

        if (currentArticleId > lastSavedId) {
          print('New article found: ${latestArticle.title} (ID: $currentArticleId)');
          await NotificationService.showArticleNotification(latestArticle);
          await LocalStorageService.saveLastArticleId(currentArticleId);
        } else {
          print('No new articles (current ID: $currentArticleId, last saved: $lastSavedId)');
        }
      } else {
        print('No articles found in response');
      }
    } else {
      print('Failed to fetch articles: ${articleResponse.statusCode}');
    }
  } catch (e) {
    print('Error fetching articles: $e');
  }

  // Fetch and process events
  try {
    final eventResponse = await http.get(Uri.parse('${Config.baseApiUrl}/${Config.eventsEndpoint}'));
    print('Event Request URL: ${eventResponse.request?.url}');
    print('Event Response Status: ${eventResponse.statusCode}');
    print('Event Response Body: ${eventResponse.body}');

    if (eventResponse.statusCode == 200) {
      final jsonData = jsonDecode(eventResponse.body) as Map<String, dynamic>;
      final eventList = jsonData['data']['data'] as List<dynamic>;
      final events = eventList.map((item) => Event.fromJson(item)).toList();

      if (events.isNotEmpty) {
        final latestEvent = events.first;
        final lastSavedId = await LocalStorageService.getLastEventId() ?? 0;
        final currentEventId = int.tryParse(latestEvent.id) ?? 0;

        if (currentEventId > lastSavedId) {
          print('New event found: ${latestEvent.title} (ID: $currentEventId)');
          await NotificationService.showEventNotification(latestEvent);
          await LocalStorageService.saveLastEventId(currentEventId);
        } else {
          print('No new events (current ID: $currentEventId, last saved: $lastSavedId)');
        }
      } else {
        print('No events found in response');
      }
    } else {
      print('Failed to fetch events: ${eventResponse.statusCode}');
    }
  } catch (e) {
    print('Error fetching events: $e');
  }

  try {
  final userRole = await LocalStorageService.getUserRole(); // Implementasi ambil role user
  print('User role: $userRole');
  String chatEndpoint;

  if (userRole == 'visitor') {
    chatEndpoint = Config.visitorChatsEndpoint;
  } else if (userRole == 'entrepreneur') {
    chatEndpoint = Config.entrepreneurChatsEndpoint;
  } else {
    print('Unknown user role: $userRole');
    return;
  }

  final chatResponse = await http.get(Uri.parse('${Config.baseApiUrl}/$chatEndpoint'));
  print('Chat Request URL: ${chatResponse.request?.url}');
  print('Chat Response Status: ${chatResponse.statusCode}');
  print('Chat Response Body: ${chatResponse.body}');

  if (chatResponse.statusCode == 200) {
    final jsonData = jsonDecode(chatResponse.body) as Map<String, dynamic>;
    final chatList = jsonData['chats'] as List<dynamic>;

    if (chatList.isNotEmpty) {
      for (var chatJson in chatList) {
        final chatId = chatJson['id'] as String;
        final sender = chatJson['sender'] as String;
        final message = chatJson['message'] as String;

        final lastChatId = await LocalStorageService.getLastChatId() ?? '';
        if (chatId != lastChatId) {
          print('New chat message from $sender (Chat ID: $chatId)');
          await NotificationService.showChatNotification(chatId, sender, message);
          await LocalStorageService.saveLastChatId(chatId);
        } else {
          print('No new chat messages');
        }
      }
    } else {
      print('No chats found in response');
    }
  } else {
    print('Failed to fetch chats: ${chatResponse.statusCode}');
  }
} catch (e) {
  print('Error fetching chats: $e');
}
}