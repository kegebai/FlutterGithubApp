import 'package:equatable/equatable.dart';

import './user.dart';

class CommitComment extends Equatable {
  int id;
  String body;
  String path;
  int position;
  int line;
  String commit_id;
  DateTime created_at;
  DateTime updated_at;
  String html_url;
  String url;
  User user;

  CommitComment(
    this.id,
    this.body,
    this.path,
    this.position,
    this.line,
    this.commit_id,
    this.created_at,
    this.updated_at,
    this.html_url,
    this.url,
    this.user,
  );

  factory CommitComment.fromJson(Map<String, dynamic> json) {
    return CommitComment(
      json['id'] as int,
      json['body'] as String,
      json['path'] as String,
      json['position'] as int,
      json['line'] as int,
      json['commit_id'] as String,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['html_url'] as String,
      json['url'] as String,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'id': this.id,
      'body': this.body,
      'path': this.path,
      'position': this.position,
      'line': this.line,
      'commit_id': this.commit_id,
      'created_at': this.created_at?.toIso8601String(),
      'updated_at': this.updated_at?.toIso8601String(),
      'html_url': this.html_url,
      'url': this.url,
      'user': this.user,
    };
  }

  @override
  List<Object> get props => [id];
}
