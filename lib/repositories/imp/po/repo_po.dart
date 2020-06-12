import 'package:equatable/equatable.dart';

import '../../../models/repo.dart';
import '../../../models/user.dart';

class RepoPo extends Equatable {
  num id;
  String name;
  String full_name;
  User owner;
  Repo parent;
  bool private;
  String html_url;
  String description;
  bool fork;
  String homepage;
  String language;
  num forks_count;
  num stargazers_count;
  num watchers_count;
  num size;
  String default_branch;
  num open_issues_count;
  List topics;
  bool has_issues;
  bool has_projects;
  bool has_wiki;
  bool has_pages;
  bool has_downloads;
  String pushed_at;
  String created_at;
  String updated_at;
  Map<String, dynamic> permissions;
  num subscribers_count;
  Map<String, dynamic> license;

  RepoPo(
    this.id,
    this.name,
    this.full_name,
    this.owner,
    this.parent,
    this.private,
    this.html_url,
    this.description,
    this.fork,
    this.homepage,
    this.language,
    this.forks_count,
    this.stargazers_count,
    this.watchers_count,
    this.size,
    this.default_branch,
    this.open_issues_count,
    this.topics,
    this.has_issues,
    this.has_projects,
    this.has_wiki,
    this.has_pages,
    this.has_downloads,
    this.pushed_at,
    this.created_at,
    this.updated_at,
    this.permissions,
    this.subscribers_count,
    this.license,
  );

  factory RepoPo.fromJson(Map<String, dynamic> json) {
    return RepoPo(
      json['id'] as num,
      json['name'] as String,
      json['full_name'] as String,
      json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      json['parent'] == null
          ? null
          : Repo.fromJson(json['parent'] as Map<String, dynamic>),
      json['private'] as bool,
      json['html_url'] as String,
      json['description'] as String,
      json['fork'] as bool,
      json['homepage'] as String,
      json['language'] as String,
      json['forks_count'] as num,
      json['stargazers_count'] as num,
      json['watchers_count'] as num,
      json['size'] as num,
      json['default_branch'] as String,
      json['open_issues_count'] as num,
      json['topics'] as List,
      json['has_issues'] as bool,
      json['has_projects'] as bool,
      json['has_wiki'] as bool,
      json['has_pages'] as bool,
      json['has_downloads'] as bool,
      json['pushed_at'] as String,
      json['created_at'] as String,
      json['updated_at'] as String,
      json['permissions'] as Map<String, dynamic>,
      json['subscribers_count'] as num,
      json['license'] as Map<String, dynamic>,
    );
  }

  @override
  List<Object> get props => [id];
}