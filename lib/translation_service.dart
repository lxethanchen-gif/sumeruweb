import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ── 支援語言清單 ──────────────────────────────────────────────────
class SupportedLanguage {
  final String code;
  final String nativeName;
  final String flag;
  const SupportedLanguage(this.code, this.nativeName, this.flag);
}

const kSupportedLanguages = [
  SupportedLanguage('zh-TW', '繁體中文', '🇹🇼'),
  SupportedLanguage('zh-CN', '简体中文', '🇨🇳'),
  SupportedLanguage('ja',    '日本語',   '🇯🇵'),
  SupportedLanguage('ko',    '한국어',   '🇰🇷'),
  SupportedLanguage('th',    'ภาษาไทย', '🇹🇭'),
  SupportedLanguage('vi',    'Tiếng Việt', '🇻🇳'),
  SupportedLanguage('tl',    'Filipino', '🇵🇭'),
  SupportedLanguage('id',    'Bahasa Indonesia', '🇮🇩'),
  SupportedLanguage('hi',    'हिन्दी',  '🇮🇳'),
  SupportedLanguage('ne',    'नेपाली',  '🇳🇵'),
  SupportedLanguage('en',    'English', '🇬🇧'),
  SupportedLanguage('fr',    'Français', '🇫🇷'),
  SupportedLanguage('de',    'Deutsch', '🇩🇪'),
  SupportedLanguage('ru',    'Русский', '🇷🇺'),
  SupportedLanguage('es',    'Español', '🇪🇸'),
  SupportedLanguage('it',    'Italiano', '🇮🇹'),
  SupportedLanguage('pt',    'Português', '🇵🇹'),
  SupportedLanguage('la',    'Latina',  '🏛️'),
  SupportedLanguage('tr',    'Türkçe',  '🇹🇷'),
  SupportedLanguage('ar',    'العربية', '🇸🇦'),
];

// ── 所有需翻譯的 UI 文字 key ──────────────────────────────────────
class AppStrings {
  final String home;
  final String textTeachings;
  final String dharmaRealize;
  final String yingShiJuan;
  final String mieZuiJuan;
  final String jiYuanDaoZhi;
  final String shiZhai;
  final String videoTeachings;
  final String resourceLinks;
  final String buddhaIntro;
  final String siteTitle;
  final String siteSubtitle;
  final String videoCompact;
  final String resourceCompact;
  final String buddhaCompact;

  const AppStrings({
    required this.home,
    required this.textTeachings,
    required this.dharmaRealize,
    required this.yingShiJuan,
    required this.mieZuiJuan,
    required this.jiYuanDaoZhi,
    required this.shiZhai,
    required this.videoTeachings,
    required this.resourceLinks,
    required this.buddhaIntro,
    required this.siteTitle,
    required this.siteSubtitle,
    required this.videoCompact,
    required this.resourceCompact,
    required this.buddhaCompact,
  });

  // 預設繁體中文
  static const defaults = AppStrings(
    home:            '首頁',
    textTeachings:   '文字開示',
    dharmaRealize:   '了解佛法',
    yingShiJuan:     '應世卷',
    mieZuiJuan:      '滅罪卷',
    jiYuanDaoZhi:    '機緣道旨',
    shiZhai:         '詩摘',
    videoTeachings:  '影音開示',
    resourceLinks:   '資源連結',
    buddhaIntro:     '諦深佛陀簡介',
    siteTitle:       '須彌山佛國網',
    siteSubtitle:    'Sumeru Mount Buddha Nation',
    videoCompact:    '影音',
    resourceCompact: '資源',
    buddhaCompact:   '簡介',
  );
}

// ── Google 翻譯核心服務（用於整頁任意文字動態翻譯） ───────────────────
class GoogleTranslateService {
  // ⚠️ 請在編譯時帶入 key，或直接在此貼上你的 Google Cloud Translation API Key
  static const String _apiKey = String.fromEnvironment('GOOGLE_TRANSLATE_API_KEY', defaultValue: 'YOUR_API_KEY_HERE');

  // 二級快取結構：{ 'en': { '原文': '密文' } }，避免重複翻譯相同內文
  static final Map<String, Map<String, String>> _dynamicCache = {};

  static Future<String> translateText(String text, String targetLang) async {
    if (targetLang == 'zh-TW' || text.trim().isEmpty) return text;

    // 將 Flutter 常用的 zh-TW / zh-CN 轉換為 Google API 標準代碼
    String apiLang = targetLang;
    if (targetLang == 'zh-CN') apiLang = 'zh-CN';

    final url = Uri.parse('https://translation.googleapis.com/language/translate/v2?key=$_apiKey');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'target': apiLang,
          'format': 'text', // 使用 text 格式，避免內文中的標點符號被 HTML 轉義（如 ' 變成 &#39;）
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translatedText = data['data']['translations'][0]['translatedText'] as String;

        // 寫入快取
        _dynamicCache[targetLang] ??= {};
        _dynamicCache[targetLang]![text] = translatedText;

        return translatedText;
      } else {
        debugPrint('Google API 錯誤: ${response.body}');
        return text;
      }
    } catch (e) {
      debugPrint('Google 翻譯請求異常: $e');
      return text;
    }
  }
}

// ── TranslationNotifier ───────────────────────────────────────────
class TranslationNotifier extends ChangeNotifier {
  String _langCode = 'zh-TW';
  AppStrings _strings = AppStrings.defaults;
  bool _isLoading = false;
  String? _error;

