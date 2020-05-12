///
/// File: ip_service.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-01
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import '../cons.dart';

class IpService {

  /// Authorize `post`
  static authorization() => '${IpCons.apiHost}authorizations';

  /// User info `get`
  static user(name) => '${IpCons.apiHost}users/$name';
  
  ///
  
}