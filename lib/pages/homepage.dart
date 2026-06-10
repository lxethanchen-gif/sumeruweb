import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart'; // 記得在 pubspec.yaml 加入此套件

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

// 定義連結資料模型
class LinkItem {
  final String title;
  final String url;
  LinkItem(this.title, this.url);
}

class _HomePageState extends State<HomePage> {
  final String _url =
      'https://www.youtube.com/live/gj4mSg0ElRA?si=UWBx-Au9RXucP5nQ';
  late YoutubePlayerController _ytController;
  final Color _gold = const Color.fromARGB(255, 246, 214, 30);
  final List<String> _tabs = ['最新消息', '影音開示', '應世卷', '滅罪卷', '機緣道旨', '詩摘'];

  // 模擬各頁籤的資料
  final Map<String, List<LinkItem>> _tabContent = {
    '最新消息': [
      LinkItem('2026年5月最新開示公告', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
    ],
    '影音開示': [
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
      LinkItem('諦深佛陀開示影片集錦', 'https://youtube.com'),
    ],
    '應世卷': [
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
    ],
    '滅罪卷': [
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
    ],
    '機緣道旨': [
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
    ],
    '詩摘': [
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
    ],
  };

  @override
  void initState() {
    super.initState();
    _ytController = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(_url) ?? 'gj4mSg0ElRA',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _ytController.close();
    super.dispose();
  }

  // 點擊開啟連結的方法
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: _tabs.length,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              clipBehavior: Clip.none,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '諦深佛陀 2026年5月29日 現場直播開示',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: w > 600 ? 32 : 24,
                            fontWeight: FontWeight.bold,
                            color: _gold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 35),
                        Container(
                          width: w > 1100 ? 1000 : w * 0.95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: YoutubePlayer(
                            controller: _ytController,
                            aspectRatio: 16 / 9,
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: w > 1100 ? 1000 : w * 0.95,
                          child: Column(
                            children: [
                              TabBar(
                                isScrollable: w < 600,
                                tabAlignment: w < 600
                                    ? TabAlignment.start
                                    : TabAlignment.center,
                                dividerColor: Colors.transparent,
                                labelColor: Colors.white,
                                unselectedLabelColor: _gold,
                                indicator: BoxDecoration(
                                  color: _gold,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                overlayColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                                tabs: _tabs
                                    .map(
                                      (title) => Tab(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _gold.withOpacity(0.05),
                                            border: Border.all(
                                              color: _gold,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: Text(title),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                height: 300,
                                child: TabBarView(
                                  children: _tabs.map((tabTitle) {
                                    final items = _tabContent[tabTitle] ?? [];
                                    return ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        final item = items[index];
                                        return InkWell(
                                          onTap: () => _launchURL(item.url),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              item.title,
                                              style: TextStyle(
                                                color: _gold,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
