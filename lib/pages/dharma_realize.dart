import 'package:flutter/material.dart';
import 'footer.dart';

// ── 風格常數（與 jiyuandaozhi.dart 一致）────────────────────────
const _kGold = Color(0xFFF5C518);
const _kGoldDim = Color(0xFFB8960E);
const _kGoldBorder = Color(0x59F5C518); // gold @ 35%
const _kGoldBorderDim = Color(0x26F5C518); // gold @ 15%
const _kCardShadow = BoxShadow(
  color: Color(0x14000000),
  blurRadius: 10,
  offset: Offset(0, 4),
);
const _kCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(16)),
  border: Border.fromBorderSide(BorderSide(color: _kGoldBorder, width: 1)),
  boxShadow: [_kCardShadow],
);
const _kTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: _kGold,
  height: 1.4,
);
const _kBodyStyle = TextStyle(fontSize: 13.5, color: _kGoldDim, height: 1.7);
const _kTagDeco = BoxDecoration(
  color: Color(0x0DF5C518), // gold @ 5%
  border: Border.fromBorderSide(BorderSide(color: _kGoldBorderDim, width: 1)),
  borderRadius: BorderRadius.all(Radius.circular(6)),
);
const _kTagStyle = TextStyle(fontSize: 11, color: _kGoldDim);

// 自定義 ScrollBehavior 以徹底移除捲動軸
class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class DharmaRealizePage extends StatefulWidget {
  const DharmaRealizePage({super.key});

  @override
  State<DharmaRealizePage> createState() => _DharmaRealizePageState();
}

class _DharmaRealizePageState extends State<DharmaRealizePage> {
  int _selectedChapter = 0;

