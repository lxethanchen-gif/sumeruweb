import 'package:flutter/material.dart';
import '../routes.dart';

// ── 常數 ──────────────────────────────────────────────────────────
const Color kPrimaryGold = Color(0xFFF5C518);
const Color kNavTextOnGold = Colors.white;

const _kNavItems = [
  (label: '了解佛法', page: PageIndex.dharmaRealize),
  (label: '應世卷', page: PageIndex.yingShiJuan),
  (label: '滅罪卷', page: PageIndex.mieZuiJuan),
  (label: '機緣道旨妙法入門卷', page: PageIndex.jiYuanDaoZhi),
  (label: '詩摘', page: PageIndex.shiZhai),
];

// ── 語言清單 ──────────────────────────────────────────────────────
const _kLanguages = [
  (label: '繁體中文', code: 'zh-TW', flag: '🇹🇼'),
  (label: '简体中文', code: 'zh-CN', flag: '🇨🇳'),
  (label: 'English', code: 'en', flag: '🇺🇸'),
  (label: '日本語', code: 'ja', flag: '🇯🇵'),
  (label: '한국어', code: 'ko', flag: '🇰🇷'),
  (label: 'Français', code: 'fr', flag: '🇫🇷'),
  (label: 'Español', code: 'es', flag: '🇪🇸'),
  (label: 'Deutsch', code: 'de', flag: '🇩🇪'),
  (label: 'Português', code: 'pt', flag: '🇧🇷'),
  (label: 'Tiếng Việt', code: 'vi', flag: '🇻🇳'),
  (label: 'ภาษาไทย', code: 'th', flag: '🇹🇭'),
  (label: 'Bahasa', code: 'id', flag: '🇮🇩'),
  (label: 'Latina', code: 'la', flag: '🏛️'),
  (label: 'Türkçe', code: 'tr', flag: '🇹🇷'),
  (label: 'नेपाली', code: 'ne', flag: '🇳🇵'),
  (label: 'हिन्दी', code: 'hi', flag: '🇮🇳'),
  (label: 'العربية', code: 'ar', flag: '🇸🇦'),
  (label: 'Italiano', code: 'it', flag: '🇮🇹'),
  (label: 'Русский', code: 'ru', flag: '🇷🇺'),
  (label: 'Filipino', code: 'fil', flag: '🇵🇭'),
];

// ── 工具 ──────────────────────────────────────────────────────────
bool _isMobile(BuildContext ctx) => MediaQuery.sizeOf(ctx).width < 600;
bool _isTablet(BuildContext ctx) => MediaQuery.sizeOf(ctx).width < 1024;

