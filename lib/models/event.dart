import 'package:equatable/equatable.dart';

import './payload.dart';
import './repo.dart';
import './user.dart';

class Event extends Equatable {
  String id;
  String type;
  User actor;
  Repo repo;
  User org;
  Payload payload;
  bool public;
  DateTime created_at;

  Event(
    this.id,
    this.type,
    this.actor,
    this.repo,
    this.org,
    this.payload,
    this.public,
    this.created_at,
  );

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      json['id'] as String,
      json['type'] as String,
      json['actor'] == null
          ? null
          : User.fromJson(json['actor'] as Map<String, dynamic>),
      json['repo'] == null
          ? null
          : Repo.fromJson(json['repo'] as Map<String, dynamic>),
      json['org'] == null
          ? null
          : User.fromJson(json['org'] as Map<String, dynamic>),
      json['payload'] == null
          ? null
          : Payload.fromJson(json['payload'] as Map<String, dynamic>),
      json['public'] as bool,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'type': this.type,
      'actor': this.actor,
      'repo': this.repo,
      'org': this.org,
      'payload': this.payload,
      'public': this.public,
      'created_at': this.created_at?.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [id];
}
