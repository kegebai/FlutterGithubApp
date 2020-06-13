import 'package:equatable/equatable.dart';

import './user.dart';

class Asset extends Equatable {
  int id;
  String name;
  String label;
  User uploader;
  String content_type;
  String state;
  int size;
  int downloadCout;
  DateTime created_at;
  DateTime updated_at;
  String browser_download_url;

  Asset(
    this.id,
    this.name,
    this.label,
    this.uploader,
    this.content_type,
    this.state,
    this.size,
    this.downloadCout,
    this.created_at,
    this.updated_at,
    this.browser_download_url,
  );

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      json['id'] as int,
      json['name'] as String,
      json['label'] as String,
      json['uploader'] == null
          ? null
          : User.fromJson(json['uploader'] as Map<String, dynamic>),
      json['content_type'] as String,
      json['state'] as String,
      json['size'] as int,
      json['downloadCout'] as int,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['browser_download_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'id': this.id,
      'name': this.name,
      'label': this.label,
      'uploader': this.uploader,
      'content_type': this.content_type,
      'state': this.state,
      'size': this.size,
      'downloadCout': this.downloadCout,
      'created_at': this.created_at?.toIso8601String(),
      'updated_at': this.updated_at?.toIso8601String(),
      'browser_download_url': this.browser_download_url,
    };
  }

  @override
  List<Object> get props => [id];
}