// ─────────────────────────────────────────────────────────────────
// SumeruLogo
// ─────────────────────────────────────────────────────────────────
class SumeruLogo extends StatelessWidget {
  final bool compact;
  const SumeruLogo({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo_with_border.png',
          width: compact ? 36 : 44,
          height: compact ? 36 : 44,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '須彌山佛國網',
              style: TextStyle(
                fontSize: compact ? 13 : 15,
                fontWeight: FontWeight.bold,
                color: kNavTextOnGold,
                letterSpacing: 1.5,
                height: 1.2,
              ),
            ),
            if (!compact) ...[
              const SizedBox(height: 2),
              const Text(
                'Sumeru Mount Buddha Nation',
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFFFFF0B0),
                  letterSpacing: 0.8,
                  height: 1.2,
                ),
              ),
            ],
          ],
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// SumeruAppBar  ── 入口，依寬度切換佈局
// ─────────────────────────────────────────────────────────────────
class SumeruAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  /// 目前選取的語言代碼（預設繁體中文）
  final String currentLanguageCode;

  /// 語言切換回調
  final ValueChanged<String> onLanguageChanged;

  const SumeruAppBar({
    super.key,
    required this.currentIndex,
    required this.onPageChanged,
    this.currentLanguageCode = 'zh-TW',
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (_isMobile(context)) {
      return _MobileAppBar(
        currentIndex: currentIndex,
        onPageChanged: onPageChanged,
        currentLanguageCode: currentLanguageCode,
        onLanguageChanged: onLanguageChanged,
      );
    }
    return _HorizontalAppBar(
      currentIndex: currentIndex,
      onPageChanged: onPageChanged,
      compact: _isTablet(context),
      currentLanguageCode: currentLanguageCode,
      onLanguageChanged: onLanguageChanged,
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _HorizontalAppBar  ── Desktop / Tablet
// ─────────────────────────────────────────────────────────────────
class _HorizontalAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final bool compact;
  final String currentLanguageCode;
  final ValueChanged<String> onLanguageChanged;

  const _HorizontalAppBar({
    required this.currentIndex,
    required this.onPageChanged,
    required this.compact,
    required this.currentLanguageCode,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) => Material(
    elevation: 6,
    shadowColor: Colors.black38,
    borderRadius: BorderRadius.circular(16),
    color: kPrimaryGold,
    child: SizedBox(
      height: compact ? 50 : 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SumeruLogo(compact: compact),
            Container(width: 1, color: Colors.white24),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _NavBtn(
                      '首頁',
                      compact,
                      currentIndex == PageIndex.home,
                      () => onPageChanged(PageIndex.home),
                    ),
                    _DropdownBtn(
                      isActive: PageIndex.isTextTeachings(currentIndex),
                      onPageChanged: onPageChanged,
                      compact: compact,
                    ),
                    _NavBtn(
                      compact ? '影音' : '影音開示',
                      compact,
                      currentIndex == PageIndex.videoTeachings,
                      () => onPageChanged(PageIndex.videoTeachings),
                    ),
                    _NavBtn(
                      compact ? '資源' : '資源連結',
                      compact,
                      currentIndex == PageIndex.resourceLinks,
                      () => onPageChanged(PageIndex.resourceLinks),
                    ),
                    _NavBtn(
                      compact ? '簡介' : '諦深佛陀簡介',
                      compact,
                      currentIndex == PageIndex.buddhaIntro,
                      () => onPageChanged(PageIndex.buddhaIntro),
                    ),
                  ],
                ),
              ),
            ),
            // ── 語言切換（靠右固定）──
            Container(width: 1, color: Colors.white24),
            _LangDropdownBtn(
              currentCode: currentLanguageCode,
              onLanguageChanged: onLanguageChanged,
              compact: compact,
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _MobileAppBar  ── Hamburger + Sidebar
// ─────────────────────────────────────────────────────────────────
class _MobileAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final String currentLanguageCode;
  final ValueChanged<String> onLanguageChanged;

  const _MobileAppBar({
    required this.currentIndex,
    required this.onPageChanged,
    required this.currentLanguageCode,
    required this.onLanguageChanged,
  });

  void _openDrawer(BuildContext ctx) => showGeneralDialog(
    context: ctx,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, __) {
      final slide = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(ctx).pop(),
            child: const SizedBox.expand(),
          ),
          SlideTransition(
            position: Tween(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(slide),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _SidebarPanel(
                currentIndex: currentIndex,
                onPageChanged: (idx) {
                  Navigator.of(ctx).pop();
                  onPageChanged(idx);
                },
                currentLanguageCode: currentLanguageCode,
                onLanguageChanged: (code) {
                  Navigator.of(ctx).pop();
                  onLanguageChanged(code);
                },
              ),
            ),
          ),
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) => Material(
    elevation: 6,
    shadowColor: Colors.black38,
    borderRadius: BorderRadius.circular(14),
    color: kPrimaryGold,
    child: SizedBox(
      height: 52,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Row(
          children: [
            const Expanded(child: SumeruLogo(compact: true)),
            _IconBtn(Icons.menu_rounded, () => _openDrawer(context)),
            const SizedBox(width: 8),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _SidebarPanel
// ─────────────────────────────────────────────────────────────────
class _SidebarPanel extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final String currentLanguageCode;
  final ValueChanged<String> onLanguageChanged;

  const _SidebarPanel({
    required this.currentIndex,
    required this.onPageChanged,
    required this.currentLanguageCode,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) => Material(
    elevation: 16,
    color: kPrimaryGold,
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    child: SizedBox(
      width: 270,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 8, 4),
              child: Align(
                alignment: Alignment.centerRight,
                child: _IconBtn(
                  Icons.close_rounded,
                  () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.white24,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                children: [
                  _SidebarItem(
                    '首頁',
                    currentIndex == PageIndex.home,
                    () => onPageChanged(PageIndex.home),
                  ),
                  _SidebarExpand(
                    isActive: PageIndex.isTextTeachings(currentIndex),
                    currentIndex: currentIndex,
                    onPageChanged: onPageChanged,
                  ),
                  _SidebarItem(
                    '影音開示',
                    currentIndex == PageIndex.videoTeachings,
                    () => onPageChanged(PageIndex.videoTeachings),
                  ),
                  _SidebarItem(
                    '資源連結',
                    currentIndex == PageIndex.resourceLinks,
                    () => onPageChanged(PageIndex.resourceLinks),
                  ),
                  _SidebarItem(
                    '諦深佛陀簡介',
                    currentIndex == PageIndex.buddhaIntro,
                    () => onPageChanged(PageIndex.buddhaIntro),
                  ),

                  // ── 語言選擇 分隔線 ──
                  Container(
                    height: 1,
                    color: Colors.white24,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),

                  // ── 語言展開群組 ──
                  _SidebarLangExpand(
                    currentCode: currentLanguageCode,
                    onLanguageChanged: onLanguageChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _SidebarItem  ── hover / active → 白底金字，撐滿寬
// ─────────────────────────────────────────────────────────────────
class _SidebarItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final double indent;
  const _SidebarItem(this.label, this.isActive, this.onTap, {this.indent = 0});

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final hl = widget.isActive || _hov;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(
            left: 16 + widget.indent,
            right: 16,
            top: 12,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: hl ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: hl ? kPrimaryGold : kNavTextOnGold,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _SidebarExpand  ── 「文字開示」可展開群組
// ─────────────────────────────────────────────────────────────────
class _SidebarExpand extends StatefulWidget {
  final bool isActive;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  const _SidebarExpand({
    required this.isActive,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  State<_SidebarExpand> createState() => _SidebarExpandState();
}

class _SidebarExpandState extends State<_SidebarExpand>
    with SingleTickerProviderStateMixin {
  late bool _open;
  late final AnimationController _ctrl;
  late final Animation<double> _rot;

  @override
  void initState() {
    super.initState();
    _open = widget.isActive;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _open ? 1.0 : 0.0,
    );
    _rot = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _open = !_open);
    _open ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: _toggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isActive
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '文字開示',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kNavTextOnGold,
                  ),
                ),
              ),
              RotationTransition(
                turns: _rot,
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: kNavTextOnGold,
                ),
              ),
            ],
          ),
        ),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: _open
            ? Column(
                children: _kNavItems
                    .map(
                      (e) => _SidebarItem(
                        e.label,
                        widget.currentIndex == e.page,
                        () => widget.onPageChanged(e.page),
                        indent: 16,
                      ),
                    )
                    .toList(),
              )
            : const SizedBox.shrink(),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────
// _SidebarLangExpand  ── 側欄語言展開群組
// ─────────────────────────────────────────────────────────────────
class _SidebarLangExpand extends StatefulWidget {
  final String currentCode;
  final ValueChanged<String> onLanguageChanged;
  const _SidebarLangExpand({
    required this.currentCode,
    required this.onLanguageChanged,
  });

  @override
  State<_SidebarLangExpand> createState() => _SidebarLangExpandState();
}

class _SidebarLangExpandState extends State<_SidebarLangExpand>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late final AnimationController _ctrl;
  late final Animation<double> _rot;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 0.0,
    );
    _rot = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _open = !_open);
    _open ? _ctrl.forward() : _ctrl.reverse();
  }

  String get _currentFlag {
    final match = _kLanguages.where((e) => e.code == widget.currentCode);
    return match.isNotEmpty ? match.first.flag : '🌐';
  }

  String get _currentLabel {
    final match = _kLanguages.where((e) => e.code == widget.currentCode);
    return match.isNotEmpty ? match.first.label : '語言';
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: _toggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                '$_currentFlag  $_currentLabel',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kNavTextOnGold,
                ),
              ),
              const Spacer(),
              RotationTransition(
                turns: _rot,
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: kNavTextOnGold,
                ),
              ),
            ],
          ),
        ),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: _open
            ? Column(
                children: _kLanguages.map((e) {
                  final isActive = widget.currentCode == e.code;
                  return _SidebarLangItem(
                    flag: e.flag,
                    label: e.label,
                    isActive: isActive,
                    onTap: () => widget.onLanguageChanged(e.code),
                  );
                }).toList(),
              )
            : const SizedBox.shrink(),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────
