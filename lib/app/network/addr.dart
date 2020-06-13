import '../cons.dart';

class Addr {

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

  /// User's repos `get`
  static userRepos(String userName, String sort) {
    sort ??= 'pushed';
    return "${IpCons.apiHost}users/$userName/repos?sort=$sort";
  }

  /// My repos `get`
  static repos(String sort) {
    sort ??= 'pushed';
    return "${IpCons.apiHost}user/repos?sort=$sort"; 
  }

  /// Event information received by users `get`
  static receivedEvent(userName) {
    return "${IpCons.apiHost}users/$userName/received_events";
  }

  /// Event information of users `get`
  static event(userName) {
    return "${IpCons.apiHost}users/$userName/events";
  }
}