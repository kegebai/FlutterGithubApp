import '../models/event.dart';

abstract class EventRepository {

  Future<List<Event>> getEvents(String user, int page);

  Future<List<Event>> getReceivedEvents(String user, int page);
  
}