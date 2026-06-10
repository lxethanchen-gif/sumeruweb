import 'package:flutter/material.dart';

class JiYuanDaoZhiPage extends StatelessWidget {
  const JiYuanDaoZhiPage({super.key});

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFF5C518);
    const textStyle = TextStyle(fontSize: 16, color: goldColor, height: 1.8);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '諦深大師開示：滅自己執見',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: goldColor,
                height: 2,
              ),
            ),
            Text(
              '標籤: 滅罪卷　開示子集：破障　2016/01/01',
              style: TextStyle(fontSize: 14, color: goldColor, height: 2),
            ),
            Text(
              '2、滅自己執見滅諸邪魔外道侵染罪',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: goldColor,
                height: 2,
              ),
            ),
            Text(
              '開悟滅諸漏，開悟稱漏盡。凡夫未悟時，亦有滅漏法，其稱諸戒律。對於諸修行，卻漏戒中來。',
              style: textStyle,
            ),
            Text('。。。。。。', style: textStyle),
            Text(
              '善知識，所謂佛寶，乃應清淨佛光所化，因之開悟之大勢因緣而生，是興大慈悲之方便度眾之身，故稱佛寶。是故如來，無所從來無所去，以得度者成就化身，稱為如來。佛說滅度，實未曾滅，只是眾生罪孽深重，多於知見量度佛法，共鳴知見以為大善，於佛本指失於敬信，丟失佛所本指，執見為障不得見佛，而稱為滅。',
              style: textStyle,
            ),
            Text(
              '善知識，所謂法寶，乃佛示現智慧之藏，譬如以手示月，若為指做種種說，不見於月亦不見真指，指月雙丟。如是等佛門諸子，為護佛法，雖為未悟之人，但佛為做證無有罪過，十方如來皆救拔之，終獲出離。',
              style: textStyle,
            ),
            Text(
              '執見狂人，未得開悟，以自己執見種種假說、種種見解、種種引用以彰己之知見，以如來假說，實立自己名相，令眾迷失。是等各個稱證無上道，共鳴罪眾如螻蟻多，實則未證謂證、未得謂得，褻瀆慈悲，罪孽自造。是等因自己執見成業，誆騙徒眾成其轉世業報，於無量劫受大罪苦。是等為求迴避受侵而設業障，越設越固，如作繭自縛，成就地獄，自不求出，求出難出，十方如來皆淚視此等，苦中無度。',
              style: textStyle,
            ),
            Text(
              '善知識，所謂僧寶，乃佛法傳承用相，以戒律為體，不持戒律即非僧寶。若以相取之，即墮大坑。僧寶分大行僧、獨行僧、布道僧、傳承僧、修道僧等，若假僧衣而無戒相，即波旬顯前。若無僧寶，佛法失傳。僧寶之體，相用多門。有一戒僧相、兩戒僧相，如是乃至若干戒相，此乃佛用，勿於誹謗。圓滿戒相，以心為用，佛陀住世。若一戒不持，非佛門人。',
              style: textStyle,
            ),
            Text('。。。。。。', style: textStyle),
          ],
        ),
      ),
    );
  }
}