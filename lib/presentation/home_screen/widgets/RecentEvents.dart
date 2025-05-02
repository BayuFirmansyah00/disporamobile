// recent_events.dart
import 'package:flutter/material.dart';
import '../../../widgets/robust_image.dart'; // Sesuaikan path

class RecentEvents extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTapRowsunglasses;

  const RecentEvents({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.onTapRowsunglasses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 152,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: RobustImage(url: imageUrl), // <-- Gunakan di sini
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onTapRowsunglasses,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}