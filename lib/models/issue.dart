import 'package:equatable/equatable.dart';

import './user.dart';

class Issue extends Equatable {
  int id;
  int number;
  String title;
  String state;
  bool locked;
  int comments;
  DateTime created_at;
  DateTime updated_at;
  DateTime closed_at;
  String body;
  String body_html;
  User user;
  String repository_url;
  String html_url;
  User closed_by;

  Issue(
    this.id,
    this.number,
    this.title,
    this.state,
    this.locked,
    this.comments,
    this.created_at,
    this.updated_at,
    this.closed_at,
    this.body,
    this.body_html,
    this.user,
    this.repository_url,
    this.html_url,
    this.closed_by,
  );

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
    json['id'] as int,
    json['number'] as int,
    json['title'] as String,
    json['state'] as String,
    json['locked'] as bool,
    json['comments'] as int,
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    json['closed_at'] == null
        ? null
        : DateTime.parse(json['closed_at'] as String),
    json['body'] as String,
    json['body_html'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['repository_url'] as String,
    json['html_url'] as String,
    json['closed_by'] == null
        ? null
        : User.fromJson(json['closed_by'] as Map<String, dynamic>),
  );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'id': this.id,
      'number': this.number,
      'title': this.title,
      'state': this.state,
      'locked': this.locked,
      'comments': this.comments,
      'created_at': this.created_at?.toIso8601String(),
      'updated_at': this.updated_at?.toIso8601String(),
      'closed_at': this.closed_at?.toIso8601String(),
      'body': this.body,
      'body_html': this.body_html,
      'user': this.user,
      'repository_url': this.repository_url,
      'html_url': this.html_url,
      'closed_by': this.closed_by,
    };
  }
  
  @override
  List<Object> get props => [id];
}