import 'dart:convert';

import '../../app/network/addr.dart';
import '../../app/network/http_service.dart';
import '../../app/utils/params_util.dart';
import '../../models/repo.dart';
import '../../repositories/dao/repo_dao.dart';
import '../../repositories/repo_repository.dart';

import '../dao/dao_result.dart';

class RepoRepositoryImp implements RepoRepository {
  @override
  Future<List<Repo>> getRepos(String user, int page) async {
    var res = await _getRepos(user, page, null);
    return res.data;
  }

  Future<DAOResult> _getRepos(String userName, int page, String sort, {
    bool isNeedDB = false,
  }) async {
    RepoDao repoDao = new RepoDao();

    next() async {
      String url = userName == null
          ? Addr.repos(sort)
          : Addr.userRepos(userName, sort) +
              ParamsUtil.transformPage("&", page);

      var res = await HttpService.instance.fetch(url, null, null, null);

      if (res != null && res.result && res.data.length > 0) {
        List<Repo> list = new List();
        var data = res.data;
        if (data == null || data.length == 0) {
          return new DAOResult(null, false);
        }
        for (var item in data) {
          list.add(Repo.fromJson(item));
        }
        if (isNeedDB) {
          repoDao.addRepo(userName, json.encode(data));
        }
        return new DAOResult(list, true);
      }
      return new DAOResult(null, false);
    }

    if (isNeedDB) {
      List<Repo> list = await repoDao.getRepos(userName);
      if (list == null || list.isEmpty) {
        return await next();
      }
      return new DAOResult(list, true, next: next);
    }
    return await next();
  }
}