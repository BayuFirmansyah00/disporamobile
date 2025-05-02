// robust_image.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';

final dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 30),
  headers: {
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=30, max=1000",
  },
))
..interceptors.add(LogInterceptor(responseBody: false));

class RobustImage extends StatelessWidget {
  final String url;
  
  const RobustImage({super.key, required this.url});

  Future<Uint8List> _fetchImageWithRetry() async {
    int retryCount = 0;
    while (retryCount < 3) {
      try {
        final response = await dio.get(
          url,
          options: Options(responseType: ResponseType.bytes),
        );
        return Uint8List.fromList(response.data);
      } catch (e) {
        retryCount++;
        await Future.delayed(const Duration(seconds: 1));
        if (retryCount == 3) rethrow;
      }
    }
    throw Exception('Max retries reached');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchImageWithRetry(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        } else if (snapshot.hasError) {
          return Column(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const Text('Gagal memuat gambar', style: TextStyle(fontSize: 12)),
              ElevatedButton(
                onPressed: () => _fetchImageWithRetry(),
                child: const Text('Coba Lagi'),
              ),
            ],
          );
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(color: Colors.white),
        );
      },
    );
  }
}