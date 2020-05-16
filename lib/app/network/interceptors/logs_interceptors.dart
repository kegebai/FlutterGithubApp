import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../dlog.dart';
class LogsInterceptors extends InterceptorsWrapper {
  static var httpResp = new List<Map>();
  static var respHttpUrl = new List<String>();

  static var httpRequ = new List<Map<String, dynamic>>();
  static var requHttpUrl = new List<String>();

  static var httpErrs = new List<Map<String, dynamic>>();
  static var errsHttpUrl = new List<String>();

  static _addData(List list, data) {
    if (list.length > 20) list.removeAt(0);
    list.add(data);
  }

  @override
  onRequest(RequestOptions options) async {
    Dlog.log('Url : ${options.path}');
    Dlog.log('Header : ' + options.headers.toString());
    if (options.data != null) {
      Dlog.log('Parameters : ' + options.data.toString());
    }

    try {
      _addData(requHttpUrl, options.path ?? '');

      var data = Map<String, dynamic>();
      if (options.data is Map) data = options.data;

      var map = {
        'header:' : {
          ...options.headers,
        },
      };
      
      if (options.method == 'POST') map['data'] = data;

      _addData(httpRequ, map);
    } catch (e) {
      Dlog.log(e);
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (response.data != null) {
      Dlog.log('Return parameters : ' + response.toString());
    }

    if (response.data is Map || response.data is List) {
      try {
        var data = Map<String, dynamic>();
        data['data'] = response.data;
        _addData(respHttpUrl, response?.request?.uri?.toString() ?? '');
        _addData(httpResp, data);
      } catch (e) {
        Dlog.log(e);
      }
    } 
    else if (response.data is String) {
      try {
        var data = Map<String, dynamic>();
        data['data'] = response.data;
        _addData(respHttpUrl, response?.request?.uri.toString() ?? '');
        _addData(httpResp, data); 
      } catch (e) {
        Dlog.log(e);
      }
    } 
    else if (response.data != null) {
      try {
        String data = response.data.toJson();
        _addData(respHttpUrl, response?.request?.uri.toString() ?? '');
        _addData(httpResp, json.decode(data)); 
      } catch (e) {
        Dlog.log(e);
      }
    }
    return response;
  }

  @override
  onError(DioError err) async {
    Dlog.log('Request Exception : ' + err.toString());
    Dlog.log('Exception Info : ' + (err.response?.toString() ?? ''));

    try {
      _addData(errsHttpUrl, err.request.path ?? 'null');
      var errors = Map<String, dynamic>();
      errors['error'] = err.message;
      _addData(httpErrs, errors);
    } catch (e) {
      Dlog.log(e);
    }
    return err;
  }
}
