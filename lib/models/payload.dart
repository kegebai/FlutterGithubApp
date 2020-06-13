import 'package:equatable/equatable.dart';

import './issue.dart';
import './issue_comment.dart';
import './push_event.dart';
import './release.dart';

class Payload extends Equatable {
  int push_id;
  int size;
  int distinct_size;
  String ref;
  String head;
  String before;

  List<PushEvent> commits;

  String action;
  String ref_type;
  String master_branch;
  String description;
  String pusher_type;

  Release release;
  Issue issue;
  IssueComment comment;

  Payload(
    this.push_id,
    this.size,
    this.distinct_size,
    this.ref,
    this.head,
    this.before,
    this.commits,
    this.action,
    this.ref_type,
    this.master_branch,
    this.description,
    this.pusher_type,
    this.release,
    this.issue,
    this.comment,
  );

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      json['push_id'] as int,
      json['size'] as int,
      json['distinct_size'] as int,
      json['ref'] as String,
      json['head'] as String,
      json['before'] as String,
      (json['commits'] as List)
          ?.map((e) => e == null ? null : PushEvent.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['action'] as String,
      json['ref_type'] as String,
      json['master_branch'] as String,
      json['description'] as String,
      json['pusher_type'] as String,
      json['release'] == null
          ? null
          : Release.fromJson(json['release'] as Map<String, dynamic>),
      json['issue'] == null
          ? null
          : Issue.fromJson(json['issue'] as Map<String, dynamic>),
      json['comment'] == null
          ? null
          : IssueComment.fromJson(json['comment'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'push_id': this.push_id,
      'size': this.size,
      'distinct_size': this.distinct_size,
      'ref': this.ref,
      'head': this.head,
      'before': this.before,
      'commits': this.commits,
      'action': this.action,
      'ref_type': this.ref_type,
      'master_branch': this.master_branch,
      'description': this.description,
      'pusher_type': this.pusher_type,
      'release': this.release,
      'issue': this.issue,
      'comment': this.comment,
    };
  }

  @override
  List<Object> get props => [push_id];
}
