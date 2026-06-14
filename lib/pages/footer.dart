import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// ── 常數（與 AppBar 共用）────────────────────────────────────────────
const _kWhite   = Colors.white;
const _kWhite70 = Color(0xB3FFFFFF);
const _kWhite20 = Color(0x33FFFFFF);
const _kBlack38 = Color(0x61000000);
const _dur130   = Duration(milliseconds: 130);
const kPrimaryGold = Color(0xFFF5C518);

// ── RWD 斷點（與 AppBar 一致）────────────────────────────────────────
bool _isMobile(BuildContext ctx) => MediaQuery.sizeOf(ctx).width < 600;
bool _isTablet(BuildContext ctx) => MediaQuery.sizeOf(ctx).width < 1024;

// ── SumeruFooter ───────────────────────────────────────────────────
class SumeruFooter extends StatelessWidget {
  const SumeruFooter({super.key});

  /// 根據螢幕寬度計算水平內距
  /// mobile  < 600  → 16px（與外層頁面 padding 相同，內容不壓縮）
  /// tablet  < 1024 → 32px
  /// desktop ≥ 1024 → 最多讓內容區留到 960px，多餘空間自動置中
  EdgeInsets _hPad(BuildContext ctx) {
    if (_isMobile(ctx)) return const EdgeInsets.symmetric(horizontal: 16);
    if (_isTablet(ctx)) return const EdgeInsets.symmetric(horizontal: 32);
    // desktop：用 LayoutBuilder / FractionallySizedBox 讓內容置中
    final w = MediaQuery.sizeOf(ctx).width;
    final side = ((w - 960) / 2).clamp(48.0, double.infinity);
    return EdgeInsets.symmetric(horizontal: side);
  }

  @override
  Widget build(BuildContext context) {
    final mobile = _isMobile(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),   // 與畫面底部的距離
      child: Material(
        elevation: 6,
        shadowColor: _kBlack38,
        color: kPrimaryGold,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: _hPad(context).copyWith(top: 18, bottom: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── 頂部分隔線 ────────────────────────────────────────
              const SizedBox(height: 1, child: ColoredBox(color: _kWhite20)),
              const SizedBox(height: 18),

              // ── 主要內容（社群按鈕 + 微信群組）──────────────────────
              mobile
                  // 手機：垂直排列，居中
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _SocialRow(),
                        SizedBox(height: 16),
                        _WechatGroup(),
                      ],
                    )
                  // 平板 / 桌機：橫向 Wrap
                  : const Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 32,
                      runSpacing: 16,
                      children: [_SocialRow(), _WechatGroup()],
                    ),

              const SizedBox(height: 18),
              const SizedBox(height: 1, child: ColoredBox(color: _kWhite20)),
              const SizedBox(height: 12),

              // ── 底部說明文字 ──────────────────────────────────────
              Text(
                '求皈依者 須持佛陀二十二戒 · 下載皈依表 · 加入如少水魚微信 · 遞交皈依表',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mobile ? 11 : 12,
                  color: _kWhite70,
                  letterSpacing: 0.6,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 14),
              const SizedBox(height: 1, child: ColoredBox(color: _kWhite20)),
              const SizedBox(height: 12),

              // ── 發心貢獻者標籤（最底部）──────────────────────────────
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 6,
                children: const [
                  _CreditTag(region: '台灣', name: '智定成', role: '網站開發'),
                  _CreditTag(region: '香港', name: '智道心', role: '資料收集'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── _CreditTag ─────────────────────────────────────────────────────
class _CreditTag extends StatelessWidget {
  final String region;
  final String name;
  final String role;
  const _CreditTag({required this.region, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _kWhite20,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 地區小徽章
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              region,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: kPrimaryGold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kWhite,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            role,
            style: const TextStyle(
              fontSize: 11,
              color: _kWhite70,
            ),
          ),
        ],
      ),
    );
  }
}

// ── _SocialRow ─────────────────────────────────────────────────────
class _SocialRow extends StatelessWidget {
  const _SocialRow();

  static const _kItems = [
    (icon: _SIcon.facebook, label: 'Facebook',
      url: 'https://www.facebook.com/share/g/1DYkv4t3Bt/'),
    (icon: _SIcon.line,     label: 'Line',
      url: 'https://line.me/R/ti/g/rSS6ZaP3_x'),
    (icon: _SIcon.youtube,  label: 'YouTube',
      url: 'https://www.youtube.com/@Dishenbuddha'),
    (icon: _SIcon.excel,    label: '皈依表',
      url: 'https://docs.google.com/spreadsheets/d/13Lt8RXVa6ZiDMBe_v6sw5xf_Nh4kxMTx/edit?usp=sharing&ouid=103703253477765519034&rtpof=true&sd=true'),
  ];

