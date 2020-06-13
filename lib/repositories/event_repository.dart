import '../models/event.dart';

abstract class EventRepository {

  Future<List<Event>> getEvent(String user, int page);
}