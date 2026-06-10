import 'package:flutter/material.dart';

class JiYuanDaoZhiPage extends StatelessWidget {
  const JiYuanDaoZhiPage({super.key});

  static const _gold = Color(0xFFF5C518);
  static const _goldMuted = Color(0xFFC8A43A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          int crossAxisCount = screenWidth > 1000
              ? 3
              : (screenWidth > 600 ? 2 : 1);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child: Column(
              children: [
                _buildPageHeader(),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildCard(
                      screenWidth,
                      crossAxisCount,
                      title: '諦深大師傳戒法音摘弘',
                      tag: '機緣道旨妙法入門卷 開示子集：持戒   2014/03/15',
                      content:
                          '所謂我慢，乃盧舍那佛設戒啟分，與貪、嗔、癡、殺、盜、妄共為攀緣罪根七分，淫戒為攀緣用分。而我慢又是貪嗔癡殺盜妄之相體，故依慢做傳戒中一註。\n\n我慢不除，險道自成。因，若有人附，則慢成癡與情體，幻成淫根；若有人逆，則慢成：弱則殺、強則嗔、盜、妄緣。狂妄是我慢的行為表徵，是故人之入戒修道，慢為第一戒障。',
                    ),
                    _buildCard(
                      screenWidth,
                      crossAxisCount,
                      title: '諦深大師開示：得戒',
                      tag: '機緣道旨妙法入門卷 開示子集：持戒   2013/02/17',
                      content:
                          '''1、不殺生。所謂不殺戒相，不斷一切眾生性命。釋：殺為眾生諸罪頭等，若不斷殺，諸戒難立。生命為眾生種種因緣應相，若斷之命，現前因緣被斷，即處轉惡殺因緣。
                            \n生命為眾生種種因緣應相，為識心托處，種種因緣所化，顯前因緣為相互依托之本。若斷之命，現前因緣被斷，即處轉惡殺因緣，於本心中生惡殺本分，於之殺業成惡緣纏。有殺業者，必轉生被殺途中，難有出期。鬼神之道以殺為本，處處現殺。鬼神之屬於佛法難於行道，因其殺業極盛，道場無以立相。
                            \n是故，不殺為了惡之始，人欲修行需先了惡，若不了惡，因緣更纏，說出六道，妄中求妄也。

                            \n2、不盜。不盜戒相，為應戒第二。不取非予之物，稱不盜戒。不盜雖為不殺支分，但另含新分自成一體。釋：盜為斷眾生因緣命相之做，亦稱次等殺生，入門應戒，不盜第二。
                            \n不盜戒為第二大戒。何故是說？眾生生命非一口氣耳，諸多因緣共同稱為之之生命。盜取人之物品，實為斷殺其之命因之一，是故稱盜為殺戒第二。
                            \n不盜戒分為輕重層析，重盜於殺等；輕盜受如下等報：一者，困苦潦倒報；二者，遭人攻擊報；三者，或獲遭殺報。
                            \n是故，入門應戒，不盜第二。若有人盜如來種種品；沙彌、比丘種種品；清淨道場種種品，為重罪。或遭與殺戒等報。
                            
                            \n3、不淫。不淫戒相，男女交媾，為應戒第三。釋：淫為因緣合和六道之本，淫心為輪轉之處，欲出六道，淫為第一道障。
                            \n雖淫心為第一道障，但是，於淫欲界中，淫能遏殺，能以不被殺滅而立道場，是故不淫第三。
                            \n淫欲有因緣集結功用，眾生緣分顯為淫心。若淫欲旺，實為因緣所使，殺盜淫妄皆於其中。殺、盜、淫、妄等等所有因緣，相互輪轉成相即是淫心。殺、盜、淫、妄為淫心大根，淫何故亦在淫根之列？因淫為轉集，層次甚多，諸多因緣相轉都落淫相。
                            \n不淫，有不再多遭眾生因緣相托之續大用，但，如殺心盜心等等不除，說不淫者，同於水中求月，徒然用功。淫心又是因緣再輪之初，雖不顯殺盜等等諸相，但淫轉之後，諸相會隨緣分運行相繼顯現。因諸相不直接顯現故，不淫戒為第三大戒。

                            \n4、不妄，實而不虛諸相。虛妄為世界之初始，造種種業之始。眾生之妄為妄中之妄，若不破除，難於修道。是故，不妄為根本大戒。
                            \n釋：妄為六道之本，何故為第四戒，而非第一戒律？因未悟之前眼、耳、鼻等諸業已就，眾生以此為實，而所謂為實，其中又生諸妄，諸妄又生種種。修行之者所持初之妄戒，實為次之又次之妄，之於殺、盜、淫等業之眾生頂罪惡相大本為次，是故，不妄第四。
                            \n善者，不妄之者並非妄語一乘，含概諸多，因以妄語為表象，釋迦如來滅後，長久以來，傳戒者不清淨故於戒有失，是故，以不妄語代不妄戒傳稱至今。
                            \n佛地門戒要

                            \n5、不貪。貪為攀緣之相，是眾生之本。貪有兩分，一者侵分，二者狂根分。
                            \n侵分為占有別人之相，於是獲嗔，因嗔生爭，因爭生鬥，因鬥生殺。
                            \n狂根分以獲取體大為相，因大生慢，以慢為強，以強凌弱，凌為殺因；
                            \n又侵狂未成殺盜之時，相纏成體，纏之成相，造諸相欺、相瞞、相用等等諸相，以造虛偽，借用等鬼道用相，等等。是故貪為諸戒壞處，自成一體，為第五大戒。

                            \n6、不嗔。不嗔戒，為殺盜等根本戒體之構成支分戒，是不殺戒的分戒、不盜等諸戒的緣分戒。雖為殺盜淫等緣分，但自成一體，是故為第六大戒。
                            \n嗔為不殺律之一藏，是殺之導引。殺心之初處之一為嗔，由嗔生殺，是故修行之者當不嗔。
                            \n如何不嗔？當斷習氣。習氣之成，造我為相。因習氣故，對不入汝之習氣者生嗔恨心，因嗔恨故誕生惡念。是故，斷嗔為如來第六戒相要旨。

                            \n7、不癡。不癡戒，為破眾生輪轉之本之如來加持應戒。因癡人於善法難於生信，是故如來以「不可思議」說菠蘿蜜為慈悲法布施眾生。
                            \n癡為以不明、糊塗、執著、迷信等為行為之相。是殺盜等諸惡胚體，乃諸惡依附之本，入佛國土，癡之不除，養虎為患，眾生之大障。

                            \n8、不慢戒。為攀緣體相戒，乃諸多戒之同分戒。不慢卻攀緣心根，止纏縛造惡之本，有遏止六道根本生相之用。
                            \n如何是慢？慢為以己之得處，鄙視無者。
                            \n慢心成處：
                            \n一者，以希冀追求、生攀緣心；以攀緣造業成體、為如願，得成「墮落願望」心；
                            \n以願望心發墮落願；以自己所造之業為得、做頂、生傲視心，如是成就我慢心。
                            \n二者，妄中求得，以妄中有求、視為己勝而成妄得，妄得既成而成傲視心，以此成頂造就慢心。三者，習業為體，據業為勝，鄙視來者，以成傲視心，因此為得成就慢心。
                            \n修行之道不去慢心，無有成處。是故，不慢為如來第八根本戒處。
                            \n（選自《普修行藏》三、《機緣道旨妙法入門》中第五品《得戒》共有20戒。）
                            ''',
                    ),
                    _buildCard(
                      screenWidth,
                      crossAxisCount,
                      title: '諦深大師開示：攝緣',
                      tag: '機緣道旨妙法入門卷 開示子集：攝緣   2013/01/25',
                      content:
                          '''各位弟子，入於佛之法座下，是稱入十方佛攝緣法。十方世界妄心攀緣成因、因因造業，業成緣分、緣緣相扣、成就緣起，緣起成像，造諸種類。種類起緣，各業互牽，又造共業，諸多種類，為攀緣故，遞弱為食，互相凌滅，滅後互轉，成就六道。
                          \n諸善因緣，汝等因慈悲故而獲救度，是大果報，非一世、兩世、乃至千世萬世無量世劫因緣所至。汝等無始劫來，種種修行造種種善，成就善種，善種量吸成因，滋潤伸展，吐善成根，蔽惡納善，獲普洽甘露，享六波羅蜜，於是善成佛緣，生成佛種。爾等佛種發芽，大福報現前，入佛門下得獲救法，此稱攝緣。攝緣既成，成佛國土，此稱成佛。攝緣乃十方諸佛興慈悲法，是十方諸佛甘露施法，是十方眾生成佛之法。
                          \n釋迦如來、三藏十二部，彌陀如來四十八願，乃至文殊普賢、觀音勢至十方大善，所行道法，皆攝緣法。
                          \n（註：摘自諦深大師《普修行藏》，因為這是具戒比丘與具戒大沙彌專用，大部分章節非具戒者不能傳閱，望廣大修行善解。）''',
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(
    double screenWidth,
    int count, {
    required String title,
    required String tag,
    required String content,
  }) {
    double cardWidth = (screenWidth < 600)
        ? screenWidth - 32
        : (screenWidth / count) - (24 * count);

    return Container(
      width: cardWidth.clamp(300, 450),
      height: 550, // 設定固定高度，內容過長可滑動
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _gold,
            ),
          ),
          const SizedBox(height: 12),
          _Tag(tag),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: _goldMuted,
                  height: 1.8,
                ),
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
      child: Text(
        '機緣道旨妙法入門卷',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: _gold,
        ),
      ),
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
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, color: Color(0xFFB8941A)),
      ),
    );
  }
}
