import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

const _gold = Color.fromARGB(255, 255, 209, 2);
const _goldLight = Color(0xFFFFFBE6);
const _goldBorder = Color(0x8CFFD102);
const _navShadow = BoxShadow(color: Color(0x0D000000), blurRadius: 6, offset: Offset(0, 2));
const _cardShadows = [
  BoxShadow(color: Color(0x12000000), blurRadius: 20, offset: Offset(0, 4)),
  BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 1)),
];
const _cardDeco = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12)), boxShadow: _cardShadows);
const _border = Border.fromBorderSide(BorderSide(color: _goldBorder, width: 1));
const _navDeco = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8)), boxShadow: [_navShadow], border: _border);
const _navDecoDisabled = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8)), boxShadow: [_navShadow], border: Border.fromBorderSide(BorderSide(color: Color(0x33FFD102), width: 1)));
const _searchDeco = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12)), boxShadow: [_navShadow]);
const _titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A));

class VideoData {
  final String id, title, url;
  const VideoData(this.id, this.title, this.url);
}

const _videos = <VideoData>[
  VideoData('2z26miBEBkA', '諦深佛陀開示 2020年3月7日', 'https://youtu.be/2z26miBEBkA'),
  VideoData('aYdmafP7HMY', '諦深佛陀開示 2020年3月14日', 'https://youtu.be/aYdmafP7HMY'),
  VideoData('3uGgjYDmhUA', '諦深佛陀開示 2020年3月21日', 'https://youtu.be/3uGgjYDmhUA'),
  VideoData('stTdG5iHhjE', '諦深佛陀開示 2020年3月28日', 'https://youtu.be/stTdG5iHhjE'),
  VideoData('5C4nQcL9LQQ', '諦深佛陀開示 2020年4月4日', 'https://youtu.be/5C4nQcL9LQQ'),
  VideoData('H1lleUTetsQ', '諦深佛陀開示 2020年4月11日', 'https://youtu.be/H1lleUTetsQ'),
  VideoData('aBnWRe6MuMo', '諦深佛陀開示 2020年4月18日', 'https://youtu.be/aBnWRe6MuMo'),
  VideoData('LJyHPuiF8UQ', '諦深佛陀開示 2020年4月25日', 'https://youtu.be/LJyHPuiF8UQ'),
  VideoData('yPiOy9NjS_c', '諦深佛陀開示 2020年4月26日', 'https://youtu.be/yPiOy9NjS_c'),
  VideoData('eqKls8wUiPY', '諦深佛陀開示 2020年5月2日', 'https://youtu.be/eqKls8wUiPY'),
  VideoData('XBeCi0JORV0', '諦深佛陀開示 2020年5月9日', 'https://youtu.be/XBeCi0JORV0'),
  VideoData('nj711RpHviw', '諦深佛陀開示 2020年5月16日', 'https://youtu.be/nj711RpHviw'),
  VideoData('QuQSeUm7N9M', '諦深佛陀開示 2020年5月23日', 'https://youtu.be/QuQSeUm7N9M'),
  VideoData('rfsX-E7Il5w', '諦深佛陀開示 2020年5月30日', 'https://youtu.be/rfsX-E7Il5w'),
  VideoData('dJhRgdfS6iU', '諦深佛陀開示 2020年6月6日', 'https://youtu.be/dJhRgdfS6iU'),
  VideoData('262NEBlWEqg', '諦深佛陀開示 2020年6月13日', 'https://youtu.be/262NEBlWEqg'),
  VideoData('j6mM4OQ9MCk', '諦深佛陀開示 2020年6月20日', 'https://youtu.be/j6mM4OQ9MCk'),
  VideoData('H3VNj1IN6cQ', '諦深佛陀開示 2020年6月27日', 'https://youtu.be/H3VNj1IN6cQ'),
  VideoData('rX3999zfw00', '諦深佛陀開示 2020年7月4日', 'https://youtu.be/rX3999zfw00'),
  VideoData('DnQG3YtISs8', '諦深佛陀開示 2020年7月11日', 'https://youtu.be/DnQG3YtISs8'),
  VideoData('g28d1S926Rc', '諦深佛陀開示 2020年7月18日', 'https://youtu.be/g28d1S926Rc'),
  VideoData('txzLgfTEPXk', '諦深佛陀開示 2020年7月25日', 'https://youtu.be/txzLgfTEPXk'),
  VideoData('Xa8oQYBxK9Q', '諦深佛陀開示 2020年8月1日', 'https://youtu.be/Xa8oQYBxK9Q'),
  VideoData('AOAS242oUlE', '諦深佛陀開示 2020年8月8日', 'https://youtu.be/AOAS242oUlE'),
  VideoData('oDjIuDkA9tg', '諦深佛陀開示 2020年8月15日', 'https://youtu.be/oDjIuDkA9tg'),
  VideoData('pIRPa9gNFqA', '諦深佛陀開示 2020年8月22日', 'https://youtu.be/pIRPa9gNFqA'),
  VideoData('jIv-IhC-RHM', '諦深佛陀開示 2020年8月29日', 'https://youtu.be/jIv-IhC-RHM'),
  VideoData('gIpKP3KP48c', '諦深佛陀開示 2020年9月5日', 'https://youtu.be/gIpKP3KP48c'),
  VideoData('G3Ncx7iwImU', '諦深佛陀開示 2020年9月12日', 'https://youtu.be/G3Ncx7iwImU'),
  VideoData('vnzcDNC4XFg', '諦深佛陀開示 2020年9月19日', 'https://youtu.be/vnzcDNC4XFg'),
  VideoData('NugoxAuPvzA', '諦深佛陀開示 2020年9月26日', 'https://youtu.be/NugoxAuPvzA'),
  VideoData('RRopQZdX45k', '諦深佛陀開示 2020年10月3日', 'https://youtu.be/RRopQZdX45k'),
  VideoData('Kk_GO7LC8q0', '諦深佛陀開示 2020年10月10日', 'https://youtu.be/Kk_GO7LC8q0'),
  VideoData('M5wu_DWiPS8', '諦深佛陀開示 2020年10月17日', 'https://youtu.be/M5wu_DWiPS8'),
  VideoData('IqhBwhYHC_k', '諦深佛陀開示 2020年10月24日', 'https://youtu.be/IqhBwhYHC_k'),
  VideoData('Vhm19TQjp68', '諦深佛陀開示 2020年10月31日', 'https://youtu.be/Vhm19TQjp68'),
  VideoData('Y_dzD41G7ow', '諦深佛陀開示 2020年11月7日', 'https://youtu.be/Y_dzD41G7ow'),
  VideoData('7Vd8-bBqEoM', '諦深佛陀開示 2020年11月14日', 'https://youtu.be/7Vd8-bBqEoM'),
  VideoData('3PKymWBy4xg', '諦深佛陀開示 2020年11月21日', 'https://youtu.be/3PKymWBy4xg'),
  VideoData('nday-JJ-Cww', '諦深佛陀開示 2020年11月28日', 'https://youtu.be/nday-JJ-Cww'),
  VideoData('w3_FQTXuqFg', '諦深佛陀開示 2020年12月5日', 'https://youtu.be/w3_FQTXuqFg'),
  VideoData('eWIi69l28dE', '諦深佛陀開示 2020年12月12日', 'https://youtu.be/eWIi69l28dE'),
  VideoData('W684lpOKESQ', '諦深佛陀開示 2020年12月19日', 'https://youtu.be/W684lpOKESQ'),
  VideoData('XQVCQvpi3RM', '諦深佛陀開示 2020年12月26日', 'https://youtu.be/XQVCQvpi3RM'),
  VideoData('AwoN9zqdpHE', '諦深佛陀開示 2020年12月31日', 'https://youtu.be/AwoN9zqdpHE'),
  VideoData('ffC1-37WU5U', '諦深佛陀開示 2021年1月2日', 'https://youtu.be/ffC1-37WU5U'),
  VideoData('e-T5aXiY4Fc', '諦深佛陀開示 2021年1月9日', 'https://youtu.be/e-T5aXiY4Fc'),
  VideoData('MzoUsZvr4Us', '諦深佛陀開示 2021年1月16日', 'https://youtu.be/MzoUsZvr4Us'),
];

