import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'yingshijuan_data.dart';

// ── 常數 ────────────────────────────────────────────────────────
const _kGold     = Color(0xFFF5C518);
const _kGoldDim  = Color(0xFFB8960E);
const _kPageSize = 20;

// 預先計算的不透明色（避免 runtime withOpacity 分配）
const _kGoldBorder     = Color(0x59F5C518); // gold @ 35%
const _kGoldBorderNav  = Color(0x73F5C518); // gold @ 45%
const _kGoldBorderDim  = Color(0x26F5C518); // gold @ 15%
const _kGoldIconDim    = Color(0x40F5C518); // gold @ 25%
const _kCopyIconColor  = Color(0x99B8960E); // goldDim @ 60%
const _kDividerColor   = Color(0x33F5C518); // gold @ 20%

const _kCardShadow = BoxShadow(
  color: Color(0x14000000),
  blurRadius: 10,
  offset: Offset(0, 4),
);

// 預建靜態裝飾（每次 build 不再重新分配）
const _kCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(16)),
  boxShadow: [_kCardShadow],
);
const _kCardPadding = EdgeInsets.fromLTRB(18, 20, 14, 16);

// 文字樣式
const _kBodyStyle   = TextStyle(fontSize: 13.5, color: _kGoldDim, height: 1.7);
const _kTitleStyle  = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _kGold, height: 1.4);
const _kExpandStyle = TextStyle(fontSize: 12, color: _kGold, fontWeight: FontWeight.w600);

// 靜態 Icon（不依賴狀態，const 化避免重建）
const _kCheckIcon = Icon(Icons.check_rounded,        key: ValueKey(true),  size: 16, color: _kGold);
const _kArrowIcon = Icon(Icons.keyboard_arrow_down,  size: 16, color: _kGold);

typedef _Card = ({String title, String? date, String body});

// ── RWD 欄數 ────────────────────────────────────────────────────
int _gridCols(double w) =>
    w < 480 ? 1 : w < 720 ? 2 : w < 960 ? 3 : w < 1200 ? 4 : w < 1440 ? 5 : 6;

// ── Page ────────────────────────────────────────────────────────
class YingShiJuanPage extends StatefulWidget {
  const YingShiJuanPage({super.key});

  @override
  State<YingShiJuanPage> createState() => _YingShiJuanPageState();
}

class _YingShiJuanPageState extends State<YingShiJuanPage> {
  final _scroll = ScrollController();
  int _currentPage = 0;

  // 只算一次
  static final int _pageCount = (kYingShiJuanCards.length / _kPageSize).ceil();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    if (page == _currentPage) return;
    setState(() => _currentPage = page);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scroll.jumpTo(0));
  }

  @override
  Widget build(BuildContext context) {
    final start = _currentPage * _kPageSize;
    final end   = (start + _kPageSize).clamp(0, kYingShiJuanCards.length);

    return ColoredBox(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (_, constraints) => CustomScrollView(
          controller: _scroll,
          // 關閉過度捲動發光效果，減少 GPU layer
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _gridCols(constraints.maxWidth),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 260,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _TeachingCard(
                    // 傳入穩定 key，讓 Flutter 複用 element 而非重建
                    key: ValueKey(start + i),
                    card: kYingShiJuanCards[start + i],
                  ),
                  childCount: end - start,
                  // 告知 framework 卡片之間彼此獨立，可安全跳過 diff
                  addRepaintBoundaries: true,
                  addAutomaticKeepAlives: false,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              sliver: SliverToBoxAdapter(
                child: _PageNav(
                  currentPage: _currentPage,
                  pageCount: _pageCount,
                  onChanged: _goToPage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 分頁導覽列 ────────────────────────────────────────────────────
class _PageNav extends StatelessWidget {
  const _PageNav({
    required this.currentPage,
    required this.pageCount,
    required this.onChanged,
  });

  final int currentPage;
  final int pageCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          _NavBtn(
            icon: Icons.chevron_left_rounded,
            enabled: currentPage > 0,
            onTap: () => onChanged(currentPage - 1),
          ),
          for (var i = 0; i < pageCount; i++)
            _PageDot(
              key: ValueKey(i),
              index: i,
              selected: i == currentPage,
              onTap: () => onChanged(i),
            ),
          _NavBtn(
            icon: Icons.chevron_right_rounded,
            enabled: currentPage < pageCount - 1,
            onTap: () => onChanged(currentPage + 1),
          ),
        ],
      ),
    );
  }
}

// RepaintBoundary 包住導覽列，避免卡片更新時波及此區
class _PageDot extends StatelessWidget {
  const _PageDot({
    super.key,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final VoidCallback onTap;

  // 預建兩套靜態樣式
  static const _selStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white);
  static const _unselStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _kGoldDim);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? _kGold : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? _kGold : _kGoldBorder,
            width: 1.2,
          ),
        ),
        child: Text('${index + 1}', style: selected ? _selStyle : _unselStyle),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  const _NavBtn({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? _kGoldBorderNav : _kGoldBorderDim,
            width: 1.2,
          ),
        ),
        child: Icon(icon, size: 18, color: enabled ? _kGold : _kGoldIconDim),
      ),
    );
  }
}

// ── 教學卡片 ────────────────────────────────────────────────────
// RepaintBoundary：卡片展開/複製時只重繪自身，不影響其他卡片
class _TeachingCard extends StatefulWidget {
  const _TeachingCard({super.key, required this.card});

  final _Card card;

  @override
  State<_TeachingCard> createState() => _TeachingCardState();
}

class _TeachingCardState extends State<_TeachingCard> {
  bool _expanded = false;
  bool _copied   = false;

  Future<void> _copy() async {
    if (_copied) return;
    final c = widget.card;
    await Clipboard.setData(
      ClipboardData(
        text: [if (c.date != null) c.date!, c.title, c.body].join('\n\n'),
      ),
    );
    if (!mounted) return;
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  // 複製圖示（非 copied 狀態）為靜態物件
  static const _kCopyIcon = Icon(
    Icons.copy_rounded,
    key: ValueKey(false),
    size: 16,
    color: _kCopyIconColor,
  );

  @override
  Widget build(BuildContext context) {
    final c = widget.card;
    // RepaintBoundary 隔離卡片重繪範圍
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: _kCardDecoration,
        child: Padding(
          padding: _kCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 複製按鈕
              GestureDetector(
                onTap: _copy,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _copied ? _kCheckIcon : _kCopyIcon,
                ),
              ),
              const SizedBox(height: 8),
              // 標題：不依賴 state，抽成獨立 const widget 路徑
              Text(c.title, style: _kTitleStyle),
              const SizedBox(height: 12),
              const Divider(color: _kDividerColor, height: 1, thickness: 1),
              const SizedBox(height: 12),
              // 內文
              Expanded(
                child: _expanded
                    ? SingleChildScrollView(child: Text(c.body, style: _kBodyStyle))
                    : Text(c.body, maxLines: 4, overflow: TextOverflow.ellipsis, style: _kBodyStyle),
              ),
              const SizedBox(height: 12),
              // 展開 / 收合
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_expanded ? '收合' : '閱讀全文', style: _kExpandStyle),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: _kArrowIcon,
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