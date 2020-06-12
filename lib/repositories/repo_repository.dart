import '../models/repo.dart';

abstract class RepoRepository {

  Future<List<Repo>> getRepos(String user, int page);
}