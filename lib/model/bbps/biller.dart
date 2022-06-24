import 'package:hive_flutter/hive_flutter.dart';

/// BILLERID : "AIRTELPRE"
/// BILLER_NAME : "Airtel Prepaid"

part 'biller.g.dart';

@HiveType(typeId: 4)
class Biller extends HiveObject {
  Biller({
    this.billerid,
    this.billerName,
  });

  @HiveField(0)
  String? billerid;
  @HiveField(1)
  String? billerName;

  factory Biller.fromJson(dynamic json) => Biller(
        billerid: json["BILLERID"],
        billerName: json["BILLER_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "BILLERID": billerid,
        "BILLER_NAME": billerName,
      };
}
