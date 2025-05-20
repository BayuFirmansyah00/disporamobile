import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../core/app_export.dart';
import 'widgets/articlelist_item_widget.dart';
import '../../models/Article.dart';
import '../../services/api_service.dart';
import '../../config/config.dart';
import '../informasi_article.dart/informasi_article_screen.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> articles = [];
  bool _isLoading = false;

  Future<void> fetchArticles() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await ApiService.get(Config.articlesEndpoint);
      print('Raw API Response: ${jsonEncode(result)}');

      List<dynamic> rawList = [];

      if (result is Map<String, dynamic>) {
        if (result['data'] is Map && result['data']['data'] is List) {
          rawList = result['data']['data'] as List<dynamic>;
        } else if (result['articles'] is List) {
          rawList = result['articles'] as List<dynamic>;
        }
      } else if (result is List) {
        rawList = result;
      }

      setState(() {
        articles = rawList.map((item) => Article.fromJson(item as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching articles: $e');
      setState(() {
        articles = [];
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat artikel: ${e.toString()}')),
      );
    }
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    await fetchArticles();
  }

  @override
  void initState() {
    super.initState();
    fetchArticles();
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
              : articles.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article_outlined, color: Colors.grey, size: 50),
                          SizedBox(height: 8),
                          Text('Belum ada artikel tersedia', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 40.h,
                      ),
                      itemCount: articles.length,
                      separatorBuilder: (_, __) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        print('Rendering article: ${article.title}, Image URL: ${article.thumbnail}');
                        return ArticlelistItemWidget(
                          title: article.title,
                          imageUrl: article.thumbnail,
                          description: article.content,
                          onTapColumnSelengkap: () {
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
                      },
                    ),
        ),
      ),
    );
  }
}