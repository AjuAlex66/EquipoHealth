import 'package:flutter/material.dart';
import 'package:equipohealth/utils/helper.dart';

class NewsPage extends StatefulWidget {
  final Map<String, String>? news;
  const NewsPage({super.key, required this.news});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news!['title']!),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.news!['image']!,
                  width: Helper.width(),
                  height: Helper.height() / 4,
                  fit: BoxFit.cover,
                )),
            Helper.allowHeight(20),
            Text(
              widget.news!['content']!,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, height: 1.8),
            )
          ],
        ),
      ),
    );
  }
}
