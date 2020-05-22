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

    if (subTimes < TimeCons.millis) {
      return (Cons.curLocale != null) ? (isNotZH ? "right now" : "刚刚") : "刚刚";
    } 
    else if (subTimes < TimeCons.seconds) {
      return _fmt(subTimes, TimeCons.millis) +
          ((Cons.curLocale != null) ? (isNotZH ? " seconds ago" : " 秒前") : " 秒前");
    } 
    else if (subTimes < TimeCons.minutes) {
      return _fmt(subTimes, TimeCons.seconds) +
          ((Cons.curLocale != null) ? (isNotZH ? " min ago" : " 分钟前") : " 分钟前");
    } 
    else if (subTimes < TimeCons.hours) {
      return _fmt(subTimes, TimeCons.minutes) +
          ((Cons.curLocale != null) ? (isNotZH ? " hours ago" : " 小时前") : " 小时前");
    } 
    else if (subTimes < TimeCons.days) {
      return _fmt(subTimes, TimeCons.hours) +
          ((Cons.curLocale != null) ? (isNotZH ? " days ago" : " 天前") : " 天前");
    } 
    else {
      return fmtDateTime(date);
    }
  }

}
