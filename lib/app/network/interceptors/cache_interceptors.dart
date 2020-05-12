import 'package:dio/dio.dart';

import '../cache/network_cache.dart';

class CacheInterceptors extends InterceptorsWrapper {
  final NetworkCache _cache;
  CacheInterceptors(this._cache);

  @override
  onRequest(RequestOptions options) async => await _cache.onRequest(options);

  @override
  onResponse(Response response) async => await _cache.onResponse(response);
}
