import 'package:equatable/equatable.dart';

import '../../models/repo.dart';

class RepoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends RepoListEvent {
  @override
  String toString() => "Fetch {}";
}

class Refresh extends RepoListEvent {
  @override
  String toString() => "Refresh {}";
}

class LoadMore extends RepoListEvent {
  int page;
  LoadMore(this.page);

  @override
  List<Object> get props => [page];

  @override
  String toString() => "LoadMore { page: $page }";
}