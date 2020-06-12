import 'dart:convert';

import '../../../app/network/addr.dart';
import '../../../app/network/http_service.dart';
import '../../../app/utils/params_util.dart';
import '../../../db/repo_db_provider.dart';
import '../../../models/repo.dart';
import './dao_result.dart';

class RepoDao {
  Future<DAOResult> getRepos(String username, int page, String sort,
      {bool isNeedDB = false}) async {
    RepoDBProvider provider = new RepoDBProvider();

    next() async {
      String url = username == null
          ? Addr.repos(sort)
          : Addr.userRepos(username, sort) +
              ParamsUtil.transformPage("&", page);
      
      var res = await HttpService.instance.fetch(url, null, null, null);

      if (res != null && res.result && res.data.length > 0) {
        List<Repo> list = new List();
        var items = res.data;
        if (items == null || items.length == 0) {
          return new DAOResult(null, false);
        }
        for (var item in items) {
          list.add(Repo.fromJson(item));
        }
        if (isNeedDB) {
          provider.insert(username, json.encode(items));
        }
        return new DAOResult(list, true);
      }
      return new DAOResult(null, false);
    }

    if (isNeedDB) {
      List<Repo> list = await provider.getRepos(username);
      if (list.isEmpty) {
        return await next();
      }
      return new DAOResult(list, true, next: next);
    }
    return await next();
  }
}
