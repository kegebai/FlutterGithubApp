import 'package:equatable/equatable.dart';

import '../../models/repo.dart';

abstract class RepoListState extends Equatable {
  const RepoListState();

  @override
  List<Object> get props => [];
}

class Loading extends RepoListState {}

class Loaded extends RepoListState {
  final List<Repo> repos;
  final bool hasReachedMax;

  const Loaded({this.repos, this.hasReachedMax});

  Loaded copyWith({List<Repo> repos, bool hasReachedMax}) {
    return Loaded(
      repos: repos ?? this.repos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [repos, hasReachedMax];

  @override
  String toString() =>
      "Loaded { repos: $repos, hasReachedMax: $hasReachedMax }";
}

class LoadFailed extends RepoListState {}
