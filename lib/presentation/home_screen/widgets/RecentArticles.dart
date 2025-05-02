import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/robust_image.dart';

class RecentArticles extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTapSektorunggulan;

  const RecentArticles({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.onTapSektorunggulan,
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
            child: RobustImage(url: imageUrl),
            ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onTapSektorunggulan,
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
                    child:Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
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