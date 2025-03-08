import 'package:flutter/material.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: Icon(Icons.tune, color: Colors.grey[600]),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                NotificationItem(
                  imagePath: 'assets/mimi_event.jpg',
                  title: 'Informasi Event',
                  description: 'Pentas pantomim tingkat kabupaten nganjuk...',
                ),
                NotificationItem(
                  imagePath: 'assets/notification_image2.jpg',
                  title: 'Informasi Event',
                  description: 'Bazar bertujuan untuk meningkatkan kabupaten nganjuk...',
                ),
                NotificationItem(
                  imagePath: 'assets/notification_image3.jpg',
                  title: 'Informasi Event',
                  description: 'Warga kabupaten Nganjuk menggelar pesta...',
                ),
                NotificationItem(
                  imagePath: 'assets/notification_image4.jpg',
                  title: 'Seminar webinar bersama sonia damanik...',
                  description: '',
                ),
                NotificationItem(
                  imagePath: 'assets/notification_image5.jpg',
                  title: 'Workshop fotografi untuk kalangan remaja yang bertujuan...',
                  description: '',
                ),
                NotificationItem(
                  imagePath: 'assets/notification_image6.jpg',
                  title: 'Informasi Event',
                  description: 'Sharing seputar dunia desain & Digital...',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const NotificationItem({super.key, required this.imagePath, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}