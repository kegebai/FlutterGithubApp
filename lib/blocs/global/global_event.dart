import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class LoadApp extends GlobalEvent {}

class SwitchFontFamily extends GlobalEvent {
  final String fontFamily;

  SwitchFontFamily(this.fontFamily);

  @override
  List<Object> get props => [fontFamily];

  @override
  String toString() => 'SwitchFontFamily { fontFamily: $fontFamily }'; 
}

class SwitchThemeColor extends GlobalEvent {
  final MaterialColor color;

  SwitchThemeColor(this.color);

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'SwitchThemeColor { color: $color }';
}

class SwitchLanguage extends GlobalEvent {
  final String language;

  SwitchLanguage(this.language);

  @override
  List<Object> get props => [language];

  @override
  String toString() => 'SwitchLanguage { language: $language }'; 
}
