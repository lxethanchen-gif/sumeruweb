import 'package:flutter/material.dart';

// 自定義 ScrollBehavior 以徹底移除捲動軸
class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class JiYuanDaoZhiPage extends StatelessWidget {
  const JiYuanDaoZhiPage({super.key});

  static const _gold = Color(0xFFF5C518);
  static const _goldMuted = Color(0xFFC8A43A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoScrollbarBehavior(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            int crossAxisCount = screenWidth > 1000 ? 3 : (screenWidth > 600 ? 2 : 1);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              // 加入 Center 使內部 Column 置中
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // 確保內容水平置中
                  children: [
                    _buildPageHeader(),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center, // 確保卡片列表置中
                      children: [
                        _buildCard(screenWidth, crossAxisCount,
                          title: '諦深大師傳戒法音摘弘',
                          tag: '機緣道旨妙法入門卷  開示子集：持戒   \n2014/03/15',
                          content: '所謂我慢，乃盧舍那佛設戒啟分，與貪、嗔、癡、殺、盜、妄共為攀緣罪根七分，淫戒為攀緣用分。而我慢又是貪嗔癡殺盜妄之相體，故依慢做傳戒中一註。\n\n我慢不除，險道自成。因，若有人附，則慢成癡與情體，幻成淫根；若有人逆，則慢成：弱則殺、強則嗔、盜、妄緣。狂妄是我慢的行為表徵，是故人之入戒修道，慢為第一戒障。',
                        ),
                        _buildCard(screenWidth, crossAxisCount,
                          title: '諦深大師開示：得戒',
                          tag: '機緣道旨妙法入門卷  開示子集：持戒   \n2013/02/17',
                          content: '''1、不殺生。所謂不殺戒相，不斷一切眾生性命。釋：殺為眾生諸罪頭等，若不斷殺，諸戒難立。生命為眾生種種因緣應相，若斷之命，現前因緣被斷，即處轉惡殺因緣。
\n2、不盜。不盜戒相，為應戒第二。不取非予之物，稱不盜戒。不盜雖為不殺支分，但另含新分自成一體。
\n3、不淫。不淫戒相，男女交媾，為應戒第三。釋：淫為因緣合和六道之本，淫心為輪轉之處，欲出六道，淫為第一道障。
\n4、不妄。實而不虛諸相。虛妄為世界之初始，造種種業之始。眾生之妄為妄中之妄，若不破除，難於修道。
\n5、不貪。貪為攀緣之相，是眾生之本。貪有兩分，一者侵分，二者狂根分。
\n6、不嗔。為殺之導引，當斷習氣。因習氣故，對不入汝之習氣者生嗔恨心，因嗔恨故誕生惡念。
\n7、不癡。癡為以不明、糊塗、執著、迷信等為行為之相。乃諸惡依附之本。
\n8、不慢戒。為攀緣體相戒，乃諸多戒之同分戒。修行之道不去慢心，無有成處。''',
                        ),
                        _buildCard(screenWidth, crossAxisCount,
                          title: '諦深大師開示：攝緣',
                          tag: '機緣道旨妙法入門卷  開示子集：攝緣   \n2013/01/25',
                          content: '各位弟子，入於佛之法座下，是稱入十方佛攝緣法。十方世界妄心攀緣成因、因因造業，業成緣分、緣緣相扣、成就緣起，緣起成像，造諸種類。種類起緣，各業互牽，又造共業，諸多種類，為攀緣故，遞弱為食，互相凌滅，滅後互轉，成就六道。',
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(double screenWidth, int count, {required String title, required String tag, required String content}) {
    double cardWidth = (screenWidth < 600) ? screenWidth - 32 : (screenWidth / count) - (24 * count);
    
    return Container(
      width: cardWidth.clamp(300, 450),
      height: 550,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: _gold.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _gold)),
          const SizedBox(height: 12),
          _Tag(tag),
          const SizedBox(height: 16),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoScrollbarBehavior(),
              child: SingleChildScrollView(
                child: Text(content, style: const TextStyle(fontSize: 14, color: _goldMuted, height: 1.8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text('機緣道旨妙法入門卷', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _gold)),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5C518).withOpacity(0.05),
        border: Border.all(color: const Color(0xFFB8941A).withOpacity(0.4)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFFB8941A))),
    );
  }
}