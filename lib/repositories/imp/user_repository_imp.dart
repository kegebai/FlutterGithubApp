import 'package:flutter/material.dart';

import '../../app/conf.dart';
import './../user_repository.dart';
import '../../models/user.dart';
import '../imp/dao/user_dao.dart';
import '../../app/local_storage.dart';

class UserRepositoryImp implements UserRepository {
  final LocalStorage storage;
  UserDao _userDao;

  UserRepositoryImp(this.storage) {
    _userDao = UserDao(storage);
  }

  @override
  Future<bool> isAuthed() async {
    var token = await storage.get(Conf.TOKEN_KEY);
    return token != null;
  }

  @override
  Future<void> auth(BuildContext ctx) async {
    var code = await storage.get(Conf.USER_BASIC_CODE);
    await _userDao.auth(ctx, code);
  }

  @override
  Future<bool> isSignedIn() async {
    var res = await _userDao.getUserInfo();
    return (res != null && res.result);
  }

  @override
  Future<void> signIn(BuildContext ctx, String username, String password) async {
    await _userDao.logIn(ctx, username, password);
  }

  @override
  Future<void> signOut(BuildContext ctx) async {
    await _userDao.logOut(ctx);
  }

  @override
  Future<void> signUp(BuildContext ctx, String username, String password) async {
    return null;
  }

  @override
  Future<User> loadUserInfo() async {
    var res = await _userDao.getUserInfo();
    return res.data;
  }
}