  String get langCode => _langCode;
  AppStrings get strings => _strings;
  bool get isLoading => _isLoading;

  SupportedLanguage get currentLang =>
      kSupportedLanguages.firstWhere((l) => l.code == _langCode,
          orElse: () => kSupportedLanguages.first);

  // 快取：避免重複請求同語言的 UI 選單
  final Map<String, AppStrings> _cache = {'zh-TW': AppStrings.defaults};

  Future<void> setLanguage(String code) async {
    if (code == _langCode) return;
    if (_cache.containsKey(code)) {
      _langCode = code;
      _strings = _cache[code]!;
      notifyListeners();
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final translated = await _translateViaApi(code);
      _cache[code] = translated;
      _langCode = code;
      _strings = translated;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 保持你原本的 Claude UI 翻譯架構不變
  Future<AppStrings> _translateViaApi(String targetLang) async {
    final langName = kSupportedLanguages
        .firstWhere((l) => l.code == targetLang,
            orElse: () => kSupportedLanguages.first)
        .nativeName;

    final payload = {
      'home': '首頁',
      'textTeachings': '文字開示',
      'dharmaRealize': '了解佛法',
      'yingShiJuan': '應世卷',
      'mieZuiJuan': '滅罪卷',
      'jiYuanDaoZhi': '機緣道旨',
      'shiZhai': '詩摘',
      'videoTeachings': '影音開示',
      'resourceLinks': '資源連結',
      'buddhaIntro': '諦深佛陀簡介',
      'siteTitle': '須彌山佛國網',
      'siteSubtitle': 'Sumeru Mount Buddha Nation',
      'videoCompact': '影音',
      'resourceCompact': '資源',
      'buddhaCompact': '簡介',
    };

    final response = await http.post(
      Uri.parse('https://api.anthropic.com/v1/messages'),
      headers: {
        'Content-Type': 'application/json',
        'anthropic-version': '2023-06-01',
        'x-api-key': const String.fromEnvironment('ANTHROPIC_API_KEY'),
      },
      body: jsonEncode({
        'model': 'claude-sonnet-4-20250514',
        'max_tokens': 1000,
        'system':
            'You are a translation assistant for a Buddhist website. '
            'Translate the given JSON values from Traditional Chinese to $langName ($targetLang). '
            'Return ONLY a valid JSON object with the same keys, translated values only. '
            'No markdown, no explanation, no extra text.',
        'messages': [
          {'role': 'user', 'content': jsonEncode(payload)}
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('API error ${response.statusCode}: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final content = (data['content'] as List).first['text'] as String;
    final clean = content.replaceAll(RegExp(r'```json|```'), '').trim();
    final map = jsonDecode(clean) as Map<String, dynamic>;

    return AppStrings(
      home:            map['home']            ?? AppStrings.defaults.home,
      textTeachings:   map['textTeachings']   ?? AppStrings.defaults.textTeachings,
      dharmaRealize:   map['dharmaRealize']   ?? AppStrings.defaults.dharmaRealize,
      yingShiJuan:     map['yingShiJuan']     ?? AppStrings.defaults.yingShiJuan,
      mieZuiJuan:      map['mieZuiJuan']      ?? AppStrings.defaults.mieZuiJuan,
      jiYuanDaoZhi:    map['jiYuanDaoZhi']    ?? AppStrings.defaults.jiYuanDaoZhi,
      shiZhai:         map['shiZhai']          ?? AppStrings.defaults.shiZhai,
      videoTeachings:  map['videoTeachings']  ?? AppStrings.defaults.videoTeachings,
      resourceLinks:   map['resourceLinks']   ?? AppStrings.defaults.resourceLinks,
      buddhaIntro:     map['buddhaIntro']     ?? AppStrings.defaults.buddhaIntro,
      siteTitle:       map['siteTitle']       ?? AppStrings.defaults.siteTitle,
      siteSubtitle:    map['siteSubtitle']    ?? AppStrings.defaults.siteSubtitle,
      videoCompact:    map['videoCompact']    ?? AppStrings.defaults.videoCompact,
      resourceCompact: map['resourceCompact'] ?? AppStrings.defaults.resourceCompact,
      buddhaCompact:   map['buddhaCompact']   ?? AppStrings.defaults.buddhaCompact,
    );
  }
}

// ── InheritedWidget 供全 App 存取 ────────────────────────────────
class TranslationScope extends InheritedNotifier<TranslationNotifier> {
  const TranslationScope({
    super.key,
    required TranslationNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  static TranslationNotifier of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<TranslationScope>();
    assert(scope != null, 'No TranslationScope found in widget tree');
    return scope!.notifier!;
  }

  static AppStrings strings(BuildContext context) => of(context).strings;
}

// ── 💡 核心新增：自動翻譯的 Text 元件 ──────────────────────────────────
class TranslatableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatableText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    // 監聽全域語言變更狀態
    final currentLang = TranslationScope.of(context).langCode;

    // 如果是繁體中文，不需要浪費網路請求與效能，直接渲染
    if (currentLang == 'zh-TW') {
      return Text(text, style: style, textAlign: textAlign, maxLines: maxLines, overflow: overflow);
    }

    // 其他語言則非同步呼叫 Google 翻譯服務
    return FutureBuilder<String>(
      future: GoogleTranslateService.translateText(text, currentLang),
      initialData: text, // 翻譯尚未成功回傳前，先顯示原本的繁體中文，避免畫面空白
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? text,
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
}