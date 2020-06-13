import 'package:flutter_github_app/db/db_provider.dart';

class EventDBProvider extends DBProvider {
  static final String tbName = "Events";

  @override
  String tableName() => tbName;
}