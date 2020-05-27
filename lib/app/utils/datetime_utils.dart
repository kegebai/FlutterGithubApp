import '../cons.dart';

class DateTimeUtils {
  ///
  static String nowIso() => DateTime.now().toIso8601String();

  ///
  static int nowTimestamp() => DateTime.now().millisecondsSinceEpoch;

  static String fmtDateTime(DateTime date) {
    if (date == null || date.toString().isEmpty) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  // static String _fmt(int time, double dtime) => (time / dtime).round().toString();

  static String fmtNewsDateTime(DateTime date) {
    int subTimes = nowTimestamp() - date.millisecondsSinceEpoch;
    bool isNotZH = Cons.curLocale.languageCode != "zh";
    /// Internal function
    String _fmt(int t, double dt) => (t / dt).round().toString();

    if (subTimes < TimeCons.MILLIS) {
      return (Cons.curLocale != null) ? (isNotZH ? "right now" : "刚刚") : "刚刚";
    } 
    else if (subTimes < TimeCons.SECONDS) {
      return _fmt(subTimes, TimeCons.MILLIS) +
          ((Cons.curLocale != null) ? (isNotZH ? " seconds ago" : " 秒前") : " 秒前");
    } 
    else if (subTimes < TimeCons.MINUTES) {
      return _fmt(subTimes, TimeCons.SECONDS) +
          ((Cons.curLocale != null) ? (isNotZH ? " min ago" : " 分钟前") : " 分钟前");
    } 
    else if (subTimes < TimeCons.HOURS) {
      return _fmt(subTimes, TimeCons.MINUTES) +
          ((Cons.curLocale != null) ? (isNotZH ? " hours ago" : " 小时前") : " 小时前");
    } 
    else if (subTimes < TimeCons.DAYS) {
      return _fmt(subTimes, TimeCons.HOURS) +
          ((Cons.curLocale != null) ? (isNotZH ? " days ago" : " 天前") : " 天前");
    } 
    else {
      return fmtDateTime(date);
    }
  }

}
