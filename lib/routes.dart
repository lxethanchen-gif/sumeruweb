/// 頁面索引常數，對應 MainShell._pages 的順序
class PageIndex {
  static const int home = 0;
  static const int dharmaRealize = 1;
  static const int yingShiJuan = 2;
  static const int mieZuiJuan = 3;
  static const int jiYuanDaoZhi = 4;
  static const int shiZhai = 5;
  static const int videoTeachings = 6;
  static const int resourceLinks = 7;
  static const int buddhaIntro = 8;

  /// 文字開示的子頁面範圍
  static bool isTextTeachings(int index) => index >= 1 && index <= 5;
}