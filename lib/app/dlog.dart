///
/// File: dlog.dart
///
/// Created by kege <kegebai@gmail.com> on 2020-04-16
/// Copyright © 2020 BLH .inc
///
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'package:flutter/foundation.dart';

import './utils/datetime_utils.dart';

/// General printing method class.
class Dlog {
  /// Print in sections when the content's length than 800.
  ///
  /// Does not print in Release mode.
  static log(object) {
    if (object != null) {
      var content = object.toString();

      if (content.isEmpty) {
        debugPrint('${DateTimeUtils.nowIso()}');
        return;
      }

      while (content.length > 800) {
        debugPrint('${DateTimeUtils.nowIso()} ${content.substring(0, 800)}');
        content = content.substring(800, content.length);
      }

      if (content.isNotEmpty) debugPrint('${DateTimeUtils.nowIso()} $content');
    }
  }
}
