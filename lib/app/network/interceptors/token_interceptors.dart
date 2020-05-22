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
import 'package:flutter/material.dart';

import '../../dlog.dart';
import '../../conf.dart';
import '../graphql/graphql_service.dart';
import '../../../storages/local_storage.dart';

class TokenInterceptors extends InterceptorsWrapper {
  final LocalStorage storage;
  String _token;

  TokenInterceptors({@required this.storage});

  @override
  onRequest(RequestOptions options) async {
    if (_token == null) {
      var authCode = await auth();
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
        await storage.save(Conf.TOKEN_KEY, _token);
      }
    } catch (e) {
      Dlog.log(e);
    }
    return response;
  }

  /// Authorizetion
  auth() async {
    String token = await storage.get(Conf.TOKEN_KEY);
    if (token == null) {
      String basic = await storage.get(Conf.USER_BASIC_CODE);
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
  cancleAuth() {
    this._token = null;
    //! Delete the local token
    storage.remove(Conf.TOKEN_KEY);
    GraphQLService.release();
  }   
}