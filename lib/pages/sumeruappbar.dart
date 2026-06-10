import 'package:flutter/material.dart';
import '../routes.dart';

// ── 色彩常數 ──────────────────────────────────────────────────────
const Color kPrimaryGold   = Color(0xFFF5C518);
const Color kNavTextOnGold = Colors.white;

// ── 斷點 ─────────────────────────────────────────────────────────
const double kBreakpointTablet  = 600;
const double kBreakpointDesktop = 1024;

enum _ScreenSize { mobile, tablet, desktop }

_ScreenSize _screenSizeOf(BuildContext context) {
  final w = MediaQuery.sizeOf(context).width;
  if (w >= kBreakpointDesktop) return _ScreenSize.desktop;
  if (w >= kBreakpointTablet)  return _ScreenSize.tablet;
  return _ScreenSize.mobile;
}

// ═══════════════════════════════════════════════════════════════════
// SumeruLogo  ── 圖示 + 中文標題 (+ 英文副標)
// ═══════════════════════════════════════════════════════════════════
class SumeruLogo extends StatelessWidget {
  /// [compact] = tablet/mobile 縮略模式：圖示縮小、隱藏英文副標題
  final bool compact;
  const SumeruLogo({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_with_border.png',
            width:  compact ? 36 : 44,
            height: compact ? 36 : 44,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          // ── 文字欄（不用 Column mainAxisAlignment，改用顯式 spacing）
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
}

// ═══════════════════════════════════════════════════════════════════
// SumeruAppBar  ── 自適應三種尺寸
// ═══════════════════════════════════════════════════════════════════
class SumeruAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const SumeruAppBar({
    super.key,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = _screenSizeOf(context);
    return switch (size) {
      _ScreenSize.mobile  => _MobileAppBar(
          currentIndex: currentIndex, onPageChanged: onPageChanged),
      _ScreenSize.tablet  => _HorizontalAppBar(
          currentIndex: currentIndex, onPageChanged: onPageChanged, compact: true),
      _ScreenSize.desktop => _HorizontalAppBar(
          currentIndex: currentIndex, onPageChanged: onPageChanged, compact: false),
    };
  }
}

// ═══════════════════════════════════════════════════════════════════
// _HorizontalAppBar  ── Desktop / Tablet 共用橫向列
// ═══════════════════════════════════════════════════════════════════
class _HorizontalAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final bool compact;

  const _HorizontalAppBar({
    required this.currentIndex,
    required this.onPageChanged,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
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
                      _NavButton(
                        label: '首頁',
                        compact: compact,
                        isActive: currentIndex == PageIndex.home,
                        onTap: () => onPageChanged(PageIndex.home),
                      ),
                      _TextTeachingsDropdown(
                        isActive: PageIndex.isTextTeachings(currentIndex),
                        onPageChanged: onPageChanged,
                        compact: compact,
                      ),
                      _NavButton(
                        label: compact ? '影音' : '影音開示',
                        compact: compact,
                        isActive: currentIndex == PageIndex.videoTeachings,
                        onTap: () => onPageChanged(PageIndex.videoTeachings),
                      ),
                      _NavButton(
                        label: compact ? '資源' : '資源連結',
                        compact: compact,
                        isActive: currentIndex == PageIndex.resourceLinks,
                        onTap: () => onPageChanged(PageIndex.resourceLinks),
                      ),
                      _NavButton(
                        label: compact ? '簡介' : '諦深佛陀簡介',
                        compact: compact,
                        isActive: currentIndex == PageIndex.buddhaIntro,
                        onTap: () => onPageChanged(PageIndex.buddhaIntro),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// _MobileAppBar  ── Hamburger + Sidebar
// ═══════════════════════════════════════════════════════════════════
class _MobileAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const _MobileAppBar({
    required this.currentIndex,
    required this.onPageChanged,
  });

  void _openDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (ctx, anim, _) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim, _, __) {
        final slide = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: const SizedBox.expand(),
            ),
            SlideTransition(
              position: Tween<Offset>(
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
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
              _HoverIconButton(
                icon: Icons.menu_rounded,
                onTap: () => _openDrawer(context),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// _SidebarPanel  ── Mobile 側邊欄主體
// ═══════════════════════════════════════════════════════════════════
class _SidebarPanel extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const _SidebarPanel({
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
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
              // ── Header：關閉鈕 ──────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 8, 4),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _HoverIconButton(
                    icon: Icons.close_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.white24,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              ),
              // ── 選單列表 ──────────────────────────────────────
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  children: [
                    _SidebarItem(
                      label: '首頁',
                      isActive: currentIndex == PageIndex.home,
                      onTap: () => onPageChanged(PageIndex.home),
                    ),
                    _SidebarExpandable(
                      label: '文字開示',
                      isActive: PageIndex.isTextTeachings(currentIndex),
                      currentIndex: currentIndex,
                      onPageChanged: onPageChanged,
                      children: const [
                        _DropdownItem(label: '了解佛法', pageIndex: PageIndex.dharmaRealize),
                        _DropdownItem(label: '應世卷',   pageIndex: PageIndex.yingShiJuan),
                        _DropdownItem(label: '滅罪卷',   pageIndex: PageIndex.mieZuiJuan),
                        _DropdownItem(label: '機緣道旨', pageIndex: PageIndex.jiYuanDaoZhi),
                        _DropdownItem(label: '詩摘',     pageIndex: PageIndex.shiZhai),
                      ],
                    ),
                    _SidebarItem(
                      label: '影音開示',
                      isActive: currentIndex == PageIndex.videoTeachings,
                      onTap: () => onPageChanged(PageIndex.videoTeachings),
                    ),
                    _SidebarItem(
                      label: '資源連結',
                      isActive: currentIndex == PageIndex.resourceLinks,
                      onTap: () => onPageChanged(PageIndex.resourceLinks),
                    ),
                    _SidebarItem(
                      label: '諦深佛陀簡介',
                      isActive: currentIndex == PageIndex.buddhaIntro,
                      onTap: () => onPageChanged(PageIndex.buddhaIntro),
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
}

// ═══════════════════════════════════════════════════════════════════
// _SidebarItem  ── 單列，active / hover → 白底金字
// ═══════════════════════════════════════════════════════════════════
class _SidebarItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final double indent;

  const _SidebarItem({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.indent = 0,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final hl = widget.isActive || _hovering;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit:  (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(
              left: 16 + widget.indent, right: 16, top: 12, bottom: 12),
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

// ═══════════════════════════════════════════════════════════════════
// _SidebarExpandable  ── 可展開「文字開示」群組
// ═══════════════════════════════════════════════════════════════════
class _SidebarExpandable extends StatefulWidget {
  final String label;
  final bool isActive;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final List<_DropdownItem> children;

  const _SidebarExpandable({
    required this.label,
    required this.isActive,
    required this.currentIndex,
    required this.onPageChanged,
    required this.children,
  });

  @override
  State<_SidebarExpandable> createState() => _SidebarExpandableState();
}

class _SidebarExpandableState extends State<_SidebarExpandable>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _ctrl;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isActive;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _expanded ? 1.0 : 0.0,
    );
    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 130),
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
                    widget.label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kNavTextOnGold,
                    ),
                  ),
                ),
                RotationTransition(
                  turns: _rotation,
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
          child: _expanded
              ? Column(
                  children: widget.children
                      .map((item) => _SidebarItem(
                            label: item.label,
                            indent: 16,
                            isActive: widget.currentIndex == item.pageIndex,
                            onTap: () => widget.onPageChanged(item.pageIndex),
                          ))
                      .toList(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// _NavButton  ── Desktop / Tablet 導覽按鈕
// ═══════════════════════════════════════════════════════════════════
class _NavButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final bool compact;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.compact = false,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final hl = widget.isActive || _hovering;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit:  (_) => setState(() => _hovering = false),
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

// ═══════════════════════════════════════════════════════════════════
// _TextTeachingsDropdown  ── 自訂 OverlayEntry 選單，右側含 Logo
// ═══════════════════════════════════════════════════════════════════
class _TextTeachingsDropdown extends StatefulWidget {
  final bool isActive;
  final ValueChanged<int> onPageChanged;
  final bool compact;

  const _TextTeachingsDropdown({
    required this.isActive,
    required this.onPageChanged,
    this.compact = false,
  });

  @override
  State<_TextTeachingsDropdown> createState() => _TextTeachingsDropdownState();
}

class _TextTeachingsDropdownState extends State<_TextTeachingsDropdown> {
  bool _hovering = false;
  bool _overlayOpen = false;
  OverlayEntry? _overlayEntry;

  static const List<_DropdownItem> _items = [
    _DropdownItem(label: '了解佛法', pageIndex: PageIndex.dharmaRealize),
    _DropdownItem(label: '應世卷',   pageIndex: PageIndex.yingShiJuan),
    _DropdownItem(label: '滅罪卷',   pageIndex: PageIndex.mieZuiJuan),
    _DropdownItem(label: '機緣道旨', pageIndex: PageIndex.jiYuanDaoZhi),
    _DropdownItem(label: '詩摘',     pageIndex: PageIndex.shiZhai),
  ];

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final RenderBox box        = context.findRenderObject() as RenderBox;
    final RenderBox overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset origin = box.localToGlobal(Offset.zero, ancestor: overlayBox);
    _overlayEntry = OverlayEntry(
      builder: (_) => _DropdownOverlay(
        origin: origin,
        triggerWidth: box.size.width,
        triggerHeight: box.size.height,
        items: _items,
        onSelected: (idx) {
          _removeOverlay();
          widget.onPageChanged(idx);
        },
        onDismiss: _removeOverlay,
      ),
    );
    setState(() => _overlayOpen = true);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _overlayOpen = false);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 滑鼠在按鈕上，或選單展開中，都維持 highlight
    final hl = widget.isActive || _hovering || _overlayOpen;
    return GestureDetector(
      onTap: () => _overlayOpen ? _removeOverlay() : _showOverlay(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _hovering = true);
          _showOverlay();
        },
        onExit: (_) => setState(() => _hovering = false),
        child: Center(
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
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// _DropdownOverlay  ── 浮層選單本體（金色底 + 右側 Logo 區）
// ═══════════════════════════════════════════════════════════════════
class _DropdownOverlay extends StatefulWidget {
  final Offset origin;
  final double triggerWidth;
  final double triggerHeight;
  final List<_DropdownItem> items;
  final ValueChanged<int> onSelected;
  final VoidCallback onDismiss;
  const _DropdownOverlay({
    required this.origin,
    required this.triggerWidth,
    required this.triggerHeight,
    required this.items,
    required this.onSelected,
    required this.onDismiss,
  });

  @override
  State<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 160));
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, -0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // ── 選單定位：觸發按鈕正下方，左對齊 ──
  static const double _menuTop = 10.0; // AppBar 底部到選單頂部的間距

  @override
  Widget build(BuildContext context) {
    final top  = widget.origin.dy + widget.triggerHeight + _menuTop;
    final left = widget.origin.dx;

    return Stack(
      children: [
        // 全螢幕透明層：點擊任意處關閉
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
        ),
        // 選單本體
        Positioned(
          top: top,
          left: left,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: MouseRegion(
                // 滑鼠移入選單時不觸發 onDismiss
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
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ── 左欄：選單項目 ────────────────────
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.items
                                  .map((item) => _DropdownMenuRow(
                                        label: item.label,
                                        onTap: () => widget.onSelected(item.pageIndex),
                                      ))
                                  .toList(),
                            ),
                          ),

                        ],
                      ),
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

// ═══════════════════════════════════════════════════════════════════
// _DropdownMenuRow  ── hover: 白底金字
// ═══════════════════════════════════════════════════════════════════
class _DropdownMenuRow extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _DropdownMenuRow({required this.label, required this.onTap});

  @override
  State<_DropdownMenuRow> createState() => _DropdownMenuRowState();
}

class _DropdownMenuRowState extends State<_DropdownMenuRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit:  (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: 130,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: _hovering ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _hovering ? kPrimaryGold : kNavTextOnGold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// _HoverIconButton  ── Hamburger / Close 按鈕，hover 白底圓圈
// ═══════════════════════════════════════════════════════════════════
class _HoverIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HoverIconButton({required this.icon, required this.onTap});

  @override
  State<_HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<_HoverIconButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit:  (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _hovering ? Colors.white : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.icon,
            color: _hovering ? kPrimaryGold : kNavTextOnGold,
            size: 26,
          ),
        ),
      ),
    );
  }
}

// ── 資料類別 ──────────────────────────────────────────────────────
class _DropdownItem {
  final String label;
  final int pageIndex;
  const _DropdownItem({required this.label, required this.pageIndex});
}