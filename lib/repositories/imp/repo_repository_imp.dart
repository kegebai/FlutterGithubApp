import '../../models/repo.dart';
import '../../repositories/imp/dao/repo_dao.dart';
import '../../repositories/repo_repository.dart';

class RepoRepositoryImp implements RepoRepository {
  final RepoDao _reposDao = new RepoDao();

  @override
  Future<List<Repo>> getRepos(String user, int page) async {
    var res = await _reposDao.getRepos(user, page, null);
    return res.data;
  }
  
}