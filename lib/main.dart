import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart';
import 'pages/sumeruappbar.dart';
import 'pages/homepage.dart';
import 'pages/dharma_realize.dart';
import 'pages/yingshijuan.dart';
import 'pages/jiyuandaozhi.dart';
import 'pages/miezuijuan.dart';
import 'pages/shizhai.dart';
import 'pages/video_teaching.dart';
import 'pages/resource_links.dart';
import 'pages/buddha_intro.dart';
import 'translation_service.dart';
import 'firebase_options.dart'; // 確認有這個檔案

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  // ✅ 移到 build() 裡，確保 Firebase 已初始化
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const DharmaRealizePage(),
      const YingShiJuanPage(),
      const MieZuiJuanPage(),
      const JiYuanDaoZhiPage(),
      const ShiZhaiPage(),
      const VideoTeachingsPage(),
      const ResourceLinksPage(),
      const BuddhaIntroPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: IndexedStack(index: _currentIndex, children: _pages),
          ),
          Positioned(
            top: 12,
            left: 16,
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
