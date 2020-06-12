import 'package:flutter/material.dart';

import '../models/user.dart';

abstract class UserRepository {
  Future<bool> isAuthed();
  
  Future<void> auth(BuildContext ctx);


  Future<bool> isSignedIn();

  Future<void> signIn(BuildContext ctx, String username, String password);

  Future<void> signOut(BuildContext ctx);

  Future<void> signUp(BuildContext ctx, String username, String password);

  Future<User> loadUserInfo();
}