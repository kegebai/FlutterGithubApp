import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/dlog.dart';
import '../../models/repo.dart';
import './repo_list_event.dart';
import './repo_list_state.dart';
import '../../repositories/repo_repository.dart';

class RepoListBloc extends Bloc<RepoListEvent, RepoListState> {
  final RepoRepository repository;

  RepoListBloc(this.repository);

  @override
  RepoListState get initialState => Loading();

  @override
  Stream<Transition<RepoListEvent, RepoListState>> transformEvents(
    Stream<RepoListEvent> events, 
    transitionFn
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(microseconds: 500)), 
      transitionFn
    );
  }

  @override
  Stream<RepoListState> mapEventToState(RepoListEvent event) async* {
    // if (event is PullDown2Refresh) {
    //   yield* _mapRefreshToState(event);
    // } else if (event is PullUp2LoadMore) {
    //   yield* _mapLoadMoreToState(event);
    // }
    yield* _map(event);
  }

  Stream<RepoListState> _map(RepoListEvent event) async* {
    final _state = state;
    if (event is Fetch && !_hasReachedMax(_state)) {
      try {
        if (_state is Loading) {
          final _repos = await repository.getRepos(null, 1);
          yield Loaded(repos: _repos, hasReachedMax: false);
          return;
        }

        if (_state is Loaded) {
          int page = 1;
          if (_state.repos.length % 20 == 0) {
            page += 1;
          } else {
            page++;
          }
          final _repos = await repository.getRepos(null, page);
          yield _repos.isEmpty
              ? _state.copyWith(hasReachedMax: true)
              : Loaded(repos: _state.repos + _repos, hasReachedMax: false);
        }
      } catch (e) {
        print(e);
        yield LoadFailed();
      }
    }
  }

  bool _hasReachedMax(RepoListState state) => state is Loaded && state.hasReachedMax;

  Stream<RepoListState> _mapRefreshToState(Refresh event) async* {
    try {
      int page = 1;
      List<Repo> list = await repository.getRepos(null, page);

      yield Loaded(repos: list);
    } catch (e) {
      Dlog.log(e);
      yield LoadFailed();
    }
  }

  Stream<RepoListState> _mapLoadMoreToState(LoadMore event) async* {
    try {
      List<Repo> more = await repository.getRepos(null, event.page++);

      yield Loaded(repos: more);
    } catch (e) {
      Dlog.log(e);
      yield LoadFailed();
    }
  }
}