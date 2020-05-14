import '../../models/user.dart';

abstract class UserRepository {

  Future<void> oAuth(bloc);

  Future<void> signIn(String email, String pwd, bloc);

  Future<void> signOut(bloc);

  // Future<void> signUp(String email, String pwd);

  Future<bool> isSignedIn();

  Future<User> getUserInfo();
}