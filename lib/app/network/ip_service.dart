import '../cons.dart';

class IpService {

  /// Authorize `post`
  static authorization() => '${IpCons.apiHost}authorizations';

  /// User's info `get`
  static users(String userName) => '${IpCons.apiHost}users/$userName';
  
  /// My user info `get`
  static user() => '${IpCons.apiHost}user';

  /// User's star `get`
  static userStar(String userName, String sort) {
    sort ??= 'updated';
    return "${IpCons.apiHost}users/$userName/starred?sort=$sort";
  }

  /// My star `get`
  static star(String sort) {
    sort ??= 'updated';
    return "${IpCons.apiHost}users/starred?sort=$sort";
  }


}