// _SidebarLangItem  ── 側欄語言選項（含旗幟）
// ─────────────────────────────────────────────────────────────────
class _SidebarLangItem extends StatefulWidget {
  final String flag, label;
  final bool isActive;
  final VoidCallback onTap;
  const _SidebarLangItem({
    required this.flag,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_SidebarLangItem> createState() => _SidebarLangItemState();
}

class _SidebarLangItemState extends State<_SidebarLangItem> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final hl = widget.isActive || _hov;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.only(
            left: 32,
            right: 16,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: hl ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(widget.flag, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: hl ? kPrimaryGold : kNavTextOnGold,
                ),
              ),
              if (widget.isActive) ...[
                const Spacer(),
                Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: hl ? kPrimaryGold : kNavTextOnGold,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _NavBtn  ── AppBar 橫向導覽按鈕（Desktop/Tablet）
// ─────────────────────────────────────────────────────────────────
class _NavBtn extends StatefulWidget {
  final String label;
  final bool compact, isActive;
  final VoidCallback onTap;
  const _NavBtn(this.label, this.compact, this.isActive, this.onTap);

  @override
  State<_NavBtn> createState() => _NavBtnState();
}

class _NavBtnState extends State<_NavBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final hl = widget.isActive || _hov;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(
              horizontal: widget.compact ? 3 : 4,
              vertical: 8,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 10 : 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: hl ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: widget.compact ? 13 : 14,
                fontWeight: FontWeight.w600,
                color: hl ? kPrimaryGold : kNavTextOnGold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _DropdownBtn  ── 「文字開示」下拉觸發鈕
// ─────────────────────────────────────────────────────────────────
class _DropdownBtn extends StatefulWidget {
  final bool isActive, compact;
  final ValueChanged<int> onPageChanged;
  const _DropdownBtn({
    required this.isActive,
    required this.onPageChanged,
    this.compact = false,
  });

  @override
  State<_DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<_DropdownBtn> {
  bool _hov = false, _open = false;
  OverlayEntry? _entry;

  void _show() {
    if (_entry != null) return;
    final box = context.findRenderObject() as RenderBox;
    final ovlBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    final origin = box.localToGlobal(Offset.zero, ancestor: ovlBox);
    _entry = OverlayEntry(
      builder: (_) => _DropdownOverlay(
        origin: origin,
        triggerHeight: box.size.height,
        onSelected: (idx) {
          _hide();
          widget.onPageChanged(idx);
        },
        onDismiss: _hide,
      ),
    );
    setState(() => _open = true);
    Overlay.of(context).insert(_entry!);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() => _open = false);
  }

  @override
  void dispose() {
    _entry?.remove();
    _entry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hl = widget.isActive || _hov || _open;
    return GestureDetector(
      onTap: () => _open ? _hide() : _show(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _hov = true);
          _show();
        },
        onExit: (_) => setState(() => _hov = false),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(
              horizontal: widget.compact ? 3 : 4,
              vertical: 8,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 10 : 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: hl ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '文字開示',
                  style: TextStyle(
                    fontSize: widget.compact ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: hl ? kPrimaryGold : kNavTextOnGold,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: hl ? kPrimaryGold : kNavTextOnGold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _LangDropdownBtn  ── 語言切換觸發鈕（靠右固定）
// ─────────────────────────────────────────────────────────────────
class _LangDropdownBtn extends StatefulWidget {
  final String currentCode;
  final ValueChanged<String> onLanguageChanged;
  final bool compact;
  const _LangDropdownBtn({
    required this.currentCode,
    required this.onLanguageChanged,
    this.compact = false,
  });

  @override
  State<_LangDropdownBtn> createState() => _LangDropdownBtnState();
}

class _LangDropdownBtnState extends State<_LangDropdownBtn> {
  bool _hov = false, _open = false;
  OverlayEntry? _entry;

  String get _currentFlag {
    final match = _kLanguages.where((e) => e.code == widget.currentCode);
    return match.isNotEmpty ? match.first.flag : '🌐';
  }

  void _show() {
    if (_entry != null) return;
    final box = context.findRenderObject() as RenderBox;
    final ovlBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    final origin = box.localToGlobal(Offset.zero, ancestor: ovlBox);
    _entry = OverlayEntry(
      builder: (_) => _LangDropdownOverlay(
        origin: origin,
        triggerWidth: box.size.width,
        triggerHeight: box.size.height,
        currentCode: widget.currentCode,
        onSelected: (code) {
          _hide();
          widget.onLanguageChanged(code);
        },
        onDismiss: _hide,
      ),
    );
    setState(() => _open = true);
    Overlay.of(context).insert(_entry!);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() => _open = false);
  }

  @override
  void dispose() {
    _entry?.remove();
    _entry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hl = _hov || _open;
    return GestureDetector(
      onTap: () => _open ? _hide() : _show(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _hov = true);
          _show();
        },
        onExit: (_) => setState(() => _hov = false),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(
              horizontal: widget.compact ? 3 : 6,
              vertical: 8,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 8 : 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: hl ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currentFlag,
                  style: TextStyle(fontSize: widget.compact ? 14 : 16),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: hl ? kPrimaryGold : kNavTextOnGold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _LangDropdownOverlay  ── 語言浮層選單（右對齊）
// ─────────────────────────────────────────────────────────────────
class _LangDropdownOverlay extends StatefulWidget {
  final Offset origin;
  final double triggerWidth, triggerHeight;
  final String currentCode;
  final ValueChanged<String> onSelected;
  final VoidCallback onDismiss;
  const _LangDropdownOverlay({
    required this.origin,
    required this.triggerWidth,
    required this.triggerHeight,
    required this.currentCode,
    required this.onSelected,
    required this.onDismiss,
  });

  @override
  State<_LangDropdownOverlay> createState() => _LangDropdownOverlayState();
}

class _LangDropdownOverlayState extends State<_LangDropdownOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  // 選單寬度固定
  static const double _menuWidth = 170;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    )..forward();
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(
      begin: const Offset(0, -0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 右對齊：選單右邊 = 觸發鈕右邊
    final left = widget.origin.dx + widget.triggerWidth - _menuWidth;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
        ),
        Positioned(
          top: widget.origin.dy + widget.triggerHeight + 10,
          left: left,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: MouseRegion(
                onExit: (_) => widget.onDismiss(),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: _menuWidth,
                    decoration: BoxDecoration(
                      color: kPrimaryGold,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _kLanguages
                          .map(
                            (e) => _LangDropdownRow(
                              flag: e.flag,
                              label: e.label,
                              isActive: widget.currentCode == e.code,
                              onTap: () => widget.onSelected(e.code),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _LangDropdownRow  ── 語言下拉選單列（含旗幟 + 勾選）
// ─────────────────────────────────────────────────────────────────
class _LangDropdownRow extends StatefulWidget {
  final String flag, label;
  final bool isActive;
  final VoidCallback onTap;
  const _LangDropdownRow({
    required this.flag,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_LangDropdownRow> createState() => _LangDropdownRowState();
}

class _LangDropdownRowState extends State<_LangDropdownRow> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final hl = _hov || widget.isActive;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: hl ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(widget.flag, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: hl ? kPrimaryGold : kNavTextOnGold,
                  ),
                ),
              ),
              if (widget.isActive)
                Icon(
                  Icons.check_rounded,
                  size: 15,
                  color: hl ? kPrimaryGold : kNavTextOnGold,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _DropdownOverlay  ── 文字開示浮層選單
// ─────────────────────────────────────────────────────────────────
class _DropdownOverlay extends StatefulWidget {
  final Offset origin;
  final double triggerHeight;
  final ValueChanged<int> onSelected;
  final VoidCallback onDismiss;
  const _DropdownOverlay({
    required this.origin,
    required this.triggerHeight,
    required this.onSelected,
    required this.onDismiss,
  });

  @override
  State<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    )..forward();
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(
      begin: const Offset(0, -0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: widget.onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),
      ),
      Positioned(
        top: widget.origin.dy + widget.triggerHeight + 10,
        left: widget.origin.dx,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: MouseRegion(
              onExit: (_) => widget.onDismiss(),
              child: Material(
                elevation: 10,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryGold,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _kNavItems
                        .map(
                          (e) => _DropdownRow(
                            label: e.label,
                            onTap: () => widget.onSelected(e.page),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────
// _DropdownRow  ── 文字開示下拉選單列
// ─────────────────────────────────────────────────────────────────
class _DropdownRow extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _DropdownRow({required this.label, required this.onTap});

  @override
  State<_DropdownRow> createState() => _DropdownRowState();
}

class _DropdownRowState extends State<_DropdownRow> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hov = true),
    onExit: (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 130,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: _hov ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _hov ? kPrimaryGold : kNavTextOnGold,
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _IconBtn  ── Hamburger / Close，hover 白底圓圈
// ─────────────────────────────────────────────────────────────────
class _IconBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn(this.icon, this.onTap);

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hov = true),
    onExit: (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _hov ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.icon,
          color: _hov ? kPrimaryGold : kNavTextOnGold,
          size: 26,
        ),
      ),
    ),
  );
}
