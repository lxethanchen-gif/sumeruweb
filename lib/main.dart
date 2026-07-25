import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:audioplayers/audioplayers.dart';
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
import 'translation_service.dart' hide TranslationService;
import 'firebase_options.dart';
import 'pages/live_stream.dart';
import 'pages/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SumeruApp());
}

// ── GoRouter 設定 ──────────────────────────────────────────────────
final _router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(
        location: state.matchedLocation,
        child: child,
      ),
      routes: [
        GoRoute(path: AppRoutes.home,           builder: (_, __) => const HomePage()),
        GoRoute(path: AppRoutes.dharmaRealize,  builder: (_, __) => const DharmaRealizePage()),
        GoRoute(path: AppRoutes.yingShiJuan,    builder: (_, __) => const YingShiJuanPage()),
        GoRoute(path: AppRoutes.mieZuiJuan,     builder: (_, __) => const MieZuiJuanPage()),
        GoRoute(path: AppRoutes.jiYuanDaoZhi,   builder: (_, __) => const JiYuanDaoZhiPage()),
        GoRoute(path: AppRoutes.shiZhai,        builder: (_, __) => const ShiZhaiPage()),
        GoRoute(path: AppRoutes.videoTeachings, builder: (_, __) => const VideoTeachingsPage()),
        GoRoute(path: AppRoutes.resourceLinks,  builder: (_, __) => const ResourceLinksPage()),
        GoRoute(path: AppRoutes.buddhaIntro,    builder: (_, __) => const BuddhaIntroPage()),
        GoRoute(path: AppRoutes.liveStream,     builder: (_, __) => const LiveStreamPage()),
      ],
    ),
  ],
);

// ── SumeruApp ──────────────────────────────────────────────────────
class SumeruApp extends StatelessWidget {
  const SumeruApp({super.key});

  static final _translationNotifier = TranslationNotifier();

  @override
  Widget build(BuildContext context) {
    return TranslationScope(
      notifier: _translationNotifier,
      child: MaterialApp.router(
        routerConfig: _router,
        title: '須彌山佛國網',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5C518)),
          useMaterial3: true,
        ),
      ),
    );
  }
}

// ── MainShell ──────────────────────────────────────────────────────
class MainShell extends StatefulWidget {
  final String location;
  final Widget child;
  const MainShell({super.key, required this.location, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final AudioPlayer _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggleMusic() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource('audio/bgm.mp3'));
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = AppRoutes.pageIndexOf(widget.location);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      body: Stack(
        children: [

          // ── 頁面主體 + Footer：用 CustomScrollView 確保 Footer 完整顯示 ──
          CustomScrollView(
            // slivers: [
            //   // AppBar 佔位
            //   const SliverToBoxAdapter(
            //     child: SizedBox(height: 80),
            //   ),
            //   // 頁面內容：撐滿剩餘空間
            //   SliverFillRemaining(
            //     hasScrollBody: false,
            //     child: Column(
            //       children: [
            //         Expanded(child: widget.child),
            //         // Footer 在這裡，高度完全由自身內容決定，不受任何外層限制
            //         const SumeruFooter(),
            //       ],
            //     ),
            //   ),
            // ],
          ),

          // ── 浮動 AppBar（最上層）──────────────────────────────────
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: SumeruAppBar(currentIndex: currentIndex),
          ),

          // ── 背景音樂控制按鈕 ──────────────────────────────────────
          Positioned(
            bottom: 24,
            right: 20,
            child: Tooltip(
              message: _isPlaying ? '暫停音樂' : '播放音樂',
              child: GestureDetector(
                onTap: _toggleMusic,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5C518),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.music_note : Icons.music_off,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}