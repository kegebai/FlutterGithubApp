///
/// File: header_interceptors.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-02
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'package:dio/dio.dart';

class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 30000;
    options.receiveTimeout = 30000;
    return options;
  }  
}