class VideoTeachingsPage extends StatefulWidget {
  const VideoTeachingsPage({super.key});
  @override
  State<VideoTeachingsPage> createState() => _VideoTeachingsPageState();
}

class _VideoTeachingsPageState extends State<VideoTeachingsPage> {
  static const _perPage = 24;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _page = 0;
  String _query = '';

  static int _cols(double w) =>
      w >= 1700 ? 6 : w >= 1280 ? 5 : w >= 1000 ? 4 : w >= 720 ? 3 : w >= 480 ? 2 : 1;

  List<VideoData> get _filtered {
    if (_query.isEmpty) return _videos;
    final q = _query.toLowerCase();
    return _videos.where((v) => v.title.toLowerCase().contains(q)).toList(growable: false);
  }

  int _totalPages(int len) => (len / _perPage).ceil().clamp(1, double.infinity).toInt();

  void _goTo(int p, int total) {
    if (p != _page && p >= 0 && p < total) setState(() => _page = p);
  }

  void _onSearchChanged(String v) => setState(() { _query = v; _page = 0; });

  void _jumpTo(VideoData v, List<VideoData> f) {
    final idx = f.indexOf(v);
    if (idx == -1) return;
    setState(() => _page = idx ~/ _perPage);
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final total = _totalPages(filtered.length);
    final start = (_page * _perPage).clamp(0, filtered.length);
    final list = filtered.sublist(start, (start + _perPage).clamp(0, filtered.length));

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        iconTheme: const IconThemeData(color: _gold),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: _searchDeco,
            child: Row(children: [
              const Icon(Icons.search, size: 18, color: _gold),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: _onSearchChanged,
                  style: const TextStyle(fontSize: 14, color: _gold),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: '搜尋影片標題…',
                    hintStyle: TextStyle(fontSize: 13, color: _goldBorder),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      drawer: _IndexDrawer(videos: filtered, onSelect: (v) => _jumpTo(v, filtered)),
      body: filtered.isEmpty
          ? Center(child: Text('找不到符合「$_query」的影片', style: const TextStyle(fontSize: 14, color: _goldBorder)))
          : CustomScrollView(
              cacheExtent: 1200,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverLayoutBuilder(builder: (ctx, c) {
                    final cols = _cols(c.crossAxisExtent).clamp(1, 6);
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) => _VideoCard(video: list[i]),
                        childCount: list.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: true,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 16 / 13,
                      ),
                    );
                  }),
                ),
                if (total > 1)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _PaginationBar(page: _page, total: total, onTap: (p) => _goTo(p, total)),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _IndexDrawer extends StatelessWidget {
  final List<VideoData> videos;
  final ValueChanged<VideoData> onSelect;
  const _IndexDrawer({required this.videos, required this.onSelect});

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: Colors.white,
    child: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(children: [
            const Icon(Icons.menu_book_rounded, size: 18, color: _gold),
            const SizedBox(width: 8),
            Text('目錄（${videos.length}）', style: const TextStyle(fontSize: 14, color: _gold)),
          ]),
        ),
        const SizedBox(height: 1, child: ColoredBox(color: _goldBorder)),
        Expanded(
          child: videos.isEmpty
              ? const Center(child: Text('無符合項目', style: TextStyle(fontSize: 13, color: _goldBorder)))
              : ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (ctx, i) => ListTile(
                    dense: true,
                    title: Text(videos[i].title, style: const TextStyle(fontSize: 14, color: _gold)),
                    onTap: () => onSelect(videos[i]),
                  ),
                ),
        ),
      ]),
    ),
  );
}

