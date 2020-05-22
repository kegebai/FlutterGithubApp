///
/// File: http_service.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-01
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'dart:collection';

import 'package:dio/dio.dart';

import './cache/network_cache.dart';
import './interceptors/cache_interceptors.dart';
import './interceptors/error_interceptors.dart';
import './interceptors/header_interceptors.dart';
import './interceptors/logs_interceptors.dart';
import './interceptors/resp_interceptors.dart';
import './interceptors/token_interceptors.dart';
import './net_req_res_data.dart';
import './resp_code.dart';
import '../../storages/local_storage.dart';

class HttpService {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  final Dio _dio = new Dio();
  
  final TokenInterceptors _tokenInterceptors = 
      new TokenInterceptors(storage: new LocalStorage());
  
  final NetworkCache _cache = new NetworkCache();

  /// Factory
  factory HttpService() => _instance();
  /// Getter
  static HttpService get instance => _instance();

  /// Internal private variable
  static HttpService _ins;
  /// Internal private constructor guaranteed unique initialization  
  static HttpService _instance() {
    if (_ins == null) {
      _ins = new HttpService._internal();
    }
    return _ins;
  }
  /// Internal private constructor
  HttpService._internal() {
    _dio.interceptors.add(new HeaderInterceptors());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(new LogsInterceptors());
    _dio.interceptors.add(new RespInterceptors());

    _dio.interceptors.add(new ErrorInterceptors(_dio));
    // _dio.interceptors.add(new CacheInterceptors(_cache));
  }
  
  /// Initiate a network request
  /// 
  Future<NetworkRequestResultData> fetch(
    url, 
    params, 
    Map<String, dynamic> header, 
    Options options,
    {tip=false}
  ) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) headers.addAll(header);

    if (options != null) {
      options.headers = headers;
    } else {
      options = new Options(method: 'get');
      options.headers = headers;
    }

    // Internal error handling function 
    _error(DioError e) {
      Response eResp;
      eResp = e.response != null ? e.response : new Response(statusCode: 1001);

      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        eResp.statusCode = RespCode.NETWORK_TIMEOUT;
      }
      return new NetworkRequestResultData(
        RespCode.respError(eResp.statusCode, e.message, tip), 
        false, 
        eResp.statusCode,
      );
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: options); 
    } on DioError catch (e) {
      return _error(e);
    }

    if (response.data is DioError) {
      return _error(response.data);
    }
    return response.data;
  }

  /// Authorization
  auth() async => _tokenInterceptors.auth();

  /// Cancel authorization
  cancleAuth() => _tokenInterceptors.cancleAuth();
}
