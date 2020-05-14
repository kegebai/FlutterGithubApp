import '../../app/conf.dart';
import './../itf/user_repository.dart';
import '../../models/user.dart';
import '../../storages/dao/user_dao.dart';
import '../../storages/local_storage.dart';

class UserRepositoryImp implements UserRepository {
  final LocalStorage storage;
  UserDao _userDao;

  UserRepositoryImp(this.storage) {
    _userDao = UserDao(storage);
  }

  @override
  Future<void> oAuth(bloc) async {
    var code = await storage.get(Conf.USER_BASIC_CODE);
    await _userDao.oAuth(code, bloc);
  }

  @override
  Future<void> signIn(String email, String pwd, bloc) async {
    await _userDao.login(email, pwd, bloc);
  }

  @override
  Future<void> signOut(bloc) async {
    await _userDao.clear(bloc);
  }

  // @override
  // Future<void> signUp(String email, String pwd) async {
  //   throw UnimplementedError();
  // }

  @override
  Future<bool> isSignedIn() async {
    throw UnimplementedError();
  }

  @override
  Future<User> getUserInfo() async {
    var res = await _userDao.getUserInfo(null);
    return User.fromJson(res.data);
  }
}