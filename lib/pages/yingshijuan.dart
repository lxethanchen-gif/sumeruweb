import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'yingshijuan_data.dart';

// ── 顏色常數 ──────────────────────────────────────────────────────
const Color _kGold = Color(0xFFF5C518);
const Color _kGoldDim = Color(0xFFB8960E);
const Color _kWhite = Colors.white;

// ── Page ──────────────────────────────────────────────────────────
class YingShiJuanPage extends StatelessWidget {
  const YingShiJuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kWhite,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 頁頭 ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Row(
                children: [
                  const SizedBox(width: 6),
                ],
              ),
            ),

            // ── 卡片 Grid（RWD） ───────────────────────────────────
            _CardGrid(cards: kYingShiJuanCards),
          ],
        ),
      ),
    );
  }
}

// ── _CardGrid（RWD） ──────────────────────────────────────────────
class _CardGrid extends StatelessWidget {
  final List<({String title, String? date, String body})> cards;
  const _CardGrid({required this.cards});

  int _columns(double width) {
    if (width < 480) return 1;
    if (width < 720) return 2;
    if (width < 960) return 3;
    if (width < 1200) return 4;
    if (width < 1440) return 5;
    return 6;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final cols = _columns(constraints.maxWidth);
        const spacing = 16.0;
        final cardW = (constraints.maxWidth - spacing * (cols - 1)) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards
              .map(
                (c) => SizedBox(
                  width: cardW,
                  child: _TeachingCard(
                    title: c.title,
                    date: c.date,
                    body: c.body,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ── _TeachingCard ─────────────────────────────────────────────────
class _TeachingCard extends StatefulWidget {
  final String title;
  final String? date;
  final String body;
  const _TeachingCard({required this.title, this.date, required this.body});
  @override
  State<_TeachingCard> createState() => _TeachingCardState();
}

class _TeachingCardState extends State<_TeachingCard> {
  bool _expanded = false;
  bool _hovered = false;
  bool _copied = false;

  // 複製卡片所有文字（日期 + 標題 + 內文）
  Future<void> _copy() async {
    final parts = [
      if (widget.date != null) widget.date!,
      widget.title,
      widget.body,
    ];
    await Clipboard.setData(ClipboardData(text: parts.join('\n\n')));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(16);
    const borderRadius = BorderRadius.all(radius);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? _kGold.withOpacity(0.28)
                  : Colors.black.withOpacity(0.08),
              blurRadius: _hovered ? 20 : 10,
              spreadRadius: _hovered ? 2 : 0,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: _hovered ? _kGold.withOpacity(0.5) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            // ── 卡片內容 ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── 日期 + 複製按鈕（同一行） ──────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 複製按鈕
                      GestureDetector(
                        onTap: _copy,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _copied
                              ? const Icon(
                                  Icons.check_rounded,
                                  key: ValueKey('check'),
                                  size: 16,
                                  color: _kGold,
                                )
                              : Icon(
                                  Icons.copy_rounded,
                                  key: const ValueKey('copy'),
                                  size: 16,
                                  color: _kGoldDim.withOpacity(0.6),
                                ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ── 標題 ──────────────────────────────────────────
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _kGold,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── 分隔線 ────────────────────────────────────────
                  Container(
                    height: 1,
                    color: _kGold.withOpacity(0.2),
                    margin: const EdgeInsets.only(bottom: 12),
                  ),

                  // ── 內文（可展開） ───────────────────────────────
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 220),
                    crossFadeState: _expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: Text(
                      widget.body,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: _kGoldDim,
                        height: 1.7,
                      ),
                    ),
                    secondChild: Text(
                      widget.body,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: _kGoldDim,
                        height: 1.7,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── 展開 / 收合按鈕 ─────────────────────────────
                  GestureDetector(
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _expanded ? '收合' : '閱讀全文',
                          style: const TextStyle(
                            fontSize: 12,
                            color: _kGold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: _kGold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ], // Stack children
        ),
      ),
    );
  }
}
