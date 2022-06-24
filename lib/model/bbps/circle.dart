import 'package:hive/hive.dart';

import 'biller.dart';

part 'circle.g.dart';

/// status : true
/// message : "Success"
/// data : {"biller":[{"BILLERID":"AIRTELPRE","BILLER_NAME":"Airtel Prepaid"},{"BILLERID":"BSNLPRE","BILLER_NAME":"BSNL  Prepaid "},{"BILLERID":"MTNLDELPRE","BILLER_NAME":"MTNL Delhi Prepaid"},{"BILLERID":"MTNLMUMPRE","BILLER_NAME":"MTNL Mumbai Prepaid"},{"BILLERID":"VODAFONPRE","BILLER_NAME":"Vodafone Prepaid"},{"BILLERID":"JIOPRE","BILLER_NAME":"Jio Prepaid"}],"circle":[{"CIRCLEID":"0","CIRCLE_NAME":"All"},{"CIRCLEID":"1","CIRCLE_NAME":"Andhra Pradesh"},{"CIRCLEID":"2","CIRCLE_NAME":"Assam"},{"CIRCLEID":"3","CIRCLE_NAME":"Bihar and Jharkhand"},{"CIRCLEID":"4","CIRCLE_NAME":"Chennai"},{"CIRCLEID":"5","CIRCLE_NAME":"Delhi NCR"},{"CIRCLEID":"6","CIRCLE_NAME":"Gujarat"},{"CIRCLEID":"7","CIRCLE_NAME":"Haryana"},{"CIRCLEID":"8","CIRCLE_NAME":"Himachal Pradesh"},{"CIRCLEID":"9","CIRCLE_NAME":"Jammu Kashmir"},{"CIRCLEID":"10","CIRCLE_NAME":"Karnataka"},{"CIRCLEID":"11","CIRCLE_NAME":"Kerala"},{"CIRCLEID":"12","CIRCLE_NAME":"Kolkata"},{"CIRCLEID":"13","CIRCLE_NAME":"Madhya Pradesh and Chhattisgarh"},{"CIRCLEID":"14","CIRCLE_NAME":"Maharashtra and Goa"},{"CIRCLEID":"15","CIRCLE_NAME":"Mumbai"},{"CIRCLEID":"16","CIRCLE_NAME":"North East"},{"CIRCLEID":"17","CIRCLE_NAME":"Odisha"},{"CIRCLEID":"18","CIRCLE_NAME":"Punjab"},{"CIRCLEID":"19","CIRCLE_NAME":"Rajasthan"},{"CIRCLEID":"20","CIRCLE_NAME":"Tamilnadu"},{"CIRCLEID":"21","CIRCLE_NAME":"UP East"},{"CIRCLEID":"22","CIRCLE_NAME":"UP West and Uttarakhand"},{"CIRCLEID":"23","CIRCLE_NAME":"West Bengal and Andaman Nicobar"}]}

/// biller : [{"BILLERID":"AIRTELPRE","BILLER_NAME":"Airtel Prepaid"},{"BILLERID":"BSNLPRE","BILLER_NAME":"BSNL  Prepaid "},{"BILLERID":"MTNLDELPRE","BILLER_NAME":"MTNL Delhi Prepaid"},{"BILLERID":"MTNLMUMPRE","BILLER_NAME":"MTNL Mumbai Prepaid"},{"BILLERID":"VODAFONPRE","BILLER_NAME":"Vodafone Prepaid"},{"BILLERID":"JIOPRE","BILLER_NAME":"Jio Prepaid"}]
/// circle : [{"CIRCLEID":"0","CIRCLE_NAME":"All"},{"CIRCLEID":"1","CIRCLE_NAME":"Andhra Pradesh"},{"CIRCLEID":"2","CIRCLE_NAME":"Assam"},{"CIRCLEID":"3","CIRCLE_NAME":"Bihar and Jharkhand"},{"CIRCLEID":"4","CIRCLE_NAME":"Chennai"},{"CIRCLEID":"5","CIRCLE_NAME":"Delhi NCR"},{"CIRCLEID":"6","CIRCLE_NAME":"Gujarat"},{"CIRCLEID":"7","CIRCLE_NAME":"Haryana"},{"CIRCLEID":"8","CIRCLE_NAME":"Himachal Pradesh"},{"CIRCLEID":"9","CIRCLE_NAME":"Jammu Kashmir"},{"CIRCLEID":"10","CIRCLE_NAME":"Karnataka"},{"CIRCLEID":"11","CIRCLE_NAME":"Kerala"},{"CIRCLEID":"12","CIRCLE_NAME":"Kolkata"},{"CIRCLEID":"13","CIRCLE_NAME":"Madhya Pradesh and Chhattisgarh"},{"CIRCLEID":"14","CIRCLE_NAME":"Maharashtra and Goa"},{"CIRCLEID":"15","CIRCLE_NAME":"Mumbai"},{"CIRCLEID":"16","CIRCLE_NAME":"North East"},{"CIRCLEID":"17","CIRCLE_NAME":"Odisha"},{"CIRCLEID":"18","CIRCLE_NAME":"Punjab"},{"CIRCLEID":"19","CIRCLE_NAME":"Rajasthan"},{"CIRCLEID":"20","CIRCLE_NAME":"Tamilnadu"},{"CIRCLEID":"21","CIRCLE_NAME":"UP East"},{"CIRCLEID":"22","CIRCLE_NAME":"UP West and Uttarakhand"},{"CIRCLEID":"23","CIRCLE_NAME":"West Bengal and Andaman Nicobar"}]

// class Circles {
//   Circles({
//     List<Biller>? biller,
//     List<Circle>? circle,
//   }) {
//     _biller = biller;
//     _circle = circle;
//   }
//
//   Circles.fromJson(dynamic json) {
//     if (json['biller'] != null) {
//       _biller = [];
//       json['biller'].forEach((v) {
//         _biller?.add(Biller.fromJson(v));
//       });
//     }
//     if (json['circle'] != null) {
//       _circle = [];
//       json['circle'].forEach((v) {
//         _circle?.add(Circle.fromJson(v));
//       });
//     }
//   }
//   List<Biller>? _biller;
//   List<Circle>? _circle;
//
//   List<Biller>? get biller => _biller;
//   List<Circle>? get circle => _circle;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_biller != null) {
//       map['biller'] = _biller?.map((v) => v.toJson()).toList();
//     }
//     if (_circle != null) {
//       map['circle'] = _circle?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

class Circles {
  Circles({
    this.biller,
    this.circle,
  });

  List<Biller>? biller;
  List<Circle>? circle;

  factory Circles.fromJson(Map<String, dynamic> json) => Circles(
        biller:
            List<Biller>.from(json["biller"].map((x) => Biller.fromJson(x))),
        circle:
            List<Circle>.from(json["circle"].map((x) => Circle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "biller": List<dynamic>.from(biller!.map((x) => x.toJson())),
        "circle": List<dynamic>.from(circle!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 3)
class Circle {
  Circle({
    this.circleid,
    this.circleName,
  });

  @HiveField(0)
  String? circleid;
  @HiveField(1)
  String? circleName;

  factory Circle.fromJson(dynamic json) => Circle(
        circleid: json["CIRCLEID"],
        circleName: json["CIRCLE_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "CIRCLEID": circleid,
        "CIRCLE_NAME": circleName,
      };
}
