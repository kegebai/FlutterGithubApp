import '../../models/repo.dart';
import '../../repositories/dao/repo_dao.dart';
import '../../repositories/repo_repository.dart';

class RepoRepositoryImp implements RepoRepository {
  final RepoDao _repoDao = new RepoDao();

  @override
  Future<List<Repo>> getRepos(String user, int page) async {
    var res = await _repoDao.getRepos(user, page, null);
    return res.data;
  }
  
}