import 'package:equatable/equatable.dart';

import '../repositories/po/user_po.dart';

class User extends Equatable {
  String login;
  int id;
  String node_id;
  String avatar_url;
  String gravatar_id;
  String url;
  String html_url;
  String followers_url;
  String following_url;
  String gists_url;
  String starred_url;
  String subscriptions_url;
  String organizations_url;
  String repos_url;
  String events_url;
  String received_events_url;
  String type;
  bool site_admin;
  String name;
  String company;
  String blog;
  String location;
  String email;
  String starred;
  String bio;
  int public_repos;
  int public_gists;
  int followers;
  int following;
  DateTime created_at;
  DateTime updated_at;
  int private_gists;
  int total_private_repos;
  int owned_private_repos;
  int disk_usage;
  int collaborators;
  bool two_factor_authentication;

  User(
    this.login,
    this.id,
    this.node_id,
    this.avatar_url,
    this.gravatar_id,
    this.url,
    this.html_url,
    this.followers_url,
    this.following_url,
    this.gists_url,
    this.starred_url,
    this.subscriptions_url,
    this.organizations_url,
    this.repos_url,
    this.events_url,
    this.received_events_url,
    this.type,
    this.site_admin,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.starred,
    this.bio,
    this.public_repos,
    this.public_gists,
    this.followers,
    this.following,
    this.created_at,
    this.updated_at,
    this.private_gists,
    this.total_private_repos,
    this.owned_private_repos,
    this.disk_usage,
    this.collaborators,
    this.two_factor_authentication,
  );

  User.empty();

  factory User.fromPo(UserPo po) {
    return User(
      po.login,
      po.id,
      po.node_id,
      po.avatar_url,
      po.gravatar_id,
      po.url,
      po.html_url,
      po.followers_url,
      po.following_url,
      po.gists_url,
      po.starred_url,
      po.subscriptions_url,
      po.organizations_url,
      po.repos_url,
      po.events_url,
      po.received_events_url,
      po.type,
      po.site_admin,
      po.name,
      po.company,
      po.blog,
      po.location,
      po.email,
      po.starred,
      po.bio,
      po.public_repos,
      po.public_gists,
      po.followers,
      po.following,
      po.created_at,
      po.updated_at,
      po.private_gists,
      po.total_private_repos,
      po.owned_private_repos,
      po.disk_usage,
      po.collaborators,
      po.two_factor_authentication,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['login'] as String,
      json['id'] as int,
      json['node_id'] as String,
      json['avatar_url'] as String,
      json['gravatar_id'] as String,
      json['url'] as String,
      json['html_url'] as String,
      json['followers_url'] as String,
      json['following_url'] as String,
      json['gists_url'] as String,
      json['starred_url'] as String,
      json['subscriptions_url'] as String,
      json['organizations_url'] as String,
      json['repos_url'] as String,
      json['events_url'] as String,
      json['received_events_url'] as String,
      json['type'] as String,
      json['site_admin'] as bool,
      json['name'] as String,
      json['company'] as String,
      json['blog'] as String,
      json['location'] as String,
      json['email'] as String,
      json['starred'] as String,
      json['bio'] as String,
      json['public_repos'] as int,
      json['public_gists'] as int,
      json['followers'] as int,
      json['following'] as int,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['private_gists'] as int,
      json['total_private_repos'] as int,
      json['owned_private_repos'] as int,
      json['disk_usage'] as int,
      json['collaborators'] as int,
      json['two_factor_authentication'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'login': this.login,
      'id': this.id,
      'node_id': this.node_id,
      'avatar_url': this.avatar_url,
      'gravatar_id': this.gravatar_id,
      'url': this.url,
      'html_url': this.html_url,
      'followers_url': this.followers_url,
      'following_url': this.following_url,
      'gists_url': this.gists_url,
      'starred_url': this.starred_url,
      'subscriptions_url': this.subscriptions_url,
      'organizations_url': this.organizations_url,
      'repos_url': this.repos_url,
      'events_url': this.events_url,
      'received_events_url': this.received_events_url,
      'type': this.type,
      'site_admin': this.site_admin,
      'name': this.name,
      'company': this.company,
      'blog': this.blog,
      'location': this.location,
      'email': this.email,
      'starred': this.starred,
      'bio': this.bio,
      'public_repos': this.public_repos,
      'public_gists': this.public_gists,
      'followers': this.followers,
      'following': this.following,
      'created_at': this.created_at?.toIso8601String(),
      'updated_at': this.updated_at?.toIso8601String(),
      'private_gists': this.private_gists,
      'total_private_repos': this.total_private_repos,
      'owned_private_repos': this.owned_private_repos,
      'disk_usage': this.disk_usage,
      'collaborators': this.collaborators,
      'two_factor_authentication': this.two_factor_authentication,
    };
  }

  @override
  List<Object> get props => [id];
}
