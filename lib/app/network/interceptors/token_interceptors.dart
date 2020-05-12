///
/// File: token_interceptors.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-01
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'package:dio/dio.dart';

import '../../conf.dart';
import '../../utils/sp_utils.dart';
import '../graphql/graphql_service.dart';

class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    if (_token == null) {
      var authCode = await authorize();
      if (authCode != null) {
        _token = authCode;
        GraphQLService.init(token: _token);
      }
    }
    options.headers['Authorization'] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var respJson = response.data;
      if (response.statusCode == 201 && respJson['token'] != null) {
        _token = 'token ' + respJson['token'];
        //* Save the token to local
        await SPUtils.save(Conf.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  /// Authorizetion
  authorize() async {
    String token = await SPUtils.get(Conf.TOKEN_KEY);
    if (token == null) {
      String basic = await SPUtils.get(Conf.USER_BASIC_CODE);
      if (basic == null) {
        // todo Remind users to login.

      } else {
        // Use the `basic` to get the token.
        // If get the settings, and return the token
        return 'Basic $basic';
      }
    }
    this._token = token;
    return token;
  }

  /// Cancel authorizetion
  deauthorize() {
    this._token = null;
    //! Delete the local token
    SPUtils.remove(Conf.TOKEN_KEY);
    GraphQLService.release();
  }   
}