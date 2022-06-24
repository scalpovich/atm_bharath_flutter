import 'package:hive_flutter/hive_flutter.dart';

part 'server.g.dart';

@HiveType(typeId: 10)
class Server extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? serverUrl;
  @HiveField(2)
  bool? serverStatus;
  @HiveField(3)
  String? serverState;

  Server(this.id, this.serverUrl, this.serverStatus, this.serverState);
}
