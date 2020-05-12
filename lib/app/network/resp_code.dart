///
/// File: resp_code.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-01
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
class RespCode {
  /// Network error
  static const NETWORK_ERROR = -1;

  /// Network timeout
  static const NETWORK_TIMEOUT = -2;

  /// The network returns data formatted once
  static const NETWORK_JSON_EXCEPTION = -3;

  /// Github APi Connection refused
  static const GITHUB_API_REFUSED = -4;

  static const SUCCESS = 200;

  static respError(code, message, tip) {
    if (tip) return message;

    var refused = 'Connection refused';
    if (message is String && message.contains(refused)) {
      code = GITHUB_API_REFUSED;
    }
    return message;
  }
}