  static const _chapters = [
    (
      '第一章 序品',
      '''一、釋疑

現在一提學佛，人們或多或少地將其與迷信聯繫在一起，或把學佛定性為宗教活動；或將佛法與歪門邪道等同。此乃釋迦如來佛法末世所應、之現前因緣；此更顯末世眾生罪孽深重於佛善法難生敬信。

人們之所以對佛法疑惑難生信心，因為佛法滅度與佛無關，與眾生因緣果報所成的業報緣分有關。佛身為清淨法身、圓滿報身、無量化身。所謂佛誕生，是眾生福報所成大勢因緣；所謂佛法滅，是眾生罪孽所成大勢因緣。

為什麼眾生罪業深重會對佛法難生敬信，因為所謂罪業，即是諸業興起成清淨障礙。種種業障因阻礙眾生出離苦海，所以稱為罪業。是故其業逾深，其障逾大；其障逾大，於無障法逾加遠離。如來法是無障善法，是故罪孽深重之人於佛善法難生敬信；是故罪孽深重之人共業之世，諸業興起，眾多罪孽之人，共聚之處善法難興，佛法步入末世，進而遭滅。所謂佛法滅，是處眾生心中出苦道滅，而十方佛法實不曾滅。

末世道場之中以種種器興種種音—咒音、律音等等器音以此讚佛。此景看似造音讚佛，實則破壞清淨，毀佛戒律，令清淨佛法丟失傳承逐一斷滅。既無佛法傳承，業重之人於道場中稱佛弟子，雖非善人卻被善讚，讚稱法師，罪孽之眾成善知識，道場之內因善法丟失與惡世等同。如是成就既無佛法傳承，也無善知識引導，更無久遠劫修行的善法道緣之末世道場。

末世道場既成，種種邪道如春之卑草，無處不生、無處不有。其中即使有些人真正讀頌佛經，亦屬盲修瞎練，終因自己所見、所染之種種法得所成知見，判評成疑，落愛見坑。是等人中不乏有以出家身、法用身研藏之眾，其雖因業重己無所證，但為業所使成慢心用，對佛法大加解釋，令佛藏之義丟失，如是知見修墮落大坑，成就眾生無佛法世。

所以，與佛法有緣之人應了解佛法要略多行修證。否則，於佛法中如童子頑雷應時求滅。

二、什麼是「迷信」

「迷」是糊塗，「信」則是認可和接受，所以「迷信」就是糊塗的認可與接受事情的意思。

1．「迷信」的誕生

既然「迷信」的根本就是糊塗，要驅除「迷信」就必須知道糊塗是怎麼來的。

比如：吸菸。吸菸的人都知道吸菸對自己有害，可為什麼還要吸？按正常推理就兩方面的原因，一是吸菸的人不知道吸菸對自己有害，二是神經有毛病。事實上這兩方面的原因都不是，那是什麼呢？這裡面有個根本東西在作怪，就是糊塗。由於糊塗，吸菸的人知道有害也要吸，久而久之就養成了吸菸的習氣，而且慢慢地在吸菸這種問題上與其他的吸菸人形成了一些共識和種種不同的見解。

2．「迷信」中的法

「糊塗」中的人知道自己糊塗嗎？回答是否定的，因為如果他知道自己糊塗的話，他就不是糊塗中人了，糊塗人不認為自己糊塗這是正常現象。

既已糊塗，在糊塗根本中求事理，以糊塗中的規律為明白，不知道此種明白乃糊塗的理性所成，人們心目中的明白和糊塗就成了一回事，如是造就糊塗法理。

3．解決迷信問題的途徑

A．出世間法與世間法

解決「迷信」問題最簡單、最徹底的辦法，就是「明白」過來。怎樣才能「明白」過來呢？這就需要一種能令人不糊塗的法，這種令人不糊塗的法就是出世間法。

比如：吸菸是糊塗，而不吸菸就是明白，那就把菸戒掉嘛，有什麼難的？這樣一來，由吸菸引起的種種問題也就自然解決，這就是「出世間法」。

B．出世間法的「特徵法」

出世間法特徵是：明白自性，滅除障礙，成清淨體，有此三得的人稱為明心見性，也稱開悟，也稱成法身佛。

對初入佛門的人來說，不要因為自己想不通、不能證得佛法就對佛法妄加推斷與評論，這樣會斷掉自己的慧根與善根在苦難中難有出期。

C、世間法的特徵

世間法的表象特徵：解決迷信問題的另一種越搞越麻煩的方法就是——由吸菸帶來的問題出來一個研究一個，然後一個一個用新發現的辦法予以解決，新發現的辦法又形成了新的研究領域，相對於這些個領域又誕生了更多的問題與方法！最後問題越來越多，法也越來越多。

「世間法」的「過程積累」在佛門稱之為業！世間法是種種科學門類的總稱。

4．「迷信」中的痴迷

現在大部分人已經不知道「迷信」是什麼了，既然已經不知道什麼是「迷信」，在種種問題面前，也就不辨是非，有時候大家都認為是對的，沒準就錯了，而且錯的不能回頭，於是更迷，這也是人們上當受騙的原因。

5．「迷信」是騙子行騙的基礎

要解決騙子的問題，首先得知道什麼是騙。「騙」是借別人糊塗，也就是不明真相之機，使人得到的回報與希望和情理中應該得到的回報完全不同或相差懸殊的一種承諾，所以，欺騙的來源同樣是糊塗。

6．「迷信」是歪門邪道的熾盛空間

人在「迷信」中都會認為自己不「迷信」，於是「迷信」就成了生活中的不「迷信」，這樣一來迷途中人就因為不知道什麼是「迷信」而掉到種種「迷信」的天國裡自以為是不聽人勸，要讓他們不「迷信」越來越難，這就給歪門邪道的熾盛創造了條件。

7．出世間法中的糊塗人

佛學是專門為治糊塗病才誕生的，不過就連一部分學佛的人由於種種原因也對佛學知之甚少，這部分人就是出世間法中的糊塗人。

8．要了解佛文化

沒接觸過佛法的人，切勿談論有著幾千年文化底蘊的佛法。歸依佛門，剃度出家精進修持，因緣具足或得少分，何況以訛傳訛，演義妄編以為佛法。

中國是一個以佛文化引以為榮的國家，每個人都應了解一點真正的佛法常識。''',
    ),
    (
      '第二章 什麼是佛學',
      '''什麼是佛學？佛學是使人不糊塗之後，獲得清淨本體，從而出離罪苦的學問，其學問內涵是令眾生出離苦海的智慧。所以，佛學是以使人不糊塗為體的智慧住相。佛是斷滅了一切糊塗根本的徹悟者，是徹底明白沒有障礙的無上尊。佛這個字是梵語，翻譯過來是「徹底明白」和「大徹大悟」。

1．什麼是信

「信」是認可和接受，由於「信」並沒有正邪之分，也就是說「信」不具判斷力，一個人要信仰一種東西，有可能信正了，也有可能信歪了。所以，要保證自己的信仰不出差錯，必須對一些道法進行印證，只有這樣才能有一雙明亮的眼睛，這雙眼睛就是自己印證之後的智慧之眼。

2．什麼是佛教

什麼是佛教？佛教是怎樣形成的？按現在人們對宗教的定義理解，佛教是不了解佛學的人對佛門的錯位定義，由於這種定義的廣泛傳播，久而久之就形成了今天的佛教。正確地講，由學佛的人為學佛組成的體系，應稱之為佛學研究會或佛學學院等，也就是說將其定性為一種宗教、本身就偏離佛學的本體。

佛法是佛令眾生出離苦海的慈悲甘露，不是教化、而是度化。度不是教，是根據各自不同的因緣，對症轉化，以令罪孽眾得以出離苦海。所以佛法不是教育，若有人當以水得度，則佛法是水；若有人當以食得度，佛法是食；若有人當以船得度，佛法是船；若有人當以橋得度，佛法是橋。

3．什麼是學佛

第一、持戒是學佛的基礎

什麼是學佛？怎樣做稱得上學佛？因為佛學是使人不糊塗、最後破滅障礙出離罪苦的學問，而糊塗人尚在糊塗之中，怎麼會明白呢？這就要有強制措施，這個強制措施就是戒律，只有持戒修行，才能證得佛法。所以，簡單地說，學佛首先要受戒並持戒，如果有人不持戒以為能證得佛法，就如同不吃飯以為能飽的凡夫一樣愚昧。

第二、未經講解過的佛的原經是入正法的基礎

佛經是學佛的課本，學佛要認真地參閱佛親口所宣的經，也就是佛的原經，只有這樣才能不偏離正法，獲得出離六道的智慧。這就像小孩上學的課本一樣，老師講的東西固然重要，它可以啟迪學生理解課本的內容，但不能作為課本。

第三、要多行善布施，皈依佛、法、僧三寶弘法利生，並且要會結善緣，只有這樣才能消除出離六道的障礙。

4．對學佛的定義

佛法是指為救度眾生，十方諸佛所作的離苦印引導，佛法含種種體、種種門。學佛出離苦海之用相說，入佛門眾生，不以學為要，乃以持戒參禪修得出離苦海稱為學佛。

釋迦牟尼佛是無量無邊無數佛中的一尊，是在我們娑婆世界現前成佛，救度眾生的無上之尊——天人師、佛、世尊。

佛門不貶低任何人，眾生皆具佛性。哪怕蒼蠅、蚊子、豬狗、貓鼠等等等等都具佛性，這是成佛的人印證了的。既然人人都具佛性，那為什麼不能成佛？因為眾生用心有誤，成佛是破滅障礙後的果報。

5．佛學與科學

佛學是從眾生的根本上解決問題的清淨心表徵的智慧，是為度眾生之名相用詞，是關於眾生如何破滅障礙出離六道的出世間法，不是學問，所謂學問乃用相說。

科學是遇到問題才解決的認識，是攀緣心表徵的世間法，也稱為修行道障。從佛法上說，科學是攀緣心的體現，是人們丟失清淨心的依止，科學的發展是末法的表徵，是佛法滅度的緣起！但是，從眾生這裡說，科學是其生存的根本！

6．什麼是魔

種種執著都是著魔，所以，只要令人執著的法就是邪魔外道法。佛法是種種不執著，這叫離一切相。

種種魔法的顯現有善也有惡。諸善奉行諸惡不為入揚善門就是「正」，善惡不分入欺誆門是「邪」，而用法行惡就是「魔」。

佛門不以神通令眾歎服，佛門神通，為引眾出離苦海之一微塵法，當用則用，不當用不用。眾生修行過程，有諸多罪、諸多苦，佛門僅以神通為消災滅苦後能得度眾消灾、滅苦令其出離，不以神通令眾痴迷。所以，佛門大德無有以神通示眾者。

佛門不搞崇拜為什麼燒香磕頭？這就要從佛門的禮節與律儀談起了。磕頭在佛門稱為接足禮，也稱頂禮，是佛門的禮節。這與現代人敬禮的用處是沒有區別的。關於燒香這個問題，事實上與六道眾生的種種習業、種種生存之道有關，嚴淨毗尼，入於禪定自知是等由來。把佛門的燒香與通常普通人燒香燒紙求神求鬼的「迷信」活動聯繫起來實際上是一個錯誤，因為佛門的香火並不是「迷信」。''',
    ),
    (
      '第三章 末法學佛論',
      '''什麼是末法？末法就是眾生因貪、嗔、痴、慢心執著而成的種種貪、嗔、痴、慢相、用此心、此相去念佛、論經。

末法時代的表徵，是諸多的大師為適應於時代人心理特徵，去有執見的對佛經予以解釋，然後，過了幾百年再誕生一些大師，對以前大師們的傑作，用自己的執見順應潮流的予以講解，這樣一來佛的經典就會逐一泯滅。與此同時因為佛法衰落，諸多圍繞著佛法舉起的歪門邪道，也就因為其適應於人們的心理特徵，堂而皇之地被當代的人所接受，因此人們也就難以分清佛法與歪門邪道了。

末法時代如何入佛門修行？最重要的問題是要受戒並能持戒然後深入經藏，以經為指，以印證佛法為修行，其身要親近清淨善知識，以淨為本。而且，絕對不能有貪、嗔、痴、慢之心，絲毫不得有殺、盜、淫之念。一定要以慈悲為己任。

了解佛法，是以勸導為體，對因不了解佛法而對佛法有偏見、偏執之人作的一些常識性解釋。

因此善本結緣之善者，譬如：一些該上學的孩子沒有報名上學，上過學的人知道了上學的重要，以憐憫心到他們家裡以種種事、種種理、種種法勸導他們上學一樣，對聽了勸說上學讀書獲利去的人，是善導勸說；對不聽勸說之人，亦為善導勸說，因雖其因種種疑、種種因、種種罪思罪想沒能上學，但於未來際，當其看到上學善人獲得極大利益，就會決心令自己之後代，不履覆轍，不像自己愚昧罪孽不去上學，而且自己亦將盡己所能去學習，此稱令眾生心、令眾生信。

我做勸導亦復如是，為令眾於佛善法生心，為令眾於佛善法生信，此亦稱為布施佛種。

各位有緣善者，入於佛門，是如來所寄，是眾生出離苦海之唯一一門，釋迦牟尼佛留下浩瀚經書，能給有緣善者以無邊智慧、無邊福報，也能令所有入門之人，從此脫離種種苦縛，最後成佛。

南無常住十方佛、南無常住十方法、南無常住十方僧、南無本師釋迦牟尼佛、南無大悲觀世音菩薩、南無大願地藏王菩薩、南無大勢至菩薩、南無大智文殊師利菩薩、南無大行普賢菩薩、南無清淨大海眾菩薩、南無護法韋馱尊天菩薩。''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoScrollbarBehavior(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 1024;
              final isTablet = constraints.maxWidth >= 600;
              final hPad = isDesktop
                  ? 48.0
                  : isTablet
                  ? 32.0
                  : 16.0;
              final tabFontSize = isDesktop ? 14.0 : 12.0;

              return Column(
                children: [
                  _buildNavBar(hPad, tabFontSize),
                  // 分隔線：使用與卡片一致的金邊色
                  Container(height: 1, color: _kGoldBorder),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _ContentBody(
                        key: ValueKey(_selectedChapter),
                        title: _chapters[_selectedChapter].$1,
                        content: _chapters[_selectedChapter].$2,
                        hPad: hPad,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(double hPad, double fontSize) => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 14),
    child: Row(
      children: List.generate(
        _chapters.length,
        (i) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
            child: _ChapterTab(
              title: _chapters[i].$1,
              isSelected: _selectedChapter == i,
              fontSize: fontSize,
              onTap: () => setState(() => _selectedChapter = i),
            ),
          ),
        ),
      ),
    ),
  );
}

// ── 章節 Tab ────────────────────────────────────────────────────
class _ChapterTab extends StatelessWidget {
  const _ChapterTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.fontSize,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? _kGold : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? _kGold : _kGoldBorder,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : _kGoldDim,
        ),
      ),
    ),
  );
}

// ── 章節內容（卡片包裝）────────────────────────────────────────
class _ContentBody extends StatelessWidget {
  const _ContentBody({
    super.key,
    required this.title,
    required this.content,
    required this.hPad,
  });

  final String title;
  final String content;
  final double hPad;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollbarBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 28, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: hPad),
                  padding: const EdgeInsets.all(24),
                  decoration: _kCardDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 章節標題
                      Text(
                        title,
                        style: _kTitleStyle.copyWith(
                          fontSize: 20,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 底部強調線
                      Container(
                        height: 2,
                        width: 48,
                        decoration: BoxDecoration(
                          color: _kGold,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 正文
                      Text(
                        content,
                        style: _kBodyStyle.copyWith(fontSize: 15, height: 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const SumeruFooter(),
          ],
        ),
      ),
    );
  }
}

// ── Tag 元件（供未來擴充使用）───────────────────────────────────
class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: _kTagDeco,
      child: Text(label, style: _kTagStyle),
    );
  }
}