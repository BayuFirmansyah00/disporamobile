import 'dart:convert';
import 'package:ekraf_kuy/models/Event.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/notificationlist_item_widget.dart';
import '../../models/event_model.dart';
import '../../models/Article.dart';
import '../../services/api_service.dart';
import '../../config/config.dart';
import '../informasi_event_screen/informasi_event_screen.dart';
import '../informasi_article.dart/informasi_article_screen.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({Key? key}) : super(key: key);

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  List<EventModel> events = [];
  List<Article> articles = [];
  bool _isLoading = false;
  List<Map<String, dynamic>> combinedItems = [];

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final eventsResult = await ApiService.get(Config.eventsEndpoint);
      List<dynamic> eventsRawList = _parseApiResponse(eventsResult);

      final articlesResult = await ApiService.get(Config.articlesEndpoint);
      List<dynamic> articlesRawList = _parseApiResponse(articlesResult);

      setState(() {
        events = eventsRawList.map((item) => EventModel.fromJson(item as Map<String, dynamic>)).toList();
        articles = articlesRawList.map((item) => Article.fromJson(item as Map<String, dynamic>)).toList();

        combinedItems = [
          ...events.map((e) => {
                'type': 'event',
                'data': {
                  'id': e.id,
                  'title': e.title,
                  'description': e.description ?? 'Tidak ada deskripsi',
                  'image': e.image.isNotEmpty ? e.image : 'https://via.placeholder.com/150',
                  'date': e.createdAt,
                  'formattedDate': e.formattedCreatedAt,
                },
                'event': e,
              }),
          ...articles.map((a) => {
                'type': 'article',
                'data': {
                  'id': a.id,
                  'title': a.title,
                  'description': a.content != null
                      ? a.content!.substring(0, a.content!.length > 100 ? 100 : a.content!.length) + (a.content!.length > 100 ? '...' : '')
                      : 'Tidak ada deskripsi',
                  'thumbnail': a.thumbnail,
                  'date': a.createdAt ?? DateTime.now(),
                  'formattedDate': a.formattedCreatedAt,
                },
                'article': a,
              }),
        ]..sort((a, b) => b['data']['date'].compareTo(a['data']['date']));

        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        events = [];
        articles = [];
        combinedItems = [];
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat notifikasi: ${e.toString()}')),
      );
    }
  }

  List<dynamic> _parseApiResponse(dynamic result) {
    if (result is Map<String, dynamic>) {
      if (result['data'] is Map && result['data']['data'] is List) {
        print('API response: nested data.data structure');
        return result['data']['data'] as List<dynamic>;
      } else if (result['data'] is List) {
        print('API response: direct data list');
        return result['data'] as List<dynamic>;
      } else if (result['events'] is List) {
        print('API response: events list');
        return result['events'] as List<dynamic>;
      } else if (result['articles'] is List) {
        print('API response: articles list');
        return result['articles'] as List<dynamic>;
      } else {
        print('Unknown API response structure: $result');
      }
    } else if (result is List) {
      print('API response: direct list');
      return result;
    } else {
      print('Invalid API response type: $result');
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        title: const Text("Notifikasi"),
      ),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 26.h,
            top: 12.h,
            right: 26.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildNotificationList(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return Expanded(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : combinedItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off, color: Colors.grey, size: 50),
                      const SizedBox(height: 8),
                      Text('Belum ada notifikasi tersedia', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: combinedItems.length,
                  itemBuilder: (context, index) {
                    final item = combinedItems[index];
                    if (item['type'] == 'event') {
                      final eventData = item['data'];
                      final event = item['event'] as EventModel;
                      return NotificationlistItemWidget(
                        title: eventData['title'],
                        description: eventData['description'],
                        imageUrl: eventData['image'],
                        date: eventData['formattedDate'],
                        onTapContainer: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InformasiEventScreen(
                                data: Event(
                                  id: eventData['id'].toString(),
                                  title: eventData['title'],
                                  thumbnail: eventData['image'],
                                  description: eventData['description'] ?? '',
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      final articleData = item['data'];
                      final article = item['article'] as Article;
                      return NotificationlistItemWidget(
                        title: articleData['title'],
                        description: articleData['description'],
                        imageUrl: articleData['thumbnail'],
                        date: articleData['formattedDate'],
                        onTapContainer: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InformasiArticleScreen(
                                data: article,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
    );
  }
}