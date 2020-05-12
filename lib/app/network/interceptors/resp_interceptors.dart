///
/// File: resp_interceptors.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-02
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'package:dio/dio.dart';

import '../net_req_res_data.dart';
import '../resp_code.dart';

class RespInterceptors extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) async {
    RequestOptions options = response.request;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if (header != null && header.toString().contains('text')) {
        value = new NetworkRequestResultData(
          response.data, 
          true, 
          RespCode.SUCCESS
        );
      }
      else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new NetworkRequestResultData(
          response.data, 
          true, 
          RespCode.SUCCESS,
          headers: response.headers,
        );
      }

    } catch (e) {
      print(e.toString() + options.path);
      value = NetworkRequestResultData(
        response.data,
        false,
        response.statusCode,
        headers: response.headers,
      );
    }

    return value;
  }
}