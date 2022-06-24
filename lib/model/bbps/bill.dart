class Bill {
  Bill({
    this.validationid,
    this.objectid,
    this.currency,
    this.billerid,
    this.billerName,
    this.billerCategory,
    this.validationDate,
    this.billlist,
    this.authenticators,
    this.validUntil,
    this.consumerId,
    this.parameterName,
    this.sourceRefNo,
    this.amountOptions,
    this.additionalInfo,
    this.errorInfo,
  });

  String? validationid;
  String? objectid;
  String? currency;
  String? billerid;
  String? billerName;
  String? billerCategory;
  String? validationDate;
  List<Billlist>? billlist;
  List<Authenticators>? authenticators;
  String? validUntil;
  String? consumerId;
  String? parameterName;
  String? sourceRefNo;
  String? amountOptions;
  String? additionalInfo;
  String? errorInfo;

  factory Bill.fromJson(dynamic json) => Bill(
        validationid: json["validationid"],
        objectid: json["objectid"],
        currency: json["currency"],
        billerid: json["billerid"],
        billerName: json["biller_name"],
        billerCategory: json["biller_category"],
        validationDate: json["validation_date"],
        billlist: List<Billlist>.from(
            json["billlist"].map((x) => Billlist.fromJson(x))),
        authenticators: List<Authenticators>.from(
            json["authenticators"].map((x) => Authenticators.fromJson(x))),
        validUntil: json["valid_until"],
        consumerId: json["consumer_id"],
        parameterName: json["parameter_name"],
        sourceRefNo: json["source_ref_no"],
        amountOptions: json["amountOptions"],
        additionalInfo: json["additionalInfo"],
        errorInfo: json["errorInfo"],
      );

  Map<String, dynamic> toJson() => {
        "validationid": validationid,
        "objectid": objectid,
        "currency": currency,
        "billerid": billerid,
        "biller_name": billerName,
        "biller_category": billerCategory,
        "validation_date": validationDate,
        "billlist": List<dynamic>.from(billlist!.map((x) => x.toJson())),
        "authenticators":
            List<dynamic>.from(authenticators!.map((x) => x.toJson())),
        "valid_until": validUntil,
        "consumer_id": consumerId,
        "parameter_name": parameterName,
        "source_ref_no": sourceRefNo,
        "amountOptions": amountOptions,
        "additionalInfo": additionalInfo,
        "errorInfo": errorInfo,
      };
}

class Authenticators {
  Authenticators({
    this.parameterName,
    this.value,
  });

  String? parameterName;
  String? value;

  factory Authenticators.fromJson(dynamic json) => Authenticators(
        parameterName: json["parameter_name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "parameter_name": parameterName,
        "value": value,
      };
}

class Billlist {
  Billlist({
    this.objectid,
    this.billid,
    this.billstatus,
    this.netBillamount,
    this.customerName,
    this.billamount,
    this.billnumber,
    this.billdate,
    this.billduedate,
    this.billPeriod,
  });

  String? objectid;
  String? billid;
  String? billstatus;
  num? netBillamount;
  String? customerName;
  num? billamount;
  String? billnumber;
  String? billdate;
  String? billduedate;
  String? billPeriod;

  factory Billlist.fromJson(dynamic json) => Billlist(
        objectid: json["objectid"],
        billid: json["billid"],
        billstatus: json["billstatus"],
        netBillamount: json["net_billamount"],
        customerName: json["customer_name"],
        billamount: json["billamount"],
        billnumber: json["billnumber"],
        billdate: json["billdate"],
        billduedate: json["billduedate"],
        billPeriod: json["bill_period"],
      );

  Map<String, dynamic> toJson() => {
        "objectid": objectid,
        "billid": billid,
        "billstatus": billstatus,
        "net_billamount": netBillamount,
        "customer_name": customerName,
        "billamount": billamount,
        "billnumber": billnumber,
        "billdate": billdate,
        "billduedate": billduedate,
        "bill_period": billPeriod,
      };
}
