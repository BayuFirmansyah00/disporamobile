import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../core/app_export.dart';
import 'widgets/eventlist_item_widget.dart';
import '../../../models/event_model.dart';
import '../../services/api_service.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<EventModel> events = [];

  Future<void> fetchEvents() async {
    final data = await ApiService.get('events');
    setState(() {
      // events = data.map((e) => EventModel.fromJson(e)).toList();
    });
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
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 28.h,
              vertical: 40.h,
            ), // padding di sini
            itemCount: events.length,
            separatorBuilder: (_, __) => SizedBox(height: 14.h),
            itemBuilder: (context, index) {
              final event = events[index];
              return EventlistItemWidget(
                title: event.title,
                imageUrl: event.image,
                waktu: event.waktu,
                onTapColumnSelengkap: () {
                  Navigator.pushNamed(context, AppRoutes.informasiEventScreen);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}