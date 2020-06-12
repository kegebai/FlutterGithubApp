import 'package:equatable/equatable.dart';
import 'package:flutter_github_app/models/repo.dart';

class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends HomeEvent {
  @override
  String toString() => "Fetch {}";
}

class Refresh extends HomeEvent {}

class LoadMore extends HomeEvent {
  int page;
  LoadMore(this.page);

  @override
  List<Object> get props => [page];

  @override
  String toString() => "LoadMore{ page: $page }";
}