  @override
  Widget build(BuildContext context) {
    // 手機：2×2 grid；平板以上：單行
    if (_isMobile(context)) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final item in _kItems)
            _SocialBtn(icon: item.icon, label: item.label, url: item.url),
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in _kItems)
          _SocialBtn(icon: item.icon, label: item.label, url: item.url),
      ],
    );
  }
}

// ── _SocialBtn ─────────────────────────────────────────────────────
class _SocialBtn extends StatefulWidget {
  final _SIcon icon;
  final String label;
  final String url;
  const _SocialBtn({required this.icon, required this.label, required this.url});

  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
  bool _hov = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: _dur130,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _hov ? _kWhite : _kWhite20,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SIconWidget(icon: widget.icon, hov: _hov),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _hov ? kPrimaryGold : _kWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── _WechatGroup ──────────────────────────────────────────────────
class _WechatGroup extends StatelessWidget {
  const _WechatGroup();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _dur130,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kWhite20,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF07C160),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.chat_bubble_rounded, color: _kWhite, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              _WechatId(name: '如少水魚', id: '13589807963'),
              SizedBox(height: 4),
              _WechatId(name: '如救頭燃', id: '15966583597'),
            ],
          ),
        ],
      ),
    );
  }
}

// ── _WechatId ─────────────────────────────────────────────────────
class _WechatId extends StatefulWidget {
  final String name;
  final String id;
  const _WechatId({required this.name, required this.id});

  @override
  State<_WechatId> createState() => _WechatIdState();
}

class _WechatIdState extends State<_WechatId> {
  bool _hov    = false;
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.id));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: _copy,
        child: AnimatedContainer(
          duration: _dur130,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _hov ? _kWhite : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.name}：',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _hov ? kPrimaryGold : _kWhite,
                ),
              ),
              Text(
                _copied ? '已複製！' : widget.id,
                style: TextStyle(
                  fontSize: 12,
                  color: _copied
                      ? const Color(0xFF2ECC40)
                      : (_hov ? kPrimaryGold : _kWhite70),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                _copied ? Icons.check_rounded : Icons.copy_rounded,
                size: 12,
                color: _copied
                    ? const Color(0xFF2ECC40)
                    : (_hov ? kPrimaryGold : _kWhite70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── _SIcon enum & widget ──────────────────────────────────────────
enum _SIcon { facebook, line, youtube, excel }

class _SIconWidget extends StatelessWidget {
  final _SIcon icon;
  final bool hov;
  const _SIconWidget({required this.icon, required this.hov});

  @override
  Widget build(BuildContext context) {
    final color = hov ? kPrimaryGold : _kWhite;
    switch (icon) {
      case _SIcon.facebook:
        return Icon(Icons.facebook_rounded, color: color, size: 20);
      case _SIcon.line:
        return _LineSvg(color: color);
      case _SIcon.youtube:
        return Icon(Icons.play_circle_fill_rounded, color: color, size: 20);
      case _SIcon.excel:
        return _ExcelSvg(color: color);
    }
  }
}

// ── Line SVG ───────────────────────────────────────────────────────
class _LineSvg extends StatelessWidget {
  final Color color;
  const _LineSvg({required this.color});
  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: const Size(20, 20), painter: _LinePainter(color));
}

class _LinePainter extends CustomPainter {
  final Color color;
  const _LinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final s = size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, s, s * 0.85),
        Radius.circular(s * 0.22),
      ),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(s * 0.28, s * 0.85)
        ..lineTo(s * 0.18, s)
        ..lineTo(s * 0.48, s * 0.85)
        ..close(),
      paint,
    );
    final dot = Paint()
      ..color = color == Colors.white ? kPrimaryGold : Colors.white
      ..style = PaintingStyle.fill;
    for (final cx in [s * 0.28, s * 0.50, s * 0.72]) {
      canvas.drawCircle(Offset(cx, s * 0.40), s * 0.07, dot);
    }
  }

  @override
  bool shouldRepaint(_LinePainter old) => old.color != color;
}

// ── Excel SVG ──────────────────────────────────────────────────────
class _ExcelSvg extends StatelessWidget {
  final Color color;
  const _ExcelSvg({required this.color});
  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: const Size(20, 20), painter: _ExcelPainter(color));
}

class _ExcelPainter extends CustomPainter {
  final Color color;
  const _ExcelPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.09
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(s * 0.08, s * 0.08, s * 0.84, s * 0.84),
        Radius.circular(s * 0.1),
      ),
      stroke,
    );
    canvas.drawLine(Offset(s * 0.50, s * 0.08), Offset(s * 0.50, s * 0.92), stroke);
    canvas.drawLine(Offset(s * 0.08, s * 0.50), Offset(s * 0.92, s * 0.50), stroke);
    canvas.drawLine(Offset(s * 0.17, s * 0.17), Offset(s * 0.40, s * 0.40), stroke);
    canvas.drawLine(Offset(s * 0.40, s * 0.17), Offset(s * 0.17, s * 0.40), stroke);
  }

  @override
  bool shouldRepaint(_ExcelPainter old) => old.color != color;
}