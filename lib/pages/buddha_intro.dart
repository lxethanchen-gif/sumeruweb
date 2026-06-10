import 'package:flutter/material.dart';

class BuddhaIntroPage extends StatelessWidget {
  const BuddhaIntroPage({super.key});

  static const _gold = Color(0xFFC9A84C);
  static const _goldLight = Color(0xFFE8C96E);
  static const _textColor = Color(0xFF8B6914);

  static const _intro = '''諦深大師俗姓呂，淨土獲證，禪宗傳承。上乘清淨願力為諦，下令眾生世界業障破滅稱深。諦深法號為佛光普照神僧呼喚所得。落髮戒名釋迦妙生，祖籍山東即墨。佛曆2506年11月18日（農曆壬寅年11月18日）生於遼寧省瓦房店，生後至3歲不會說話，會講話後秉性甚憨，家人以為有疾！後因文革風暴，隨父母回遷祖籍。

1、26歲與當地寺院結緣，時寺內無出家人住。

2、初入寺廟助僧賣票，因離家太遠，夜於院外會計室獨自休息，忽見牆體虛盡，佛光普照，有神僧獅子吼音三稱諦深，因此得名。

3、入寺前未見過經書亦未入過其它寺院，不懂佛門諸事。其後，多與佛門道人來往，並獲結緣《金剛經》，於居士處獲《華嚴經》、於寺得《法華經》、於居士處獲《楞嚴經》。

4、與一出家道僧緣分甚大，並為其所動獨自發心出家，於山底被一拉比丘尼車送之寶寺，當夜見韋陀菩薩顯聖，翌日下山。

5、首訪大乘寺，未入山門即聞鐘鼓齊鳴，天人誦經，禁不住讚曰：「好聽，好聽，好聽！」時大乘寺只一道僧與其弟子兩人止住！於次日夜韋陀菩薩贈無字真經。

6、於租住屋內見一草履蟲附於牆體，便薰香送之，草履蟲忽然落於地上行將斃命，此時，手不能動，香條被彎曲，急念佛號並於床下拜佛。

7、於深夜，猛然金紅光地藏菩薩顯聖，居然並不認得，問出家人並見其形象與地藏殿地藏菩薩一樣，只是呈紅金瑞相，方知是大願地藏菩薩示現。

8、於住處研《楞嚴經》，一日居士來訪，正碰小雨，有術士不用火源，雨中以手指點燃浸濕報紙，見後忽明《楞嚴經》中「性火真空，性空真火，周遍法界、遍虛空界，隨眾生心應所知量」，大喜，時撐傘圍觀者數十。

9、於住處閱《楞嚴經》，世界虛盡放大光明。

10、2001年應戒，於夢中見一高大琉璃廟宇轟然倒塌，於伽藍殿跪香一夜，不久，駐山並行腳四方。''';

  static const _images = [
    'assets/images/buddha_1.jpg',
    'assets/images/buddha_2.png',
    'assets/images/buddha_3.png',
    'assets/images/buddha_4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final isDesktop = w >= 1024;
            final isTablet = w >= 600 && w < 1024;
            // Desktop: 兩欄（左圖右文）；Tablet/Mobile: 單欄（上圖下文）
            return isDesktop
                ? _DesktopLayout(images: _images, intro: _intro)
                : isTablet
                    ? _TabletLayout(images: _images, intro: _intro)
                    : _MobileLayout(images: _images, intro: _intro);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// 共用常數
// ─────────────────────────────────────────
const _gold = Color(0xFFC9A84C);
const _goldLight = Color(0xFFE8C96E);
const _textColor = Color(0xFF8B6914);
const _bgNav = Color(0xFFFDF8EE);
const _border = Color(0xFFD4AF6A);

// ─────────────────────────────────────────
// 共用元件
// ─────────────────────────────────────────
class _GoldDivider extends StatelessWidget {
  const _GoldDivider();
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(width: 4, height: 22, color: _gold,
              margin: const EdgeInsets.only(right: 10)),
          Expanded(child: Container(height: 1, color: const Color(0xFFEDD98A))),
        ],
      );
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.titleSize, required this.subtitleSize});
  final double titleSize;
  final double subtitleSize;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '諦深大師簡介',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: _gold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '淨土獲證・禪宗傳承・佛光普照',
            style: TextStyle(
              fontSize: subtitleSize,
              color: _goldLight,
              letterSpacing: 1.5,
            ),
          ),
        ],
      );
}

class _IntroText extends StatelessWidget {
  const _IntroText({required this.intro, required this.fontSize});
  final String intro;
  final double fontSize;

  @override
  Widget build(BuildContext context) => Text(
        intro,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: _textColor,
          height: 2.1,
        ),
      );
}

class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({
    required this.images,
    required this.crossCount,
    required this.spacing,
    this.aspectRatio = 0.85,
  });
  final List<String> images;
  final int crossCount;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: aspectRatio,
        ),
        itemCount: images.length,
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            images[i],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: BoxDecoration(
                color: _bgNav,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _border),
              ),
              child: const Center(
                child: Icon(Icons.image_not_supported_outlined,
                    color: _gold, size: 32),
              ),
            ),
          ),
        ),
      );
}

// ─────────────────────────────────────────
// Desktop：左側圖片欄 + 右側文字欄
// ─────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.images, required this.intro});
  final List<String> images;
  final String intro;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(64, 40, 64, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PhotoGrid(
              images: images,
              crossCount: 4,
              spacing: 16,
              aspectRatio: 0.82,
            ),
            const SizedBox(height: 36),
            const _TitleBlock(titleSize: 28, subtitleSize: 14),
            const SizedBox(height: 20),
            const _GoldDivider(),
            const SizedBox(height: 24),
            _IntroText(intro: intro, fontSize: 15),
          ],
        ),
      );
}

// ─────────────────────────────────────────
// Tablet：上方 2x2 圖片 + 下方文字
// ─────────────────────────────────────────
class _TabletLayout extends StatelessWidget {
  const _TabletLayout({required this.images, required this.intro});
  final List<String> images;
  final String intro;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(32, 36, 32, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PhotoGrid(
              images: images,
              crossCount: 2,
              spacing: 12,
              aspectRatio: 1.1,
            ),
            const SizedBox(height: 32),
            const _TitleBlock(titleSize: 24, subtitleSize: 13),
            const SizedBox(height: 16),
            const _GoldDivider(),
            const SizedBox(height: 20),
            _IntroText(intro: intro, fontSize: 15),
          ],
        ),
      );
}

// ─────────────────────────────────────────
// Mobile：上方 2x2 圖片 + 下方文字（緊湊）
// ─────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.images, required this.intro});
  final List<String> images;
  final String intro;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PhotoGrid(
              images: images,
              crossCount: 2,
              spacing: 8,
              aspectRatio: 0.9,
            ),
            const SizedBox(height: 24),
            const _TitleBlock(titleSize: 22, subtitleSize: 13),
            const SizedBox(height: 14),
            const _GoldDivider(),
            const SizedBox(height: 16),
            _IntroText(intro: intro, fontSize: 14),
          ],
        ),
      );
}