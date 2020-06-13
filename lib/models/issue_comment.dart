import 'package:equatable/equatable.dart';

import './user.dart';

class IssueComment extends Equatable {
  int id;
  User user;
  DateTime created_at;
  DateTime updated_at;
  String author_association;
  String body;
  String body_html;
  String event;
  String html_url;

  IssueComment(
    this.id,
    this.user,
    this.created_at,
    this.updated_at,
    this.author_association,
    this.body,
    this.body_html,
    this.event,
    this.html_url,
  );

  factory IssueComment.fromJson(Map<String, dynamic> json) {
    return IssueComment(
      json['id'] as int,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['author_association'] as String,
      json['body'] as String,
      json['body_html'] as String,
      json['event'] as String,
      json['html_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'id': this.id,
      'user': this.user,
      'created_at': this.created_at?.toIso8601String(),
      'updated_at': this.updated_at?.toIso8601String(),
      'author_association': this.author_association,
      'body': this.body,
      'body_html': this.body_html,
      'event': this.event,
      'html_url': this.html_url,
    };
  }

  @override
  List<Object> get props => [id];
}
