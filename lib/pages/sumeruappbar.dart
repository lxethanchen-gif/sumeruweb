import 'package:flutter/material.dart';
import '../routes.dart';

// ── 常數 ─────────────────────────────────────────────────────────
const Color kPrimaryGold = Color(0xFFF5C518);
const Color kNavTextOnGold = Colors.white;

const _kNavItems = [
  (label: '了解佛法', page: PageIndex.dharmaRealize),
  (label: '應世卷', page: PageIndex.yingShiJuan),
  (label: '滅罪卷', page: PageIndex.mieZuiJuan),
  (label: '機緣道旨妙法入門卷', page: PageIndex.jiYuanDaoZhi),
  (label: '詩摘', page: PageIndex.shiZhai),
];

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

// ── 工具 ─────────────────────────────────────────────────────────
bool _isMobile(BuildContext ctx) => MediaQuery.sizeOf(ctx).width < 600;
bool _isTablet(BuildContext ctx) => MediaQuery.sizeOf(ctx).width < 1024;

String _langFlag(String code) =>
    _kLanguages.where((e) => e.code == code).firstOrNull?.flag ?? '🌐';
String _langLabel(String code) =>
    _kLanguages.where((e) => e.code == code).firstOrNull?.label ?? '語言';

// ─────────────────────────────────────────────────────────────────
// _HoverContainer  ── 通用 hover 高亮容器
// ─────────────────────────────────────────────────────────────────
class _HoverContainer extends StatefulWidget {
  final Widget Function(bool highlighted) builder;
  final VoidCallback onTap;
  final bool forceHighlight;
  final VoidCallback? onEnter;

  const _HoverContainer({
    required this.builder,
    required this.onTap,
    this.forceHighlight = false,
    this.onEnter,
  });

  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) {
      setState(() => _hov = true);
      widget.onEnter?.call();
    },
    onExit: (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: widget.builder(widget.forceHighlight || _hov),
    ),
  );
}

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
            if (!compact)
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
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// SumeruAppBar  ── 入口
// ─────────────────────────────────────────────────────────────────
class SumeruAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final String currentLanguageCode;
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
                      label: '首頁',
                      compact: compact,
                      isActive: currentIndex == PageIndex.home,
                      onTap: () => onPageChanged(PageIndex.home),
                    ),
                    _DropdownBtn(
                      isActive: PageIndex.isTextTeachings(currentIndex),
                      onPageChanged: onPageChanged,
                      compact: compact,
                    ),
                    _NavBtn(
                      label: compact ? '影音' : '影音開示',
                      compact: compact,
                      isActive: currentIndex == PageIndex.videoTeachings,
                      onTap: () => onPageChanged(PageIndex.videoTeachings),
                    ),
                    _NavBtn(
                      label: compact ? '資源' : '資源連結',
                      compact: compact,
                      isActive: currentIndex == PageIndex.resourceLinks,
                      onTap: () => onPageChanged(PageIndex.resourceLinks),
                    ),
                    _NavBtn(
                      label: compact ? '簡介' : '諦深佛陀簡介',
                      compact: compact,
                      isActive: currentIndex == PageIndex.buddhaIntro,
                      onTap: () => onPageChanged(PageIndex.buddhaIntro),
                    ),
                  ],
                ),
              ),
            ),
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
            _divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: [
                  _SidebarItem('首頁', currentIndex == PageIndex.home,
                      () => onPageChanged(PageIndex.home)),
                  _ExpandGroup(
                    title: '文字開示',
                    isActive: PageIndex.isTextTeachings(currentIndex),
                    initiallyOpen: PageIndex.isTextTeachings(currentIndex),
                    children: _kNavItems
                        .map((e) => _SidebarItem(
                              e.label,
                              currentIndex == e.page,
                              () => onPageChanged(e.page),
                              indent: 16,
                            ))
                        .toList(),
                  ),
                  _SidebarItem('影音開示', currentIndex == PageIndex.videoTeachings,
                      () => onPageChanged(PageIndex.videoTeachings)),
                  _SidebarItem('資源連結', currentIndex == PageIndex.resourceLinks,
                      () => onPageChanged(PageIndex.resourceLinks)),
                  _SidebarItem('諦深佛陀簡介', currentIndex == PageIndex.buddhaIntro,
                      () => onPageChanged(PageIndex.buddhaIntro)),
                  _divider(),
                  _ExpandGroup(
                    title: '${_langFlag(currentLanguageCode)}  ${_langLabel(currentLanguageCode)}',
                    isActive: false,
                    children: _kLanguages
                        .map((e) => _SidebarLangItem(
                              flag: e.flag,
                              label: e.label,
                              isActive: currentLanguageCode == e.code,
                              onTap: () => onLanguageChanged(e.code),
                            ))
                        .toList(),
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

Widget _divider() => Container(
  height: 1,
  color: Colors.white24,
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
);

// ─────────────────────────────────────────────────────────────────
// _SidebarItem
// ─────────────────────────────────────────────────────────────────
class _SidebarItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final double indent;
  const _SidebarItem(this.label, this.isActive, this.onTap, {this.indent = 0});

  @override
  Widget build(BuildContext context) => _HoverContainer(
    forceHighlight: isActive,
    onTap: onTap,
    builder: (hl) => AnimatedContainer(
      duration: const Duration(milliseconds: 130),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.only(
          left: 16 + indent, right: 16, top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: hl ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: hl ? kPrimaryGold : kNavTextOnGold,
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _SidebarLangItem
// ─────────────────────────────────────────────────────────────────
class _SidebarLangItem extends StatelessWidget {
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
  Widget build(BuildContext context) => _HoverContainer(
    forceHighlight: isActive,
    onTap: onTap,
    builder: (hl) => AnimatedContainer(
      duration: const Duration(milliseconds: 130),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.only(left: 32, right: 16, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: hl ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: hl ? kPrimaryGold : kNavTextOnGold,
              ),
            ),
          ),
          if (isActive)
            Icon(Icons.check_rounded,
                size: 16, color: hl ? kPrimaryGold : kNavTextOnGold),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _ExpandGroup  ── 通用側欄展開群組
// ─────────────────────────────────────────────────────────────────
class _ExpandGroup extends StatefulWidget {
  final String title;
  final bool isActive;
  final bool initiallyOpen;
  final List<Widget> children;
  const _ExpandGroup({
    required this.title,
    required this.isActive,
    this.initiallyOpen = false,
    required this.children,
  });

  @override
  State<_ExpandGroup> createState() => _ExpandGroupState();
}

class _ExpandGroupState extends State<_ExpandGroup>
    with SingleTickerProviderStateMixin {
  late bool _open;
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _open = widget.initiallyOpen;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _open ? 1.0 : 0.0,
    );
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
                  widget.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kNavTextOnGold,
                  ),
                ),
              ),
              RotationTransition(
                turns: Tween<double>(begin: 0, end: 0.5).animate(
                  CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
                ),
                child: const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: kNavTextOnGold),
              ),
            ],
          ),
        ),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: _open ? Column(children: widget.children) : const SizedBox.shrink(),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────
