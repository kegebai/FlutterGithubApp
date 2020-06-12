import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/dlog.dart';
import '../../models/repo.dart';
import './home_event.dart';
import './home_state.dart';
import '../../repositories/repo_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RepoRepository repository;

  HomeBloc({@required this.repository});

  @override
  HomeState get initialState => Loading();

  @override
  Stream<Transition<HomeEvent, HomeState>> transformEvents(
    Stream<HomeEvent> events, 
    transitionFn
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(microseconds: 500)), 
      transitionFn
    );
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // if (event is PullDown2Refresh) {
    //   yield* _mapRefreshToState(event);
    // } else if (event is PullUp2LoadMore) {
    //   yield* _mapLoadMoreToState(event);
    // }
    yield* _map(event);
  }

  Stream<HomeState> _map(HomeEvent event) async* {
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

  bool _hasReachedMax(HomeState state) => state is Loaded && state.hasReachedMax;

  Stream<HomeState> _mapRefreshToState(Refresh event) async* {
    try {
      int page = 1;
      List<Repo> list = await repository.getRepos(null, page);

      yield Loaded(repos: list);
    } catch (e) {
      Dlog.log(e);
      yield LoadFailed();
    }
  }

  Stream<HomeState> _mapLoadMoreToState(LoadMore event) async* {
    try {
      List<Repo> more = await repository.getRepos(null, event.page++);

      yield Loaded(repos: more);
    } catch (e) {
      Dlog.log(e);
      yield LoadFailed();
    }
  }
}