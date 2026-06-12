import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class LinkItem {
  final String title;
  final String url;
  LinkItem(this.title, this.url);
}

class _HomePageState extends State<HomePage> {
  final Color _gold = const Color.fromARGB(255, 246, 214, 30);
  final List<String> _tabs = ['最新消息', '影音開示', '應世卷', '滅罪卷', '機緣道旨', '詩摘'];

  final Map<String, List<LinkItem>> _tabContent = {
    '最新消息': [
      LinkItem('2026年5月最新開示公告', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
    ],
    '影音開示': [
      LinkItem(
        '諦深佛陀開示 2020年3月7日',
        'https://youtu.be/2z26miBEBkA?si=tniG3_oNlKwL_MPx',
      ),
      LinkItem(
        '諦深佛陀開示 2020年3月14日',
        'https://youtu.be/aYdmafP7HMY?si=Ou0Z3bsVhrlu8pFD',
      ),
      LinkItem(
        '諦深佛陀開示 2020年3月21日',
        'https://youtu.be/3uGgjYDmhUA?si=J_bXQ_DS8w4jbC9l',
      ),
      LinkItem(
        '諦深佛陀開示 2020年3月28日',
        'https://youtu.be/stTdG5iHhjE?si=olHQkfhcfC1d6Wgd',
      ),
      LinkItem(
        '諦深佛陀開示 2020年4月4日',
        'https://youtu.be/5C4nQcL9LQQ?si=QzbWOZcH8C2ZkReY',
      ),
      LinkItem(
        '諦深佛陀開示 2020年4月11日',
        'https://youtu.be/H1lleUTetsQ?si=3ofA7G9aVZH1-tPj',
      ),
      LinkItem(
        '諦深佛陀開示 2020年4月18日',
        'https://youtu.be/aBnWRe6MuMo?si=0k6RqVgN8UF_407D',
      ),
      LinkItem(
        '諦深佛陀開示 2020年4月25日',
        'https://youtu.be/LJyHPuiF8UQ?si=UNwDbBStli1ev5K7',
      ),
      LinkItem(
        '諦深佛陀開示 2020年4月26日',
        'https://youtu.be/yPiOy9NjS_c?si=LnAmsoPtwAnto6Ve',
      ),
      LinkItem(
        '諦深佛陀開示 2020年5月02日',
        'https://youtu.be/eqKls8wUiPY?si=Yr5joIzNjZxcsOx5',
      ),
      LinkItem(
        '諦深佛陀開示 2020年5月09日',
        'https://youtu.be/XBeCi0JORV0?si=bMujSxqa2nKy-BhT',
      ),
      LinkItem(
        '諦深佛陀開示 2020年5月16日',
        'https://youtu.be/nj711RpHviw?si=2tfiRBd5fFH7_ks0',
      ),
      LinkItem(
        '諦深佛陀開示 2020年5月23日',
        'https://youtu.be/QuQSeUm7N9M?si=WLeacqjxxpkF7Lmo',
      ),
      LinkItem(
        '諦深佛陀開示 2020年5月30日',
        'https://youtu.be/rfsX-E7Il5w?si=Wa0TCSDRLcco48Nb',
      ),
      LinkItem(
        '諦深佛陀開示 2020年6月06日',
        'https://youtu.be/dJhRgdfS6iU?si=3vR8fjtz846gy8Vr',
      ),
      LinkItem(
        '諦深佛陀開示 2020年6月13日',
        'https://youtu.be/262NEBlWEqg?si=Vzrq9pu9aAfIIpxU',
      ),
      LinkItem(
        '諦深佛陀開示 2020年6月20日',
        'https://youtu.be/j6mM4OQ9MCk?si=rczKeWH4LA8UKcSk',
      ),
      LinkItem(
        '諦深佛陀開示 2020年6月27日',
        'https://youtu.be/H3VNj1IN6cQ?si=g7v1SLnzJKwdGusq',
      ),
      LinkItem(
        '諦深佛陀開示 2020年7月04日',
        'https://youtu.be/rX3999zfw00?si=mKURm2ssDq93iUIn',
      ),
      LinkItem(
        '諦深佛陀開示 2020年7月11日',
        'https://youtu.be/DnQG3YtISs8?si=f66CxbGnykuKy7hJ',
      ),
      LinkItem(
        '諦深佛陀開示 2020年7月18日',
        'https://youtu.be/g28d1S926Rc?si=QbNwBGLQrTZODchA',
      ),
      LinkItem(
        '諦深佛陀開示 2020年7月25日',
        'https://youtu.be/txzLgfTEPXk?si=JgBjfPnBPopSofhP',
      ),
      LinkItem(
        '諦深佛陀開示 2020年8月01日',
        'https://youtu.be/Xa8oQYBxK9Q?si=nJTo5GKDSD90bWTH',
      ),
      LinkItem(
        '諦深佛陀開示 2020年8月08日',
        'https://youtu.be/AOAS242oUlE?si=20ku3h_jXlXTE4H6',
      ),
      LinkItem(
        '諦深佛陀開示 2020年8月15日',
        'https://youtu.be/oDjIuDkA9tg?si=kG3UNV8VjZnfgsl_',
      ),
      LinkItem(
        '諦深佛陀開示 2020年8月22日',
        'https://youtu.be/pIRPa9gNFqA?si=bcHeypbYOJ2PaWa7',
      ),
      LinkItem(
        '諦深佛陀開示 2020年8月29日',
        'https://youtu.be/jIv-IhC-RHM?si=ZbWpAZvSxPnrUKLm',
      ),
      LinkItem(
        '諦深佛陀開示 2020年9月05日',
        'https://youtu.be/gIpKP3KP48c?si=RmL_balfS8USyu1i',
      ),
      LinkItem(
        '諦深佛陀開示 2020年9月12日',
        'https://youtu.be/G3Ncx7iwImU?si=B4pYxar-N_deMgWy',
      ),
      LinkItem(
        '諦深佛陀開示 2020年9月19日',
        'https://youtu.be/vnzcDNC4XFg?si=08DpT3V9vMmXf3Iw',
      ),
      LinkItem(
        '諦深佛陀開示 2020年9月26日',
        'https://youtu.be/NugoxAuPvzA?si=eAY38yskKv0jx-iJ',
      ),
      LinkItem(
        '諦深佛陀開示 2020年10月03日',
        'https://youtu.be/RRopQZdX45k?si=xU8Tc-YLzBoOzP5m',
      ),
      LinkItem(
        '諦深佛陀開示 2020年10月10日',
        'https://youtu.be/Kk_GO7LC8q0?si=Jugp5Hmdg5SB-6sZ',
      ),
      LinkItem(
        '諦深佛陀開示 2020年10月17日',
        'https://youtu.be/M5wu_DWiPS8?si=s8ZM4XnvYKd68UE3',
      ),
      LinkItem(
        '諦深佛陀開示 2020年10月24日',
        'https://youtu.be/IqhBwhYHC_k?si=m2HiibYeJ3KtaHul',
      ),
      LinkItem(
        '諦深佛陀開示 2020年10月31日',
        'https://youtu.be/Vhm19TQjp68?si=Zi5a5MeDnKwr1NF1',
      ),
      LinkItem(
        '諦深佛陀開示 2020年11月07日',
        'https://youtu.be/Y_dzD41G7ow?si=XttsjPtkQFs_D1Wj',
      ),
      LinkItem(
        '諦深佛陀開示 2020年11月14日',
        'https://youtu.be/7Vd8-bBqEoM?si=TO-SPv3AW_jbq4Tx',
      ),
      LinkItem(
        '諦深佛陀開示 2020年11月21日',
        'https://youtu.be/3PKymWBy4xg?si=TTITQOTP16zR34rt',
      ),
      LinkItem(
        '諦深佛陀開示 2020年11月28日',
        'https://youtu.be/nday-JJ-Cww?si=LtPW04zFxUiSpLDR',
      ),
      LinkItem(
        '諦深佛陀開示 2020年12月05日',
        'https://youtu.be/w3_FQTXuqFg?si=uUkKXRLBHHeRFFtL',
      ),
      LinkItem(
        '諦深佛陀開示 2020年12月12日',
        'https://youtu.be/eWIi69l28dE?si=2IC6ABQkgGJ0n3hH',
      ),
      LinkItem(
        '諦深佛陀開示 2020年12月19日',
        'https://youtu.be/W684lpOKESQ?si=A6QjrSMMkxoR0u_v',
      ),
      LinkItem(
        '諦深佛陀開示 2020年12月26日',
        'https://youtu.be/XQVCQvpi3RM?si=j8CrWoCyEGkKKYXJ',
      ),
      LinkItem(
        '諦深佛陀開示 2020年12月31日',
        'https://youtu.be/AwoN9zqdpHE?si=tasDmj_lkqsa2gSa',
      ),
      LinkItem(
        '諦深佛陀開示 2021年01月02日',
        'https://youtu.be/ffC1-37WU5U?si=eUiCcSNA3GmnWMom',
      ),
      LinkItem(
        '諦深佛陀開示 2021年01月09日',
        'https://youtu.be/e-T5aXiY4Fc?si=DpxXJAMISQSchivB',
      ),
      LinkItem(
        '諦深佛陀開示 2021年01月16日',
        'https://youtu.be/MzoUsZvr4Us?si=7bFNUPXa5Qi-2y3P',
      ),
    ],
    '應世卷': [
      LinkItem('應世卷第一章', 'https://example.com'),
      LinkItem('應世卷第一章', 'https://example.com'),
    ],
    '滅罪卷': [
      LinkItem('滅罪卷導讀', 'https://example.com'),
      LinkItem('滅罪卷導讀', 'https://example.com'),
    ],
    '機緣道旨': [
      LinkItem('機緣道旨要義', 'https://example.com'),
      LinkItem('機緣道旨要義', 'https://example.com'),
    ],
    '詩摘': [
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
      LinkItem('諦深佛陀詩集選讀', 'https://example.com'),
    ],
  };

  static bool _iframeRegistered = false;

  @override
  void initState() {
    super.initState();
    if (!_iframeRegistered) {
      _iframeRegistered = true;
      ui.platformViewRegistry.registerViewFactory(
        'youtube-player',
        (int viewId) => html.IFrameElement()
          ..src = 'https://www.youtube.com/embed/gj4mSg0ElRA?autoplay=0'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allowFullscreen = true,
      );
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double contentWidth = w > 1100 ? 1000 : w * 0.95;

    return DefaultTabController(
      length: _tabs.length,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── 標題 ──────────────────────────────────────────
              Text(
                '諦深佛陀 2026年5月29日 現場直播開示',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: w > 600 ? 32 : 24,
                  fontWeight: FontWeight.bold,
                  color: _gold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 24),

              // ── YouTube 嵌入影片 ──────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: SizedBox(
                  width: contentWidth,
                  height: contentWidth * 9 / 16,
                  child: const HtmlElementView(viewType: 'youtube-player'),
                ),
              ),
              const SizedBox(height: 50),

              // ── Tab 區塊 ──────────────────────────────────────
              SizedBox(
                width: contentWidth,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: w < 600,
                      tabAlignment: w < 600
                          ? TabAlignment.start
                          : TabAlignment.center,
                      dividerColor: Colors.transparent,
                      labelColor: Colors.white,
                      unselectedLabelColor: _gold,
                      indicator: BoxDecoration(
                        color: _gold,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      tabs: _tabs
                          .map(
                            (title) => Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: _gold.withOpacity(0.05),
                                  border: Border.all(color: _gold, width: 1.5),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(title),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        children: _tabs.map((tabTitle) {
                          final items = _tabContent[tabTitle] ?? [];
                          return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return InkWell(
                                onTap: () => _launchURL(item.url),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                      color: _gold,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
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
