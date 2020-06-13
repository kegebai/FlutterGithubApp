import 'dart:convert';

import '../../app/network/addr.dart';
import '../../app/network/http_service.dart';
import '../../app/utils/params_util.dart';
import '../../models/event.dart';
import '../../db/event_db_provider.dart';
import './dao_result.dart';

class EventDao {
  ///
  Future<DAOResult> getEvent(
    String userName, {
    int page = 0,
    bool isNeedDB = false,
  }) async {
    EventDBProvider provider = new EventDBProvider();
    next() async {
      String url = Addr.event(userName) + ParamsUtil.transformPage("?", page);
      var res = await HttpService.instance.fetch(url, null, null, null);
      if (res != null && res.result) {
        List<Event> list = new List();
        var data = res.data;
        if (data == null || data.length == 0) {
          return new DAOResult(null, false);
        }
        for (var item in data) {
          list.add(Event.fromJson(item));
        }
        if (isNeedDB) {
          provider.addEvent(userName, json.encode(data));
        }
        return new DAOResult(list, true);
      }
      return null;
    }

    if (isNeedDB) {
      List<Event> events = await provider.getEvents(userName);
      if (events == null || events.isEmpty) {
        return await next();
      }
      return new DAOResult(events, true, next: next);
    }
    return await next();
  }

  ///
  Future<DAOResult> getReceivedEvent(
    String userName, {
    int page = 1,
    bool isNeedDB = false,
  }) async {
    
    next() async {

    }
    if (isNeedDB) {
      
    }
    return await next();
  }
}
