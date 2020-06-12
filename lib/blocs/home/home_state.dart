import 'package:equatable/equatable.dart';

import '../../models/repo.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class Loading extends HomeState {}

class Loaded extends HomeState {
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

class LoadFailed extends HomeState {}
