import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;
import 'dart:async';
import 'footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class LinkItem {
  final String title;
  final String url;
  const LinkItem(this.title, this.url);
}

class _HomePageState extends State<HomePage> {
  final Color _gold = const Color.fromARGB(255, 246, 214, 30);
  final Color _goldDim = const Color.fromARGB(90, 246, 214, 30);

  final List<String> _carouselImages = [
    'assets/images/2453.jpg',
    'assets/images/6176_0.jpg',
    'assets/images/6175_0.jpg',
    'assets/images/6176_0.jpg',
    'assets/images/6177_0.jpg',
    'assets/images/6178_0.jpg',
    'assets/images/6179_0.jpg',
    'assets/images/6181_0.jpg',
    'assets/images/6182_0.jpg',
    'assets/images/6183_0.jpg',
    'assets/images/6184_0.jpg',
    'assets/images/6185_0.jpg',
    'assets/images/6186_0.jpg',
    'assets/images/6187_0.jpg',
    'assets/images/6188_0.jpg',
    'assets/images/6189_0.jpg',
    'assets/images/6190_0.jpg',
    'assets/images/6191_0.jpg',
    'assets/images/6192_0.jpg',
    'assets/images/6193_0.jpg',
    'assets/images/6194_0.jpg',
    'assets/images/6195_0.jpg',
    'assets/images/6196_0.jpg',
    'assets/images/6197_0.jpg',
    'assets/images/6198_0.jpg',
    'assets/images/6199_0.jpg',
    'assets/images/6200_0.jpg',
    'assets/images/6201_0.jpg',
  ];

  late PageController _carouselController;
  int _currentCarouselIndex = 0;
  Timer? _carouselTimer;
  bool _userInteracting = false;

  static bool _iframeRegistered = false;

  static const List<LinkItem> _news = [
    LinkItem('2026年5月最新開示公告', 'https://example.com'),
    LinkItem('近期修持活動說明', 'https://example.com'),
  ];

