import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../core/app_export.dart';
import 'widgets/eventlist_item_widget.dart';
import '../../models/event_model.dart';
import '../../services/api_service.dart';
import '../../config/config.dart';
import '../informasi_event_screen/informasi_event_screen.dart'; // Impor InformasiEventScreen
import '../../models/Event.dart' as EventModelFile; // Alias to avoid conflict

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<EventModel> events = [];
  bool _isLoading = false;

  Future<void> fetchEvents() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await ApiService.get(Config.eventsEndpoint);
      print('Raw API Response: ${jsonEncode(result)}');

      List<dynamic> rawList = [];

      if (result is Map<String, dynamic>) {
        if (result['data'] is Map && result['data']['data'] is List) {
          rawList = result['data']['data'] as List<dynamic>;
        } else if (result['events'] is List) {
          rawList = result['events'] as List<dynamic>;
        }
      } else if (result is List) {
        rawList = result;
      }

      setState(() {
        events = rawList.map((item) => EventModel.fromJson(item as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching events: $e');
      setState(() {
        events = [];
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat event: ${e.toString()}')),
      );
    }
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    await fetchEvents();
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          color: Color(0xFF123458),
          backgroundColor: Colors.white,
          height: 120,
          showChildOpacityTransition: false,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : events.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_busy, color: Colors.grey, size: 50),
                          SizedBox(height: 8),
                          Text('Belum ada event tersedia', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 40.h,
                      ),
                      itemCount: events.length,
                      separatorBuilder: (_, __) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        final event = events[index];
                        print('Rendering event: ${event.title}, Image URL: ${event.image}');
                        return EventlistItemWidget(
                          title: event.title,
                          imageUrl: event.image,
                          waktu: event.waktu,
                          onTapColumnSelengkap: () {
                            // Kirim objek Event ke InformasiEventScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InformasiEventScreen(
                                  data: EventModelFile.Event( // Use alias for Event
                                    id: event.id.toString(), // Convert id to String
                                    title: event.title,
                                    thumbnail: event.image,
                                    description: event.description ?? 'Tidak ada deskripsi',
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
        ),
      ),
    );
  }
}