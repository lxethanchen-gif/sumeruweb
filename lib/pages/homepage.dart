import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ─────────────────────────────────────────────
// 資料模型
// ─────────────────────────────────────────────

class LinkItem {
  const LinkItem({required this.title, required this.url});
  final String title;
  final String url;
}

// ─────────────────────────────────────────────
// 常數集中管理
// ─────────────────────────────────────────────

abstract class AppConstants {
  static const String liveUrl =
      'https://www.youtube.com/live/gj4mSg0ElRA?si=UWBx-Au9RXucP5nQ';
  static const String fallbackVideoId = 'gj4mSg0ElRA';
  static const Color gold = Color.fromARGB(255, 246, 214, 30);
  static const double maxContentWidth = 1000.0;
  static const double mobileBreakpoint = 600.0;
  static const double desktopBreakpoint = 1100.0;
}

// ─────────────────────────────────────────────
// 頁籤資料
// ─────────────────────────────────────────────

abstract class TabData {
  static const List<String> titles = [
    '最新消息',
    '影音開示',
    '應世卷',
    '滅罪卷',
    '機緣道旨',
    '詩摘',
  ];

  static const Map<String, List<LinkItem>> content = {
    '最新消息': [
      LinkItem(title: '2026年5月最新開示公告', url: 'https://example.com'),
      LinkItem(title: '近期修持活動說明', url: 'https://example.com'),
    ],
    '影音開示': [
      LinkItem(title: '諦深佛陀開示影片集錦（一）', url: 'https://youtube.com'),
      LinkItem(title: '諦深佛陀開示影片集錦（二）', url: 'https://youtube.com'),
    ],
    '應世卷': [
      LinkItem(title: '應世卷第一章', url: 'https://example.com'),
      LinkItem(title: '應世卷第二章', url: 'https://example.com'),
    ],
    '滅罪卷': [
      LinkItem(title: '滅罪卷導讀（上）', url: 'https://example.com'),
      LinkItem(title: '滅罪卷導讀（下）', url: 'https://example.com'),
    ],
    '機緣道旨': [
      LinkItem(title: '機緣道旨要義（一）', url: 'https://example.com'),
      LinkItem(title: '機緣道旨要義（二）', url: 'https://example.com'),
    ],
    '詩摘': [
      LinkItem(title: '諦深佛陀詩集選讀（上）', url: 'https://example.com'),
      LinkItem(title: '諦深佛陀詩集選讀（下）', url: 'https://example.com'),
    ],
  };
}

// ─────────────────────────────────────────────
// HomePage
// ─────────────────────────────────────────────

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    final videoId =
        YoutubePlayerController.convertUrlToId(AppConstants.liveUrl) ??
        AppConstants.fallbackVideoId;

    _ytController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );
  }

  @override
  void dispose() {
    _ytController.close();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('無法開啟網址：$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabData.titles.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: YoutubePlayerScaffold(
            controller: _ytController,
            builder: (context, player) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final contentWidth = w > AppConstants.desktopBreakpoint
                      ? AppConstants.maxContentWidth
                      : w * 0.95;
                  final isMobile = w < AppConstants.mobileBreakpoint;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: contentWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ── 標題 ──
                            _PageTitle(isMobile: isMobile),
                            const SizedBox(height: 32),

                            // ── 播放器 ──
                            _VideoCard(player: player),
                            const SizedBox(height: 48),

                            // ── 頁籤區 ──
                            _TabSection(
                              isMobile: isMobile,
                              onLinkTap: _launchURL,
                            ),
                          ],
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

// ─────────────────────────────────────────────
// 子元件：頁面標題
// ─────────────────────────────────────────────

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Text(
      '諦深佛陀 2026年5月29日\n現場直播開示',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: isMobile ? 22 : 30,
        fontWeight: FontWeight.bold,
        color: AppConstants.gold,
        letterSpacing: 1.5,
        height: 1.4,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 子元件：影片卡片
// ─────────────────────────────────────────────

class _VideoCard extends StatelessWidget {
  const _VideoCard({required this.player});
  final Widget player;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: player,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 子元件：頁籤區塊
// ─────────────────────────────────────────────

class _TabSection extends StatelessWidget {
  const _TabSection({
    required this.isMobile,
    required this.onLinkTap,
  });

  final bool isMobile;
  final ValueChanged<String> onLinkTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar
        TabBar(
          isScrollable: isMobile,
          tabAlignment:
              isMobile ? TabAlignment.start : TabAlignment.center,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          tabs: TabData.titles.asMap().entries.map((e) => _GoldTab(title: e.value, index: e.key)).toList(),
        ),
        const SizedBox(height: 24),

        // TabBarView — 固定高度避免 unbounded height 問題
        SizedBox(
          height: 320,
          child: TabBarView(
            children: TabData.titles.map((tabTitle) {
              final items = TabData.content[tabTitle] ?? [];
              return _LinkList(items: items, onTap: onLinkTap);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 子元件：金色頁籤外框（選中/未選中自動切換樣式）
// ─────────────────────────────────────────────

class _GoldTab extends StatelessWidget {
  const _GoldTab({required this.title, required this.index});
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        final isSelected = tabController.index == index;
        return Tab(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppConstants.gold : Colors.transparent,
              border: Border.all(color: AppConstants.gold, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : AppConstants.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// 子元件：連結清單
// ─────────────────────────────────────────────

class _LinkList extends StatelessWidget {
  const _LinkList({required this.items, required this.onTap});
  final List<LinkItem> items;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          '尚無內容',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(
        color: AppConstants.gold.withOpacity(0.2),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () => onTap(item.url),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppConstants.gold,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: AppConstants.gold,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}