  static const List<LinkItem> _videos = [
    LinkItem('諦深佛陀開示 2020年3月7日', 'https://youtu.be/2z26miBEBkA'),
    LinkItem('諦深佛陀開示 2020年3月14日', 'https://youtu.be/aYdmafP7HMY'),
    LinkItem('諦深佛陀開示 2020年3月21日', 'https://youtu.be/3uGgjYDmhUA'),
    LinkItem('諦深佛陀開示 2020年3月28日', 'https://youtu.be/stTdG5iHhjE'),
    LinkItem('諦深佛陀開示 2020年4月4日', 'https://youtu.be/5C4nQcL9LQQ'),
    LinkItem('諦深佛陀開示 2020年4月11日', 'https://youtu.be/H1lleUTetsQ'),
    LinkItem('諦深佛陀開示 2020年4月18日', 'https://youtu.be/aBnWRe6MuMo'),
    LinkItem('諦深佛陀開示 2020年4月25日', 'https://youtu.be/LJyHPuiF8UQ'),
    LinkItem('諦深佛陀開示 2020年4月26日', 'https://youtu.be/yPiOy9NjS_c'),
    LinkItem('諦深佛陀開示 2020年5月2日', 'https://youtu.be/eqKls8wUiPY'),
    LinkItem('諦深佛陀開示 2020年5月9日', 'https://youtu.be/XBeCi0JORV0'),
    LinkItem('諦深佛陀開示 2020年5月16日', 'https://youtu.be/nj711RpHviw'),
    LinkItem('諦深佛陀開示 2020年5月23日', 'https://youtu.be/QuQSeUm7N9M'),
    LinkItem('諦深佛陀開示 2020年5月30日', 'https://youtu.be/rfsX-E7Il5w'),
    LinkItem('諦深佛陀開示 2020年6月6日', 'https://youtu.be/dJhRgdfS6iU'),
    LinkItem('諦深佛陀開示 2020年6月13日', 'https://youtu.be/262NEBlWEqg'),
    LinkItem('諦深佛陀開示 2020年6月20日', 'https://youtu.be/j6mM4OQ9MCk'),
    LinkItem('諦深佛陀開示 2020年6月27日', 'https://youtu.be/H3VNj1IN6cQ'),
    LinkItem('諦深佛陀開示 2020年7月4日', 'https://youtu.be/rX3999zfw00'),
    LinkItem('諦深佛陀開示 2020年7月11日', 'https://youtu.be/DnQG3YtISs8'),
    LinkItem('諦深佛陀開示 2020年7月18日', 'https://youtu.be/g28d1S926Rc'),
    LinkItem('諦深佛陀開示 2020年7月25日', 'https://youtu.be/txzLgfTEPXk'),
    LinkItem('諦深佛陀開示 2020年8月1日', 'https://youtu.be/Xa8oQYBxK9Q'),
    LinkItem('諦深佛陀開示 2020年8月8日', 'https://youtu.be/AOAS242oUlE'),
    LinkItem('諦深佛陀開示 2020年8月15日', 'https://youtu.be/oDjIuDkA9tg'),
    LinkItem('諦深佛陀開示 2020年8月22日', 'https://youtu.be/pIRPa9gNFqA'),
    LinkItem('諦深佛陀開示 2020年8月29日', 'https://youtu.be/jIv-IhC-RHM'),
    LinkItem('諦深佛陀開示 2020年9月5日', 'https://youtu.be/gIpKP3KP48c'),
    LinkItem('諦深佛陀開示 2020年9月12日', 'https://youtu.be/G3Ncx7iwImU'),
    LinkItem('諦深佛陀開示 2020年9月19日', 'https://youtu.be/vnzcDNC4XFg'),
    LinkItem('諦深佛陀開示 2020年9月26日', 'https://youtu.be/NugoxAuPvzA'),
    LinkItem('諦深佛陀開示 2020年10月3日', 'https://youtu.be/RRopQZdX45k'),
    LinkItem('諦深佛陀開示 2020年10月10日', 'https://youtu.be/Kk_GO7LC8q0'),
    LinkItem('諦深佛陀開示 2020年10月17日', 'https://youtu.be/M5wu_DWiPS8'),
    LinkItem('諦深佛陀開示 2020年10月24日', 'https://youtu.be/IqhBwhYHC_k'),
    LinkItem('諦深佛陀開示 2020年10月31日', 'https://youtu.be/Vhm19TQjp68'),
    LinkItem('諦深佛陀開示 2020年11月7日', 'https://youtu.be/Y_dzD41G7ow'),
    LinkItem('諦深佛陀開示 2020年11月14日', 'https://youtu.be/7Vd8-bBqEoM'),
    LinkItem('諦深佛陀開示 2020年11月21日', 'https://youtu.be/3PKymWBy4xg'),
    LinkItem('諦深佛陀開示 2020年11月28日', 'https://youtu.be/nday-JJ-Cww'),
    LinkItem('諦深佛陀開示 2020年12月5日', 'https://youtu.be/w3_FQTXuqFg'),
    LinkItem('諦深佛陀開示 2020年12月12日', 'https://youtu.be/eWIi69l28dE'),
    LinkItem('諦深佛陀開示 2020年12月19日', 'https://youtu.be/W684lpOKESQ'),
    LinkItem('諦深佛陀開示 2020年12月26日', 'https://youtu.be/XQVCQvpi3RM'),
    LinkItem('諦深佛陀開示 2020年12月31日', 'https://youtu.be/AwoN9zqdpHE'),
    LinkItem('諦深佛陀開示 2021年1月2日', 'https://youtu.be/ffC1-37WU5U'),
    LinkItem('諦深佛陀開示 2021年1月9日', 'https://youtu.be/e-T5aXiY4Fc'),
    LinkItem('諦深佛陀開示 2021年1月16日', 'https://youtu.be/MzoUsZvr4Us'),
  ];

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();
    _startCarouselTimer();
    _registerIframe();
  }

  void _startCarouselTimer() {
    _carouselTimer?.cancel();
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || _userInteracting) return;
      if (!_carouselController.hasClients) return;
      final next = (_currentCarouselIndex + 1) % _carouselImages.length;
      _carouselController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  void _registerIframe() {
    if (_iframeRegistered) return;
    _iframeRegistered = true;
    ui.platformViewRegistry.registerViewFactory(
      'youtube-player',
      (int viewId) => html.IFrameElement()
        ..src = 'https://www.youtube.com/embed/ew0PgNXOrQk?autoplay=0'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..setAttribute(
          'allow',
          'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
        )
        ..allowFullscreen = true,
    );
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ── 輪播圖 ────────────────────────────────────────────────
  Widget _buildCarousel(double contentWidth) {
    // RWD：寬螢幕 16:9，窄螢幕(<480) 4:3
    final isNarrow = contentWidth < 480;
    final aspectRatio = isNarrow ? (4 / 3) : (16 / 9);
    final carouselHeight = contentWidth * (1 / aspectRatio);

    return Column(
      children: [
        GestureDetector(
          onPanDown: (_) {
            _userInteracting = true;
            _carouselTimer?.cancel();
          },
          onPanEnd: (_) {
            _userInteracting = false;
            _startCarouselTimer();
          },
          onPanCancel: () {
            _userInteracting = false;
            _startCarouselTimer();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: contentWidth,
              height: carouselHeight,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _carouselController,
                    onPageChanged: (i) =>
                        setState(() => _currentCarouselIndex = i),
                    itemCount: _carouselImages.length,
                    itemBuilder: (_, i) => Image.asset(
                      _carouselImages[i],
                      fit: BoxFit.cover,
                      width: contentWidth,
                      height: carouselHeight,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.black26,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: _gold,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 左右箭頭（只在寬螢幕顯示）
                  if (!isNarrow) ...[
                    _arrowButton(
                      icon: Icons.chevron_left,
                      alignment: Alignment.centerLeft,
                      onTap: () {
                        final prev =
                            (_currentCarouselIndex -
                                1 +
                                _carouselImages.length) %
                            _carouselImages.length;
                        _carouselController.animateToPage(
                          prev,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    _arrowButton(
                      icon: Icons.chevron_right,
                      alignment: Alignment.centerRight,
                      onTap: () {
                        final next =
                            (_currentCarouselIndex + 1) %
                            _carouselImages.length;
                        _carouselController.animateToPage(
                          next,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ],
                  // 左下角頁碼
                  Positioned(
                    bottom: 12,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentCarouselIndex + 1} / ${_carouselImages.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Dot indicators（超過 15 張改用 line indicator 避免爆版）
        _carouselImages.length <= 15 ? _dotIndicators() : _lineIndicator(),
      ],
    );
  }

  Widget _arrowButton({
    required IconData icon,
    required Alignment alignment,
    required VoidCallback onTap,
  }) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black38,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _dotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _carouselImages.length,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _currentCarouselIndex == i ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentCarouselIndex == i ? _gold : _goldDim,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _lineIndicator() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 4,
        child: LinearProgressIndicator(
          value: (_currentCarouselIndex + 1) / _carouselImages.length,
          backgroundColor: _goldDim,
          valueColor: AlwaysStoppedAnimation<Color>(_gold),
        ),
      ),
    );
  }

  // ── 內容區塊（最新消息 / 影音開示）────────────────────────
  Widget _buildSection({
    required String title,
    required List<LinkItem> items,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _goldDim, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 標題列
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _goldDim)),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: _gold, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: _gold,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          // 清單
          SizedBox(
            height: 300,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: items.length,
              separatorBuilder: (_, __) => Divider(
                color: _goldDim,
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (_, i) {
                final item = items[i];
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _launchURL(item.url),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.chevron_right, color: _gold, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: _gold,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.open_in_new, color: _goldDim, size: 15),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double contentWidth = w > 1100 ? 1000 : w * 0.95;
    final bool isWide = w > 720;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── 標題 ────────────────────────────────────────
                  Text(
                    '諦深佛陀 2026年8月1日 現場直播開示',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w > 600 ? 30 : 22,
                      fontWeight: FontWeight.bold,
                      color: _gold,
                      letterSpacing: 1.2,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── YouTube 影片 ─────────────────────────────────
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: contentWidth,
                      height: contentWidth * 9 / 16,
                      child: const HtmlElementView(viewType: 'youtube-player'),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── 輪播圖（RWD）────────────────────────────────
                  SizedBox(width: contentWidth, child: _buildCarousel(contentWidth)),
                  const SizedBox(height: 36),

                  // ── 最新消息 & 影音開示 ──────────────────────────
                  SizedBox(
                    width: contentWidth,
                    child: isWide
                        ? IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _buildSection(
                                    title: '最新消息',
                                    items: _news,
                                    icon: Icons.campaign_outlined,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildSection(
                                    title: '影音開示',
                                    items: _videos,
                                    icon: Icons.play_circle_outline,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              _buildSection(
                                title: '最新消息',
                                items: _news,
                                icon: Icons.campaign_outlined,
                              ),
                              const SizedBox(height: 24),
                              _buildSection(
                                title: '影音開示',
                                items: _videos,
                                icon: Icons.play_circle_outline,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 36),
          const SumeruFooter(),
        ],
      ),
    );
  }
}