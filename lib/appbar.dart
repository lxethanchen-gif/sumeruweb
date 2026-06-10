import 'package:flutter/material.dart';
import '../routes.dart';
import 'translation_service.dart';

// ── 常數 ──────────────────────────────────────────────────────────
const Color kPrimaryGold   = Color(0xFFF5C518);
const Color kNavTextOnGold = Colors.white;

// ── 工具 ──────────────────────────────────────────────────────────
bool _isMobile(BuildContext ctx)  => MediaQuery.sizeOf(ctx).width < 600;
bool _isTablet(BuildContext ctx)  => MediaQuery.sizeOf(ctx).width < 1024;

List<({String label, int page})> _navItems(AppStrings s) => [
  (label: s.dharmaRealize, page: PageIndex.dharmaRealize),
  (label: s.yingShiJuan,   page: PageIndex.yingShiJuan),
  (label: s.mieZuiJuan,    page: PageIndex.mieZuiJuan),
  (label: s.jiYuanDaoZhi,  page: PageIndex.jiYuanDaoZhi),
  (label: s.shiZhai,       page: PageIndex.shiZhai),
];

// ─────────────────────────────────────────────────────────────────
// SumeruLogo
// ─────────────────────────────────────────────────────────────────
class SumeruLogo extends StatelessWidget {
  final bool compact;
  const SumeruLogo({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final s = TranslationScope.strings(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo_with_border.png',
              width: compact ? 36 : 44, height: compact ? 36 : 44,
              fit: BoxFit.contain),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.siteTitle,
                  style: TextStyle(
                    fontSize: compact ? 13 : 15, fontWeight: FontWeight.bold,
                    color: kNavTextOnGold, letterSpacing: 1.5, height: 1.2,
                  )),
              if (!compact) ...[
                const SizedBox(height: 2),
                Text(s.siteSubtitle,
                    style: const TextStyle(fontSize: 9, color: Color(0xFFFFF0B0),
                        letterSpacing: 0.8, height: 1.2)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// SumeruAppBar  ── 入口，依寬度切換佈局
// ─────────────────────────────────────────────────────────────────
class SumeruAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  const SumeruAppBar({super.key, required this.currentIndex, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    if (_isMobile(context)) {
      return _MobileAppBar(currentIndex: currentIndex, onPageChanged: onPageChanged);
    }
    return _HorizontalAppBar(
      currentIndex: currentIndex,
      onPageChanged: onPageChanged,
      compact: _isTablet(context),
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
  const _HorizontalAppBar({
    required this.currentIndex, required this.onPageChanged, required this.compact});

  @override
  Widget build(BuildContext context) {
    final s = TranslationScope.strings(context);
    final notifier = TranslationScope.of(context);
    return Material(
      elevation: 6, shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(16), color: kPrimaryGold,
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
                      _NavBtn(s.home, compact, currentIndex == PageIndex.home,
                          () => onPageChanged(PageIndex.home)),
                      _DropdownBtn(
                        isActive: PageIndex.isTextTeachings(currentIndex),
                        onPageChanged: onPageChanged, compact: compact),
                      _NavBtn(compact ? s.videoCompact : s.videoTeachings, compact,
                          currentIndex == PageIndex.videoTeachings,
                          () => onPageChanged(PageIndex.videoTeachings)),
                      _NavBtn(compact ? s.resourceCompact : s.resourceLinks, compact,
                          currentIndex == PageIndex.resourceLinks,
                          () => onPageChanged(PageIndex.resourceLinks)),
                      _NavBtn(compact ? s.buddhaCompact : s.buddhaIntro, compact,
                          currentIndex == PageIndex.buddhaIntro,
                          () => onPageChanged(PageIndex.buddhaIntro)),
                    ],
                  ),
                ),
              ),
              // ── 翻譯按鈕 (右側) ──
              Container(width: 1, color: Colors.white24),
              _TranslateBtn(notifier: notifier, compact: compact),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _MobileAppBar  ── Hamburger + Sidebar
// ─────────────────────────────────────────────────────────────────
class _MobileAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  const _MobileAppBar({required this.currentIndex, required this.onPageChanged});

  void _openDrawer(BuildContext ctx) => showGeneralDialog(
    context: ctx,
    barrierDismissible: true, barrierLabel: 'Dismiss',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, __) {
      final slide = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return Stack(children: [
        GestureDetector(onTap: () => Navigator.of(ctx).pop(),
            child: const SizedBox.expand()),
        SlideTransition(
          position: Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(slide),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _SidebarPanel(
              currentIndex: currentIndex,
              onPageChanged: (idx) { Navigator.of(ctx).pop(); onPageChanged(idx); },
            ),
          ),
        ),
      ]);
    },
  );

  @override
  Widget build(BuildContext context) {
    final notifier = TranslationScope.of(context);
    return Material(
      elevation: 6, shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(14), color: kPrimaryGold,
      child: SizedBox(
        height: 52,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Row(children: [
            const Expanded(child: SumeruLogo(compact: true)),
            // ── 翻譯按鈕 (行動版) ──
            _TranslateBtn(notifier: notifier, compact: true),
            Container(width: 1, color: Colors.white24),
            _IconBtn(Icons.menu_rounded, () => _openDrawer(context)),
            const SizedBox(width: 8),
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _TranslateBtn  ── 語言切換觸發鈕 (含 loading 狀態)
// ─────────────────────────────────────────────────────────────────
class _TranslateBtn extends StatefulWidget {
  final TranslationNotifier notifier;
  final bool compact;
  const _TranslateBtn({required this.notifier, this.compact = false});

  @override
  State<_TranslateBtn> createState() => _TranslateBtnState();
}

class _TranslateBtnState extends State<_TranslateBtn> {
  bool _hov = false;
  OverlayEntry? _entry;

  void _show() {
    if (_entry != null) return;
    final box    = context.findRenderObject() as RenderBox;
    final ovlBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    final origin = box.localToGlobal(Offset.zero, ancestor: ovlBox);
    _entry = OverlayEntry(builder: (_) => _LangPickerOverlay(
      origin: origin, triggerWidth: box.size.width,
      triggerHeight: box.size.height,
      notifier: widget.notifier,
      onDismiss: _hide,
    ));
    setState(() {});
    Overlay.of(context).insert(_entry!);
  }

  void _hide() {
    _entry?.remove(); _entry = null;
    if (mounted) setState(() {});
  }

  @override
  void dispose() { _entry?.remove(); _entry = null; super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final open = _entry != null;
    final hl   = _hov || open;
    final lang = widget.notifier.currentLang;

    return ListenableBuilder(
      listenable: widget.notifier,
      builder: (_, __) {
        final loading = widget.notifier.isLoading;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hov = true),
          onExit:  (_) => setState(() => _hov = false),
          child: GestureDetector(
            onTap: open ? _hide : _show,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.symmetric(
                  horizontal: widget.compact ? 4 : 6, vertical: 8),
              padding: EdgeInsets.symmetric(
                  horizontal: widget.compact ? 8 : 12, vertical: 6),
              decoration: BoxDecoration(
                  color: hl ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                if (loading)
                  SizedBox(
                    width: 14, height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: hl ? kPrimaryGold : kNavTextOnGold,
                    ),
                  )
                else
                  Text(lang.flag,
                      style: const TextStyle(fontSize: 16, height: 1)),
                const SizedBox(width: 5),
                Icon(Icons.translate_rounded,
                    size: widget.compact ? 16 : 17,
                    color: hl ? kPrimaryGold : kNavTextOnGold),
                const SizedBox(width: 3),
                Icon(Icons.keyboard_arrow_down, size: 16,
                    color: hl ? kPrimaryGold : kNavTextOnGold),
              ]),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _LangPickerOverlay  ── 浮層語言清單
// ─────────────────────────────────────────────────────────────────
class _LangPickerOverlay extends StatefulWidget {
  final Offset origin;
  final double triggerWidth, triggerHeight;
  final TranslationNotifier notifier;
  final VoidCallback onDismiss;
  const _LangPickerOverlay({
    required this.origin, required this.triggerWidth, required this.triggerHeight,
    required this.notifier, required this.onDismiss});

  @override
  State<_LangPickerOverlay> createState() => _LangPickerOverlayState();
}

class _LangPickerOverlayState extends State<_LangPickerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 180))..forward();
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, -0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    // 從右側對齊：面板右緣 = 觸發按鈕右緣
    const panelWidth = 220.0;
    final left = widget.origin.dx + widget.triggerWidth - panelWidth;

    return Stack(children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: widget.onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),
      ),
      Positioned(
        top:  widget.origin.dy + widget.triggerHeight + 10,
        left: left.clamp(8.0, double.infinity),
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Material(
              elevation: 12, color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: panelWidth,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.65),
                decoration: BoxDecoration(
                  color: kPrimaryGold,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(
                      color: Colors.black26, blurRadius: 20, offset: Offset(0, 8))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // ── 標題列 ──
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: const BoxDecoration(
                          color: Color(0xFFD4A800),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Row(children: [
                        const Icon(Icons.translate_rounded,
                            size: 16, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text('選擇語言',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                                color: Colors.white, letterSpacing: 1)),
                        const Spacer(),
                        ListenableBuilder(
                          listenable: widget.notifier,
                          builder: (_, __) => widget.notifier.isLoading
                              ? const SizedBox(width: 14, height: 14,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                              : const SizedBox.shrink(),
                        ),
                      ]),
                    ),
                    // ── 語言清單 ──
                    Flexible(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        shrinkWrap: true,
                        itemCount: kSupportedLanguages.length,
                        itemBuilder: (_, i) {
                          final lang = kSupportedLanguages[i];
                          return ListenableBuilder(
                            listenable: widget.notifier,
                            builder: (_, __) => _LangRow(
                              lang: lang,
                              isSelected: widget.notifier.langCode == lang.code,
                              onTap: () {
                                widget.notifier.setLanguage(lang.code);
                                widget.onDismiss();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────
// _LangRow  ── 語言清單列
// ─────────────────────────────────────────────────────────────────
class _LangRow extends StatefulWidget {
  final SupportedLanguage lang;
  final bool isSelected;
  final VoidCallback onTap;
  const _LangRow({required this.lang, required this.isSelected, required this.onTap});

  @override
  State<_LangRow> createState() => _LangRowState();
}

class _LangRowState extends State<_LangRow> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final hl = widget.isSelected || _hov;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          margin: const EdgeInsets.symmetric(vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: hl ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Text(widget.lang.flag, style: const TextStyle(fontSize: 18, height: 1)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(widget.lang.nativeName,
                  style: TextStyle(
                      fontSize: 13.5, fontWeight: FontWeight.w500,
                      color: hl ? kPrimaryGold : kNavTextOnGold)),
            ),
            if (widget.isSelected)
              Icon(Icons.check_rounded, size: 16,
                  color: hl ? kPrimaryGold : kNavTextOnGold),
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _SidebarPanel
// ─────────────────────────────────────────────────────────────────
class _SidebarPanel extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  const _SidebarPanel({required this.currentIndex, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    final s = TranslationScope.strings(context);
    return Material(
      elevation: 16, color: kPrimaryGold,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: SizedBox(
        width: 270, height: double.infinity,
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 8, 4),
              child: Align(alignment: Alignment.centerRight,
                  child: _IconBtn(Icons.close_rounded, () => Navigator.of(context).pop())),
            ),
            Container(height: 1, color: Colors.white24,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: [
                  _SidebarItem(s.home, currentIndex == PageIndex.home,
                      () => onPageChanged(PageIndex.home)),
                  _SidebarExpand(
                    isActive: PageIndex.isTextTeachings(currentIndex),
                    currentIndex: currentIndex, onPageChanged: onPageChanged),
                  _SidebarItem(s.videoTeachings, currentIndex == PageIndex.videoTeachings,
                      () => onPageChanged(PageIndex.videoTeachings)),
                  _SidebarItem(s.resourceLinks, currentIndex == PageIndex.resourceLinks,
                      () => onPageChanged(PageIndex.resourceLinks)),
                  _SidebarItem(s.buddhaIntro, currentIndex == PageIndex.buddhaIntro,
                      () => onPageChanged(PageIndex.buddhaIntro)),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _SidebarItem
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
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(
              left: 16 + widget.indent, right: 16, top: 12, bottom: 12),
          decoration: BoxDecoration(
              color: hl ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(widget.label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                  color: hl ? kPrimaryGold : kNavTextOnGold)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _SidebarExpand
// ─────────────────────────────────────────────────────────────────
class _SidebarExpand extends StatefulWidget {
  final bool isActive;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  const _SidebarExpand({
    required this.isActive, required this.currentIndex, required this.onPageChanged});

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
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 200), value: _open ? 1.0 : 0.0);
    _rot = Tween<double>(begin: 0, end: 0.5)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _toggle() {
    setState(() => _open = !_open);
    _open ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final s = TranslationScope.strings(context);
    final items = _navItems(s);
    return Column(
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
                color: widget.isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(child: Text(s.textTeachings,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                      color: kNavTextOnGold))),
              RotationTransition(turns: _rot,
                  child: const Icon(Icons.keyboard_arrow_down,
                      size: 20, color: kNavTextOnGold)),
            ]),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic,
          child: _open
              ? Column(children: items.map((e) => _SidebarItem(
                  e.label, widget.currentIndex == e.page,
                  () => widget.onPageChanged(e.page), indent: 16)).toList())
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _NavBtn
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
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(
                horizontal: widget.compact ? 3 : 4, vertical: 8),
            padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? 10 : 14, vertical: 6),
            decoration: BoxDecoration(
                color: hl ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20)),
            child: Text(widget.label,
                style: TextStyle(
                    fontSize: widget.compact ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: hl ? kPrimaryGold : kNavTextOnGold)),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _DropdownBtn
// ─────────────────────────────────────────────────────────────────
class _DropdownBtn extends StatefulWidget {
  final bool isActive, compact;
  final ValueChanged<int> onPageChanged;
  const _DropdownBtn({
    required this.isActive, required this.onPageChanged, this.compact = false});

  @override
  State<_DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<_DropdownBtn> {
  bool _hov = false, _open = false;
  OverlayEntry? _entry;

  void _show() {
    if (_entry != null) return;
    final box     = context.findRenderObject() as RenderBox;
    final ovlBox  = Overlay.of(context).context.findRenderObject() as RenderBox;
    final origin  = box.localToGlobal(Offset.zero, ancestor: ovlBox);
    _entry = OverlayEntry(builder: (ctx) => _DropdownOverlay(
      origin: origin, triggerHeight: box.size.height,
      onSelected: (idx) { _hide(); widget.onPageChanged(idx); },
      onDismiss: _hide,
    ));
    setState(() => _open = true);
    Overlay.of(context).insert(_entry!);
  }

  void _hide() {
    _entry?.remove(); _entry = null;
    if (mounted) setState(() => _open = false);
  }

  @override
  void dispose() { _entry?.remove(); _entry = null; super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final s  = TranslationScope.strings(context);
    final hl = widget.isActive || _hov || _open;
    return GestureDetector(
      onTap: () => _open ? _hide() : _show(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) { setState(() => _hov = true); _show(); },
        onExit:  (_) => setState(() => _hov = false),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(
                horizontal: widget.compact ? 3 : 4, vertical: 8),
            padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? 10 : 14, vertical: 6),
            decoration: BoxDecoration(
                color: hl ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(s.textTeachings,
                  style: TextStyle(
                      fontSize: widget.compact ? 13 : 14,
                      fontWeight: FontWeight.w600,
                      color: hl ? kPrimaryGold : kNavTextOnGold)),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 18,
                  color: hl ? kPrimaryGold : kNavTextOnGold),
            ]),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _DropdownOverlay
// ─────────────────────────────────────────────────────────────────
class _DropdownOverlay extends StatefulWidget {
  final Offset origin;
  final double triggerHeight;
  final ValueChanged<int> onSelected;
  final VoidCallback onDismiss;
  const _DropdownOverlay({
    required this.origin, required this.triggerHeight,
    required this.onSelected, required this.onDismiss});

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
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 160))..forward();
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, -0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final s = TranslationScope.strings(context);
    final items = _navItems(s);
    return Stack(children: [
      Positioned.fill(
        child: GestureDetector(onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand()),
      ),
      Positioned(
        top:  widget.origin.dy + widget.triggerHeight + 10,
        left: widget.origin.dx,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: MouseRegion(
              onExit: (_) => widget.onDismiss(),
              child: Material(
                elevation: 10, color: Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryGold,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [BoxShadow(
                          color: Colors.black26, blurRadius: 16, offset: Offset(0, 6))]),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items.map((e) => _DropdownRow(
                        label: e.label, onTap: () => widget.onSelected(e.page))).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────
// _DropdownRow
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
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 130, height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: _hov ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.centerLeft,
        child: Text(widget.label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                color: _hov ? kPrimaryGold : kNavTextOnGold)),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────
// _IconBtn
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
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        width: 40, height: 40,
        decoration: BoxDecoration(
            color: _hov ? Colors.white : Colors.transparent,
            shape: BoxShape.circle),
        child: Icon(widget.icon,
            color: _hov ? kPrimaryGold : kNavTextOnGold, size: 26),
      ),
    ),
  );
}