import 'package:equatable/equatable.dart';

import './user.dart';

class PushEvent extends Equatable {
  String sha;
  User author;
  String message;
  bool distinct;
  String url;

  PushEvent(
    this.sha,
    this.author,
    this.message,
    this.distinct,
    this.url,
  );

  factory PushEvent.fromJson(Map<String, dynamic> json) {
    return PushEvent(
      json['sha'] as String,
      json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      json['message'] as String,
      json['distinct'] as bool,
      json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'sha': this.sha,
      'author': this.author,
      'message': this.message,
      'distinct': this.distinct,
      'url': this.url,
    };
  }

  @override
  List<Object> get props => [];
}
