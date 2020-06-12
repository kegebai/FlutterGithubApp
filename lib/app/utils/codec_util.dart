import 'dart:convert';

/// The `compute` of `isolate` requires a static method.
class CodecUtil {
  static List<dynamic> decodeList(String data) {
    return json.decode(data);
  }

  static Map<String, dynamic> decodeMap(String data) {
    return json.decode(data);
  }

  static String encodeToString(String data) {
    return json.encode(data);
  }
}