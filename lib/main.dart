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

void main() {
  runApp(const SumeruApp());
}

class SumeruApp extends StatelessWidget {
  const SumeruApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '須彌山佛國網',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5C518)),
        useMaterial3: true,
      ),
      home: const MainShell(),
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

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
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
      // ── 不使用 appBar 屬性，改用 Stack 讓導覽列浮在畫面上 ──
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          // ── 頁面內容，頂部留出導覽列高度 + margin ────────────
          Padding(
            padding: const EdgeInsets.only(top: 80), // 60 高度 + 20 margin
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),

          // ── 浮動圓角 AppBar ───────────────────────────────────
          Positioned(
            top: 12,        // 距離頂部的間距
            left: 16,       // 左右 margin
            right: 16,
            child: SumeruAppBar(
              currentIndex: _currentIndex,
              onPageChanged: _onPageChanged,
            ),
          ),
        ],
      ),
    );
  }
}