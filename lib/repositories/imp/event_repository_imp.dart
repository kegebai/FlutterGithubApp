import '../../models/event.dart';
import '../../repositories/dao/event_dao.dart';
import '../../repositories/event_repository.dart';

class EventRepositoryImp implements EventRepository {
  final EventDao _eventDao = new EventDao();

  @override
  Future<List<Event>> getEvents(String user, int page) async {
    var res = await _eventDao.getEvent(user);
    return res.data;
  }
  
  @override
  Future<List<Event>> getReceivedEvents(String user, int page) async {
    var res = await _eventDao.getReceivedEvent(user);
    return res.data;
  }
}