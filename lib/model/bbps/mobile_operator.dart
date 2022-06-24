/// status : true
/// message : "success"
/// data : {"operatorseriesid":"80898","objectid":"operatorseries","billerid":"AIRTELPRE","biller_name":"Airtel Prepaid","circle_name":"Kerala","status":"ACTIVE","created_date":"21-03-2018 00:00:00","last_modified_date":"20-07-2019 00:00:00","circleid":"11"}

/// operatorseriesid : "80898"
/// objectid : "operatorseries"
/// billerid : "AIRTELPRE"
/// biller_name : "Airtel Prepaid"
/// circle_name : "Kerala"
/// status : "ACTIVE"
/// created_date : "21-03-2018 00:00:00"
/// last_modified_date : "20-07-2019 00:00:00"
/// circleid : "11"

class MobileOperators {
  MobileOperators({
    this.operatorseriesid,
    this.objectid,
    this.billerid,
    this.billerName,
    this.circleName,
    this.status,
    this.createdDate,
    this.lastModifiedDate,
    this.circleid,
  });

  String? operatorseriesid;
  String? objectid;
  String? billerid;
  String? billerName;
  String? circleName;
  String? status;
  String? createdDate;
  String? lastModifiedDate;
  String? circleid;

  factory MobileOperators.fromJson(dynamic json) => MobileOperators(
        operatorseriesid: json["operatorseriesid"].toString(),
        objectid: json["objectid"],
        billerid: json["billerid"],
        billerName: json["biller_name"],
        circleName: json["circle_name"],
        status: json["status"],
        createdDate: json["created_date"],
        lastModifiedDate: json["last_modified_date"],
        circleid: json["circleid"],
      );

  Map<String, dynamic> toJson() => {
        "operatorseriesid": operatorseriesid,
        "objectid": objectid,
        "billerid": billerid,
        "biller_name": billerName,
        "circle_name": circleName,
        "status": status,
        "created_date": createdDate,
        "last_modified_date": lastModifiedDate,
        "circleid": circleid,
      };
}
