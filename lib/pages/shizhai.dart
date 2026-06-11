import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShiZhaiPage extends StatelessWidget {
  const ShiZhaiPage({super.key});

  static const List<Map<String, String>> _poems = [
    {
      'title': '候車',
      'tag': '諦深 · 2026.6.1',
      'content': '一眾列侯長站台，\n七七八八箱包排；\n繁花美景均無視，\n只盯是否火車來！',
    },
    {
      'title': '庶人',
      'tag': '諦深 · 2026.6.1',
      'content': '腳前碧海腳後山，\n左首鏡湖印藍天；\n是處若非仙人居，\n定立豪傑此地間！',
    },
    {
      'title': '錯搭窩',
      'tag': '諦深 · 2026.6.1',
      'content': '峽谷河灘熱如灸，\n老衲掩蓬坐中休；\n窸窸窣窣禪衣動，\n尋處搭窩小鳥抽！',
    },
  ];

  /// RWD: 依螢幕寬度決定欄數
  ///  < 480   → 1 欄   (手機直)
  ///  480–719 → 2 欄   (手機橫 / 小平板)
  ///  720–999 → 3 欄   (平板直)
  /// 1000–1279→ 4 欄   (平板橫 / 小筆電)
  /// 1280–1535→ 5 欄   (一般桌面)
  /// ≥ 1536   → 6 欄   (寬螢幕)
  int _columnCount(double width) {
    if (width >= 1536) return 6;
    if (width >= 1280) return 5;
    if (width >= 1000) return 4;
    if (width >= 720)  return 3;
    if (width >= 480)  return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    const gold = Color.fromARGB(255, 255, 209, 2);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: CustomScrollView(
        slivers: [
          // ── 詩卡格線 ─────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final cols = _columnCount(constraints.crossAxisExtent);
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _PoemCard(
                      title: _poems[i]['title']!,
                      tag:   _poems[i]['tag']!,
                      content: _poems[i]['content']!,
                    ),
                    childCount: _poems.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.78,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _PoemCard extends StatefulWidget {
  final String title;
  final String tag;
  final String content;

  const _PoemCard({
    required this.title,
    required this.tag,
    required this.content,
  });

  @override
  State<_PoemCard> createState() => _PoemCardState();
}

class _PoemCardState extends State<_PoemCard> {
  bool _copied = false;

  void _copyToClipboard() {
    final text = '${widget.title}\n${widget.tag}\n\n${widget.content}';
    Clipboard.setData(ClipboardData(text: text));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    const gold       = Color.fromARGB(255, 255, 209, 2);
    const goldLight  = Color(0xFFFFFBE6);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 14, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 標題列 + 複製鍵 ─────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: gold,
                      letterSpacing: 3,
                      height: 1.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _copyToClipboard,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _copied ? gold.withOpacity(0.18) : goldLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: gold.withOpacity(0.55),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _copied ? Icons.check : Icons.copy_rounded,
                          size: 12,
                          color: gold,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _copied ? '已複製' : '複製',
                          style: const TextStyle(
                            fontSize: 10,
                            color: gold,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // ── 作者 / 日期標籤 ─────────────────────────────────
            Text(
              widget.tag,
              style: TextStyle(
                fontSize: 10,
                color: gold.withOpacity(0.55),
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 12),

            // ── 分隔線 ──────────────────────────────────────────
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gold.withOpacity(0.45),
                    gold.withOpacity(0.05),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ── 詩句 ────────────────────────────────────────────
            Expanded(
              child: Text(
                widget.content,
                style: const TextStyle(
                  fontSize: 15,
                  color: gold,
                  height: 2.1,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}