class _PaginationBar extends StatelessWidget {
  final int page, total;
  final ValueChanged<int> onTap;
  const _PaginationBar({required this.page, required this.total, required this.onTap});

  @override
  Widget build(BuildContext context) => Center(
    child: Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
      _NavButton(icon: Icons.chevron_left, enabled: page > 0, onTap: () => onTap(page - 1)),
      for (int i = 0; i < total; i++) _PageBtn(i: i, selected: i == page, onTap: () => onTap(i)),
      _NavButton(icon: Icons.chevron_right, enabled: page < total - 1, onTap: () => onTap(page + 1)),
    ]),
  );
}

class _PageBtn extends StatelessWidget {
  final int i;
  final bool selected;
  final VoidCallback onTap;
  const _PageBtn({required this.i, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 36, height: 36, alignment: Alignment.center,
      decoration: BoxDecoration(color: selected ? _gold : Colors.white, borderRadius: const BorderRadius.all(Radius.circular(8)), border: _border, boxShadow: const [_navShadow]),
      child: Text('${i + 1}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: selected ? Colors.white : _gold)),
    ),
  );
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: enabled ? onTap : null,
    child: Container(
      width: 36, height: 36, alignment: Alignment.center,
      decoration: enabled ? _navDeco : _navDecoDisabled,
      child: Icon(icon, size: 18, color: enabled ? _gold : const Color(0x33FFD102)),
    ),
  );
}

class _VideoCard extends StatelessWidget {
  final VideoData video;
  const _VideoCard({required this.video});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () async {
      final uri = Uri.parse(video.url);
      if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
    },
    child: Container(
      decoration: _cardDeco,
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            'https://img.youtube.com/vi/${video.id}/hqdefault.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF0F0F0), child: const Icon(Icons.broken_image, size: 40, color: Colors.grey)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(video.title, style: _titleStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ]),
    ),
  );
}