import 'package:equatable/equatable.dart';

import './user.dart';

class Repo extends Equatable {
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

  Repo();

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo()
      ..id = json['id'] as num
      ..name = json['name'] as String
      ..full_name = json['full_name'] as String
      ..owner = json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>)
      ..parent = json['parent'] == null
          ? null
          : Repo.fromJson(json['parent'] as Map<String, dynamic>)
      ..private = json['private'] as bool
      ..html_url = json['html_url'] as String
      ..description = json['description'] as String
      ..fork = json['fork'] as bool
      ..homepage = json['homepage'] as String
      ..language = json['language'] as String
      ..forks_count = json['forks_count'] as num
      ..stargazers_count = json['stargazers_count'] as num
      ..watchers_count = json['watchers_count'] as num
      ..size = json['size'] as num
      ..default_branch = json['default_branch'] as String
      ..open_issues_count = json['open_issues_count'] as num
      ..topics = json['topics'] as List
      ..has_issues = json['has_issues'] as bool
      ..has_projects = json['has_projects'] as bool
      ..has_wiki = json['has_wiki'] as bool
      ..has_pages = json['has_pages'] as bool
      ..has_downloads = json['has_downloads'] as bool
      ..pushed_at = json['pushed_at'] as String
      ..created_at = json['created_at'] as String
      ..updated_at = json['updated_at'] as String
      ..permissions = json['permissions'] as Map<String, dynamic>
      ..subscribers_count = json['subscribers_count'] as num
      ..license = json['license'] as Map<String, dynamic>;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'name': this.name,
        'full_name': this.full_name,
        'owner': this.owner,
        'parent': this.parent,
        'private': this.private,
        'html_url': this.html_url,
        'description': this.description,
        'fork': this.fork,
        'homepage': this.homepage,
        'language': this.language,
        'forks_count': this.forks_count,
        'stargazers_count': this.stargazers_count,
        'watchers_count': this.watchers_count,
        'size': this.size,
        'default_branch': this.default_branch,
        'open_issues_count': this.open_issues_count,
        'topics': this.topics,
        'has_issues': this.has_issues,
        'has_projects': this.has_projects,
        'has_wiki': this.has_wiki,
        'has_pages': this.has_pages,
        'has_downloads': this.has_downloads,
        'pushed_at': this.pushed_at,
        'created_at': this.created_at,
        'updated_at': this.updated_at,
        'permissions': this.permissions,
        'subscribers_count': this.subscribers_count,
        'license': this.license,
      };

  @override
  List<Object> get props => [id];
}

class License extends Equatable {
  String name;
  String key;
  String url;
  // String spdx_id;
  // String node_id;

  License(this.name, this.key, this.url);

  @override
  List<Object> get props => [name];
}

class Permissions extends Equatable {
  bool admin;
  bool push;
  bool pull;

  Permissions(
    this.admin,
    this.push,
    this.pull,
  );

  @override
  List<Object> get props => [admin];
}
