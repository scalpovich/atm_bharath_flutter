import 'package:hive/hive.dart';

part 'purpose.g.dart';

/// status : true
/// message : "Success"
/// data : [{"MTPS_SYS_ID":8,"MTPS_PURPOSENAME":"Rent"},{"MTPS_SYS_ID":1,"MTPS_PURPOSENAME":"Deposit/Investment"},{"MTPS_SYS_ID":2,"MTPS_PURPOSENAME":"Gift to relatives"},{"MTPS_SYS_ID":3,"MTPS_PURPOSENAME":"Donation"},{"MTPS_SYS_ID":4,"MTPS_PURPOSENAME":"Fees"},{"MTPS_SYS_ID":30,"MTPS_PURPOSENAME":"Family Maintenance"}]

/// MTPS_SYS_ID : 8
/// MTPS_PURPOSENAME : "Rent"

@HiveType(typeId: 7)
class Purpose extends HiveObject {
  Purpose({
    required this.mtpsSysId,
    required this.mtpsPurposename,
  });

  @HiveField(0)
  int mtpsSysId;
  @HiveField(1)
  String mtpsPurposename;

  factory Purpose.fromJson(dynamic json) => Purpose(
        mtpsSysId: json["MTPS_SYS_ID"],
        mtpsPurposename: json["MTPS_PURPOSENAME"],
      );

  Map<String, dynamic> toJson() => {
        "MTPS_SYS_ID": mtpsSysId,
        "MTPS_PURPOSENAME": mtpsPurposename,
      };
}
