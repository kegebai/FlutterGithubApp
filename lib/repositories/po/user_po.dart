import 'package:equatable/equatable.dart';

class UserPo extends Equatable {
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

  UserPo(
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
      this.two_factor_authentication);

  factory UserPo.fromJson(Map<String, dynamic> json) {
    return UserPo(
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

  @override
  List<Object> get props => [id, login];

  @override
  String toString() {
    return "UserPo{ id: $id, login: $login }";
  }
}
