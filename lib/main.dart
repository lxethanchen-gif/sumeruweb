import 'package:flutter/material.dart';
import 'routes.dart';
import 'pages/sumeruappbar.dart';
import 'pages/homepage.dart';
import 'pages/dharma_realize.dart';
import 'pages/yingshijuan.dart';
import 'pages/Miezuijuan.dart';
import 'pages/Jiyuandaozhi.dart';
import 'pages/shizhai.dart';
import 'pages/video_teaching.dart';
import 'pages/resource_links.dart';
import 'pages/buddha_intro.dart';
import 'translation_service.dart';

void main() {
  runApp(const SumeruApp());
}

class SumeruApp extends StatelessWidget {
  const SumeruApp({super.key});

  static final _translationNotifier = TranslationNotifier();

  @override
  Widget build(BuildContext context) {
    return TranslationScope(
      notifier: _translationNotifier,
      child: MaterialApp(
        title: '須彌山佛國網',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5C518)),
          useMaterial3: true,
        ),
        home: const MainShell(),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = PageIndex.home;

  // ── 目前語言代碼（預設繁體中文）────────────────────────────────
  String _currentLanguageCode = 'zh-TW';

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _onLanguageChanged(String code) {
    setState(() => _currentLanguageCode = code);
    // TODO: 通知 TranslationNotifier 切換語言
    // 例如：TranslationScope.of(context)?.switchLanguage(code);
  }

  static const List<Widget> _pages = [
    HomePage(),             // 0
    DharmaRealizePage(),    // 1
    YingShiJuanPage(),      // 2
    MieZuiJuanPage(),       // 3
    JiYuanDaoZhiPage(),     // 4
    ShiZhaiPage(),          // 5
    VideoTeachingsPage(),   // 6
    ResourceLinksPage(),    // 7
    BuddhaIntroPage(),      // 8
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          // ── 頁面內容，頂部留出導覽列高度 + margin ────────────
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),

          // ── 浮動圓角 AppBar ───────────────────────────────────
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: SumeruAppBar(
              currentIndex: _currentIndex,
              onPageChanged: _onPageChanged,
              currentLanguageCode: _currentLanguageCode,   // ← 新增
              onLanguageChanged: _onLanguageChanged,        // ← 新增
            ),
          ),
        ],
      ),
    );
  }
}