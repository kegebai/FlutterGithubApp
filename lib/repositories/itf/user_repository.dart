import 'package:flutter/material.dart';

import '../../models/user.dart';

abstract class UserRepository {
  Future<bool> isAuthed();
  
  Future<void> oAuth(BuildContext ctx);


  Future<bool> isSignedIn();

  Future<void> signIn(BuildContext ctx, String email, String pwd);

  Future<void> signOut(BuildContext ctx);

  Future<void> signUp(BuildContext ctx, String email, String pwd);

  Future<User> getLocalUserInfo();
}