// _NavBtn  ── 橫向導覽按鈕
// ─────────────────────────────────────────────────────────────────
class _NavBtn extends StatelessWidget {
  final String label;
  final bool compact, isActive;
  final VoidCallback onTap;
  const _NavBtn({
    required this.label,
    required this.compact,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => _HoverContainer(
    forceHighlight: isActive,
    onTap: onTap,
    builder: (hl) => Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(
            horizontal: compact ? 3 : 4, vertical: 8),
        padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 14, vertical: 6),
        decoration: BoxDecoration(
          color: hl ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: compact ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: hl ? kPrimaryGold : kNavTextOnGold,
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _FloatingMenu  ── 通用 Overlay 浮層（文字開示 & 語言共用）
// ─────────────────────────────────────────────────────────────────
class _FloatingMenu extends StatefulWidget {
  final Offset origin;
  final double triggerHeight;
  final double? rightAlignAt; // 非 null 時右對齊
  final double menuWidth;
  final List<Widget> children;
  final VoidCallback onDismiss;

  const _FloatingMenu({
    required this.origin,
    required this.triggerHeight,
    this.rightAlignAt,
    required this.menuWidth,
    required this.children,
    required this.onDismiss,
  });

  @override
  State<_FloatingMenu> createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<_FloatingMenu>
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
    _slide = Tween(begin: const Offset(0, -0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final left = widget.rightAlignAt != null
        ? widget.rightAlignAt! - widget.menuWidth
        : widget.origin.dx;

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
                    width: widget.menuWidth,
                    decoration: BoxDecoration(
                      color: kPrimaryGold,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 16,
                            offset: Offset(0, 6)),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children,
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
// _MenuRow  ── 通用下拉選單列（文字開示 & 語言共用）
// ─────────────────────────────────────────────────────────────────
class _MenuRow extends StatelessWidget {
  final String? flag;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final double width;

  const _MenuRow({
    this.flag,
    required this.label,
    this.isActive = false,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) => _HoverContainer(
    forceHighlight: isActive,
    onTap: onTap,
    builder: (hl) => AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: width,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: hl ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (flag != null) ...[
            Text(flag!, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: flag != null ? 13 : 14,
                fontWeight: FontWeight.w500,
                color: hl ? kPrimaryGold : kNavTextOnGold,
              ),
            ),
          ),
          if (isActive)
            Icon(Icons.check_rounded,
                size: 15, color: hl ? kPrimaryGold : kNavTextOnGold),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _OverlayTrigger mixin  ── Overlay 生命週期管理
// ─────────────────────────────────────────────────────────────────
mixin _OverlayTrigger<T extends StatefulWidget> on State<T> {
  OverlayEntry? _entry;
  bool overlayOpen = false;

  void showOverlay(OverlayEntry entry) {
    if (_entry != null) return;
    _entry = entry;
    setState(() => overlayOpen = true);
    Overlay.of(context).insert(_entry!);
  }

  void hideOverlay() {
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() => overlayOpen = false);
  }

  @override
  void dispose() {
    _entry?.remove();
    _entry = null;
    super.dispose();
  }

  OverlayEntry buildEntry(WidgetBuilder builder) =>
      OverlayEntry(builder: builder);

  (Offset origin, double w, double h) triggerMetrics() {
    final box = context.findRenderObject() as RenderBox;
    final ovlBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    return (
      box.localToGlobal(Offset.zero, ancestor: ovlBox),
      box.size.width,
      box.size.height,
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _DropdownBtn  ── 「文字開示」觸發鈕
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

class _DropdownBtnState extends State<_DropdownBtn>
    with _OverlayTrigger<_DropdownBtn> {
  void _show() {
    final (origin, _, h) = triggerMetrics();
    showOverlay(buildEntry((_) => _FloatingMenu(
      origin: origin,
      triggerHeight: h,
      menuWidth: 130,
      onDismiss: hideOverlay,
      children: _kNavItems
          .map((e) => _MenuRow(
                label: e.label,
                onTap: () {
                  hideOverlay();
                  widget.onPageChanged(e.page);
                },
                width: 130,
              ))
          .toList(),
    )));
  }

  @override
  Widget build(BuildContext context) => _HoverContainer(
    forceHighlight: widget.isActive || overlayOpen,
    onTap: () => overlayOpen ? hideOverlay() : _show(),
    onEnter: _show,
    builder: (hl) => Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(
            horizontal: widget.compact ? 3 : 4, vertical: 8),
        padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 10 : 14, vertical: 6),
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
            Icon(Icons.keyboard_arrow_down,
                size: 18, color: hl ? kPrimaryGold : kNavTextOnGold),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _LangDropdownBtn  ── 語言切換觸發鈕
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

class _LangDropdownBtnState extends State<_LangDropdownBtn>
    with _OverlayTrigger<_LangDropdownBtn> {
  void _show() {
    final (origin, w, h) = triggerMetrics();
    showOverlay(buildEntry((_) => _FloatingMenu(
      origin: origin,
      triggerHeight: h,
      rightAlignAt: origin.dx + w,
      menuWidth: 170,
      onDismiss: hideOverlay,
      children: _kLanguages
          .map((e) => _MenuRow(
                flag: e.flag,
                label: e.label,
                isActive: widget.currentCode == e.code,
                onTap: () {
                  hideOverlay();
                  widget.onLanguageChanged(e.code);
                },
                width: 170,
              ))
          .toList(),
    )));
  }

  @override
  Widget build(BuildContext context) => _HoverContainer(
    forceHighlight: overlayOpen,
    onTap: () => overlayOpen ? hideOverlay() : _show(),
    onEnter: _show,
    builder: (hl) => Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(
            horizontal: widget.compact ? 3 : 6, vertical: 8),
        padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 8 : 12, vertical: 6),
        decoration: BoxDecoration(
          color: hl ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_langFlag(widget.currentCode),
                style: TextStyle(fontSize: widget.compact ? 14 : 16)),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down,
                size: 18, color: hl ? kPrimaryGold : kNavTextOnGold),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _IconBtn  ── Hamburger / Close
// ─────────────────────────────────────────────────────────────────
class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn(this.icon, this.onTap);

  @override
  Widget build(BuildContext context) => _HoverContainer(
    onTap: onTap,
    builder: (hl) => AnimatedContainer(
      duration: const Duration(milliseconds: 130),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: hl ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(icon,
          color: hl ? kPrimaryGold : kNavTextOnGold, size: 26),
    ),
  );
}