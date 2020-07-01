import 'dart:convert';

import '../../app/network/addr.dart';
import '../../app/network/http_service.dart';
import '../../app/utils/params_util.dart';
import '../dao/received_event_dao.dart';
import '../../models/event.dart';
import '../../repositories/dao/event_dao.dart';
import '../../repositories/event_repository.dart';
import '../dao/dao_result.dart';

class EventRepositoryImp implements EventRepository {
  @override
  Future<List<Event>> getEvents(String user, int page) async {
    var res = await _getEvent(user);
    return res.data;
  }
  
  @override
  Future<List<Event>> getReceivedEvents(String user, int page) async {
    var res = await _getReceivedEvent(user);
    return res.data;
  }

  Future<DAOResult> _getEvent(
    String userName, {
    int page = 0,
    bool isNeedDB = false,
  }) async {
    EventDao eventDao = new EventDao();
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
          eventDao.addEvent(userName, json.encode(data));
        }
        return new DAOResult(list, true);
      }
      return null;
    }

    if (isNeedDB) {
      List<Event> events = await eventDao.getEvents(userName);
      if (events == null || events.isEmpty) {
        return await next();
      }
      return new DAOResult(events, true, next: next);
    }
    return await next();
  }

  ///
  Future<DAOResult> _getReceivedEvent(
    String userName, {
    int page = 1,
    bool isNeedDB = false,
  }) async {
    if (userName == null || userName.isEmpty) {
      return null;
    }
    ReceivedEventDao provider = new ReceivedEventDao();

    next() async {
      String url = Addr.receivedEvent(userName) + ParamsUtil.transformPage("?", page);
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
          provider.addReceivedEvent(userName, json.encode(data));
        }
        return new DAOResult(list, true);
      }
      return null;
    }

    if (isNeedDB) {
      List<Event> events = await provider.getReceivedEvents(userName);
      if (events == null || events.isEmpty) {
        return await next();
      }
      return new DAOResult(events, true, next: next);
    }
    return await next();
  }
}