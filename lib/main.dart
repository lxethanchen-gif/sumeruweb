import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
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
import 'firebase_options.dart';
import 'pages/live_stream.dart';
import 'pages/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // 移除 URL 中的 #
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
class MainShell extends StatelessWidget {
  final String location;
  final Widget child;
  const MainShell({super.key, required this.location, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = AppRoutes.pageIndexOf(location);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 80),
              Expanded(child: child),
              const SumeruFooter(),
            ],
          ),
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: SumeruAppBar(currentIndex: currentIndex),
          ),
        ],
      ),
    );
  }
}