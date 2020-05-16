import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app/conf.dart';
import './../itf/user_repository.dart';
import '../../models/user.dart';
import '../../storages/dao/user_dao.dart';
import '../../storages/local_storage.dart';

class UserRepositoryImp implements UserRepository {
  final LocalStorage storage;
  UserDao _dao;

  UserRepositoryImp(this.storage) {
    _dao = UserDao(storage);
  }

  @override
  Future<bool> isAuthed() async {
    var token = await storage.get(Conf.TOKEN_KEY);
    return token != null;
  }

  @override
  Future<void> oAuth(BuildContext ctx) async {
    var code = await storage.get(Conf.USER_BASIC_CODE);
    await _dao.oAuth(ctx, code);
  }

  @override
  Future<bool> isSignedIn() async {
    var res = await _dao.getLocalUserInfo();
    return (res != null && res.result);
  }

  @override
  Future<void> signIn(BuildContext ctx, String email, String pwd) async {
    await _dao.login(ctx, email, pwd);
  }

  @override
  Future<void> signOut(BuildContext ctx) async {
    await _dao.logout(ctx);
  }

  @override
  Future<void> signUp(BuildContext ctx, String email, String pwd) async {
    return null;
  }

  @override
  Future<User> getLocalUserInfo() async {
    var res = await _dao.getLocalUserInfo();
    return res.data;
  }
}