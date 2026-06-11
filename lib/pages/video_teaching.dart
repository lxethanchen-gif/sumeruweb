import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoTeachingsPage extends StatelessWidget {
  const VideoTeachingsPage({super.key});

  static const List<Map<String, String>> _videos = [
    {
      'id': 'jIv-IhC-RHM',
      'title': '佛法開示 · 第一講',
      'url': 'https://youtu.be/jIv-IhC-RHM?si=UL5mEo9ocRIy9B9E',
    },
    {
      'id': 'jNpw-iPF0rM',
      'title': '佛法開示 · 第二講',
      'url': 'https://youtu.be/jNpw-iPF0rM?si=angt5oINgkzEfrzL',
    },
    {
      'id': 'LzXGz8eaJC0',
      'title': '佛法開示 · 第三講',
      'url': 'https://youtu.be/LzXGz8eaJC0?si=2zKCMwPZrM4uS4kG',
    },
  ];

  /// RWD: 依寬度決定每列幾欄
  int _crossAxisCount(double width) {
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    if (width >= 400) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = _crossAxisCount(width);
        const spacing = 16.0;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: _videos.map((video) {
              final cardWidth =
                  (width - 32 - spacing * (columns - 1)) / columns;
              return _VideoCard(video: video, width: cardWidth);
            }).toList(),
          ),
        );
      },
    );
  }
}

class _VideoCard extends StatelessWidget {
  final Map<String, String> video;
  final double width;

  const _VideoCard({required this.video, required this.width});

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl =
        'https://img.youtube.com/vi/${video['id']}/hqdefault.jpg';
    // 16:9 縮圖高度
    final thumbHeight = width * 9 / 16;

    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(video['url']!);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail + play overlay
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    thumbnailUrl,
                    width: width,
                    height: thumbHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: width,
                      height: thumbHeight,
                      color: const Color(0xFFF0F0F0),
                      child: const Icon(Icons.broken_image,
                          size: 40, color: Colors.grey),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 28),
                  ),
                ],
              ),
              // Title
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  video['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}