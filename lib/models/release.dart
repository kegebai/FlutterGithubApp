import 'package:equatable/equatable.dart';

import './asset.dart';
import './user.dart';

class Release extends Equatable {
  int id;
  String tag_name;
  String target_commitish;
  String name;
  String body;
  String body_html;
  String tarball_url;
  String zipball_url;

  bool draft;
  bool prerelease;
  DateTime created_at;
  DateTime published_at;

  User author;
  List<Asset> assets;

  Release(
    this.id,
    this.tag_name,
    this.target_commitish,
    this.name,
    this.body,
    this.body_html,
    this.tarball_url,
    this.zipball_url,
    this.draft,
    this.prerelease,
    this.created_at,
    this.published_at,
    this.author,
    this.assets,
  );

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      json['id'] as int,
      json['tag_name'] as String,
      json['target_commitish'] as String,
      json['name'] as String,
      json['body'] as String,
      json['body_html'] as String,
      json['tarball_url'] as String,
      json['zipball_url'] as String,
      json['draft'] as bool,
      json['prerelease'] as bool,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      (json['assets'] as List)
          ?.map((e) => e == null ? null : Asset.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'id': this.id,
      'tag_name': this.tag_name,
      'target_commitish': this.target_commitish,
      'name': this.name,
      'body': this.body,
      'body_html': this.body_html,
      'tarball_url': this.tarball_url,
      'zipball_url': this.zipball_url,
      'draft': this.draft,
      'prerelease': this.prerelease,
      'created_at': this.created_at?.toIso8601String(),
      'published_at': this.published_at?.toIso8601String(),
      'author': this.author,
      'assets': this.assets,
    };
  }

  @override
  List<Object> get props => [];
}
