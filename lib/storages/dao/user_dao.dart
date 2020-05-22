import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/conf.dart';
import '../../app/dlog.dart';
import '../../app/ignore_conf.dart';
import '../../app/network/addr.dart';
import '../../app/network/http_service.dart';
import '../../blocs/oauth/oauth_bloc.dart';
import '../../blocs/oauth/oauth_event.dart';
import '../../db/user_db_provider.dart';
import '../../models/user.dart';
import '../../storages/dao/dao_res.dart';
import '../../storages/local_storage.dart';

class UserDao {
  final LocalStorage storage;

  UserDao(this.storage);

  ///
  Future<DaoRes> auth(context, String code) async {
    HttpService.instance.cancleAuth();

    var url = "https://github.com/login/oauth/access_token?"
        "client_id=${IgnoreConf.CLIENT_ID}"
        "&client_secret=${IgnoreConf.CLIENT_SECRET}"
        "&code=$code";

    var res = await HttpService.instance.fetch(url, null, null, null);
    var resData;
    if (res != null && res.result) {
      Dlog.log('### ${res.data}');
      var uri = Uri.parse('casp://oauth?' + res.data);
      var tempToken = uri.queryParameters['access_token'];
      var token = 'token' + tempToken;
      await storage.save(Conf.TOKEN_KEY, token);

      resData = await getUserInfo(null);
      Dlog.log("# User Result " + resData.result.toString());
      Dlog.log(resData.data);
      Dlog.log(res.data.toString());
      //
      BlocProvider.of<OAuthBloc>(context).add(LoggedIn());
    }
    return new DaoRes(resData, res.result);
  }

  ///
  Future<DaoRes> logIn(context, String userName, String pwd) async {
    Dlog.log(userName);
    Dlog.log(pwd);
    var bytes = utf8.encode(userName + ':' + pwd);
    var base64Str = base64.encode(bytes);
    Dlog.log(base64Str);
    await storage.save(Conf.USER_NAME_KEY, userName);
    await storage.save(Conf.USER_BASIC_CODE, base64Str);

    var params = <String, dynamic>{
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": IgnoreConf.CLIENT_ID,
      "client_secret": IgnoreConf.CLIENT_SECRET,
    };
    //
    HttpService.instance.cancleAuth();

    var res = await HttpService.instance.fetch(
      Addr.authorization(),
      json.encode(params),
      null,
      new Options(method: 'post'),
    );

    var resData;
    if (res != null && res.result) {
      await storage.save(Conf.USER_PW_KEY, pwd);

      resData = await getUserInfo(null);
      Dlog.log("# User Result " + resData.result.toString());
      Dlog.log(resData.data);
      Dlog.log(res.data.toString());
      //
      BlocProvider.of<OAuthBloc>(context).add(LoggedIn());
    }
    return new DaoRes(resData, res.result);
  }

  /// Clear all informations in the local of user when logout.
  Future<void> logOut(context) async {
    HttpService.instance.cancleAuth();
    storage.remove(Conf.USER_INFO_KEY);
    //
    BlocProvider.of<OAuthBloc>(context).add(LoggedOut());
  }

  ///
  Future<DaoRes> getUserInfo(String userName, {bool isNeedDB = false}) async {
    var provider = new UserDBProvider();

    next() async {
      var url = (userName == null || userName.isEmpty) ? Addr.user() : Addr.users(userName);
      var res = await HttpService.instance.fetch(url, null, null, null);

      if (res != null && res.result) {
        var starred = '-';
        if (res.data['type'] != 'Organization') {
          var countRes = await getUserStaredCount(res.data['login']);
          if (countRes.result) {
            starred = countRes.data;
          }
        }
        var user = User.fromJson(res.data);
        user.starred = starred;

        if (userName == null || userName.isEmpty) {
          await storage.save(Conf.USER_INFO_KEY, json.encode(user.toJson()));
        }
        if (isNeedDB) {
          provider.insert(userName, json.encode(user.toJson()));
        }
        return new DaoRes(user, true);
      }
      return new DaoRes(res.data, false);
    }

    //
    if (isNeedDB) {
      var user = await provider.getUserInfo(userName);
      return user == null ? await next() : new DaoRes(user, true, next: next);
    }
    return await next();
  }

  ///
  Future<DaoRes> getLocalUserInfo() async {
    var res = await storage.get(Conf.USER_INFO_KEY);
    if (res == null) {
      return new DaoRes(null, false);
    }
    var user = User.fromJson(json.decode(res));
    return new DaoRes(user, true);
  }

  ///
  Future<DaoRes> getUserStaredCount(String userName) async {
    var res = await HttpService.instance.fetch(
      Addr.userStar(userName, null) + '&per_page=1', 
      null, 
      null, 
      null
    );
    
    if (res != null && res.result && res.headers != null) {
      try {
        List<String> link = res.headers['link'];
        if (link.isNotEmpty) {
          int startIndex = link[0].lastIndexOf('page=') + 5;
          int endIndex = link[0].lastIndexOf('>');

          if (startIndex >= 0 && endIndex >= 0) {
            var count = link.first.substring(startIndex, endIndex);
            return new DaoRes(count, true);
          }
        }
      } catch (e) {
        Dlog.log(e);
      }
    }
    return new DaoRes(null, false);
  }
}
