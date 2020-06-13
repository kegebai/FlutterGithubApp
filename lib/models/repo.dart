import 'package:equatable/equatable.dart';

import '../repositories/po/repo_po.dart';
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

  Repo(
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

  Repo.empty();

  factory Repo.fromPo(RepoPo po) {
    return Repo(
      po.id, 
      po.name, 
      po.full_name, 
      po.owner, 
      po.parent, 
      po.private, 
      po.html_url, 
      po.description, 
      po.fork, 
      po.homepage, 
      po.language, 
      po.forks_count, 
      po.stargazers_count, 
      po.watchers_count, 
      po.size, 
      po.default_branch, 
      po.open_issues_count, 
      po.topics, 
      po.has_issues, 
      po.has_projects, 
      po.has_wiki, 
      po.has_pages, 
      po.has_downloads, 
      po.pushed_at, 
      po.created_at, 
      po.updated_at, 
      po.permissions, 
      po.subscribers_count, 
      po.license,
    );
  }

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
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

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
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
  }

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
