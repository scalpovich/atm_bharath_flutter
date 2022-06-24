import 'package:hive/hive.dart';

@HiveType(typeId: 9)
class UserDetails {
  @HiveField(0)
  String? userName;
  @HiveField(1)
  String? mobileNo;
  @HiveField(2)
  String? orderId;

  UserDetails(this.userName, this.mobileNo, this.orderId);
}
