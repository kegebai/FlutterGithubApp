import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import '../net_req_res_data.dart';
import '../resp_code.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  ErrorInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    var connecResult = await (new Connectivity().checkConnectivity());
    if (connecResult == ConnectivityResult.none) {
      return _dio.resolve(
        new NetworkRequestResultData(
          RespCode.respError(RespCode.NETWORK_ERROR, '', false),
          false,
          RespCode.NETWORK_ERROR,
        )
      );
    }
    return options;
  } 
}