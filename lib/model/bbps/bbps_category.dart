import 'package:hive/hive.dart';

part 'bbps_category.g.dart';

/// status : true
/// message : "Success"
/// data : [{"BILLER_SYSID":20,"OBJECTID":"biller","BILLERID":"VIDEOCON0NAT01","BILLER_LEGAL_NAME":"Videocon D2H","BILLER_NAME":"Videocon D2H","BILLER_LOCATION":"National","BILLER_CATEGORY":"DTH","BILLER_REG_ADDRESS":"Essel House, B-10 Lawrence Road, Industrial Area Delhi","BILLER_REG_CITY":"North West Delhi","BILLER_REG_PIN":"110035","BILLER_REG_STATE":"Delhi","BILLER_REG_COUNTRY":"India","BILLER_MODE":"ONLINE","BILLER_STATUS":"ACTIVE","BILLER_CREATED_DATE":"2021-05-04T17:07:08","BILLER_LASTMODIFIED_DATE":"2020-06-19T00:00:00","BILLER_LOGO":"https://payments.billdesk.com/hg/images/billerlogo/VIDEOCON0NAT01.gif","BILLER_BILL_COPY":"https://payments.billdesk.com/hg/images/billcopy/VIDEOCON0NAT01.gif","BILLER_TYPE":"PAYEE","FETCH_BILL":"N","PARTIAL_PAY":"N","PAY_AFTER_DUEDATE":"N","ONLINE_VALIDATION":"Y","ISBILLERBBPS":"Y","BBPS_BILLERID":"VIDEOCON0NAT01","BILL_PRESENTMENT":"Y","PAYMENTAMOUNT_VALIDATION":"Y","allowed_payment_methods":[{"BAP_SYS_ID":902,"PAYMENT_METHOD":"Cash","MIN_LIMIT":1,"MAX_LIMIT":49999,"AUTOPAY_ALLOWED":"N","PAYLATER_ALLOWED":"N","BAP_BILLERS_SYS_ID":20}],"authenticators":[{"BA_SYS_ID":1428,"PARAMETER_NAME":"Customer ID / Registered Telephone No","DATA_TYPE":"Numeric","OPTIONAL":"N","REGEX":"^[0-9]{3,15}$","ERROR_MESSAGE":"Please enter a valid min 3 and max 15 digits Customer ID / Registered Telephone No (eg 9845614313)","SEQ":1,"ENCRYPTION_REQUIRED":null,"BA_BILLERS_SYS_ID":20}]}]

/// BILLER_SYSID : 20
/// OBJECTID : "biller"
/// BILLERID : "VIDEOCON0NAT01"
/// BILLER_LEGAL_NAME : "Videocon D2H"
/// BILLER_NAME : "Videocon D2H"
/// BILLER_LOCATION : "National"
/// BILLER_CATEGORY : "DTH"
/// BILLER_REG_ADDRESS : "Essel House, B-10 Lawrence Road, Industrial Area Delhi"
/// BILLER_REG_CITY : "North West Delhi"
/// BILLER_REG_PIN : "110035"
/// BILLER_REG_STATE : "Delhi"
/// BILLER_REG_COUNTRY : "India"
/// BILLER_MODE : "ONLINE"
/// BILLER_STATUS : "ACTIVE"
/// BILLER_CREATED_DATE : "2021-05-04T17:07:08"
/// BILLER_LASTMODIFIED_DATE : "2020-06-19T00:00:00"
/// BILLER_LOGO : "https://payments.billdesk.com/hg/images/billerlogo/VIDEOCON0NAT01.gif"
/// BILLER_BILL_COPY : "https://payments.billdesk.com/hg/images/billcopy/VIDEOCON0NAT01.gif"
/// BILLER_TYPE : "PAYEE"
/// FETCH_BILL : "N"
/// PARTIAL_PAY : "N"
/// PAY_AFTER_DUEDATE : "N"
/// ONLINE_VALIDATION : "Y"
/// ISBILLERBBPS : "Y"
/// BBPS_BILLERID : "VIDEOCON0NAT01"
/// BILL_PRESENTMENT : "Y"
/// PAYMENTAMOUNT_VALIDATION : "Y"
/// allowed_payment_methods : [{"BAP_SYS_ID":902,"PAYMENT_METHOD":"Cash","MIN_LIMIT":1,"MAX_LIMIT":49999,"AUTOPAY_ALLOWED":"N","PAYLATER_ALLOWED":"N","BAP_BILLERS_SYS_ID":20}]
/// authenticators : [{"BA_SYS_ID":1428,"PARAMETER_NAME":"Customer ID / Registered Telephone No","DATA_TYPE":"Numeric","OPTIONAL":"N","REGEX":"^[0-9]{3,15}$","ERROR_MESSAGE":"Please enter a valid min 3 and max 15 digits Customer ID / Registered Telephone No (eg 9845614313)","SEQ":1,"ENCRYPTION_REQUIRED":null,"BA_BILLERS_SYS_ID":20}]

@HiveType(typeId: 1)
class BBPSCategory extends HiveObject {
  @HiveField(0)
  String? billerId;
  @HiveField(1)
  String? billerName;
  @HiveField(2)
  String? billerCategory;
  @HiveField(3)
  String? billerLogo;
  @HiveField(4)
  String? fetchBill;
  @HiveField(5)
  String? partialPay;
  @HiveField(6)
  String? onlineValidation;
  @HiveField(7)
  String? isBillerBBPS;
  @HiveField(8)
  List<Authenticator>? authenticators;

  BBPSCategory({
    this.billerId,
    this.billerName,
    this.billerCategory,
    this.billerLogo,
    this.fetchBill,
    this.partialPay,
    this.onlineValidation,
    this.isBillerBBPS,
    this.authenticators,
  });

  BBPSCategory.fromJson(dynamic json) {
    billerId = json['BILLERID'];
    billerName = json['BILLER_NAME'];
    billerCategory = json['BILLER_CATEGORY'];
    billerLogo = json['BILLER_LOGO'];
    fetchBill = json['FETCH_BILL'];
    partialPay = json['PARTIAL_PAY'];
    onlineValidation = json['ONLINE_VALIDATION'];
    isBillerBBPS = json['ISBILLERBBPS'];
    if (json['authenticators'] != null) {
      authenticators = [];
      json['authenticators'].forEach((v) {
        authenticators?.add(Authenticator.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BILLERID'] = billerId;
    map['BILLER_NAME'] = billerName;
    map['BILLER_CATEGORY'] = billerCategory;
    map['BILLER_LOGO'] = billerLogo;
    map['FETCH_BILL'] = fetchBill;
    map['PARTIAL_PAY'] = partialPay;
    map['ONLINE_VALIDATION'] = onlineValidation;
    map['ISBILLERBBPS'] = isBillerBBPS;
    if (authenticators != null) {
      map['authenticators'] = authenticators?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

// /// BA_SYS_ID : 1428
// /// PARAMETER_NAME : "Customer ID / Registered Telephone No"
// /// DATA_TYPE : "Numeric"
// /// OPTIONAL : "N"
// /// REGEX : "^[0-9]{3,15}$"
// /// ERROR_MESSAGE : "Please enter a valid min 3 and max 15 digits Customer ID / Registered Telephone No (eg 9845614313)"
// /// SEQ : 1
// /// ENCRYPTION_REQUIRED : null
// /// BA_BILLERS_SYS_ID : 20
//
// class Authenticators {
//   Authenticators({
//     num? basysid,
//     String? parametername,
//     String? datatype,
//     String? optional,
//     String? regex,
//     String? errormessage,
//     num? seq,
//     dynamic encryptionrequired,
//     num? babillerssysid,
//   }) {
//     _basysid = basysid;
//     _parametername = parametername;
//     _datatype = datatype;
//     _optional = optional;
//     _regex = regex;
//     _errormessage = errormessage;
//     _seq = seq;
//     _encryptionrequired = encryptionrequired;
//     _babillerssysid = babillerssysid;
//   }
//
//   Authenticators.fromJson(dynamic json) {
//     _basysid = json['BA_SYS_ID'];
//     _parametername = json['PARAMETER_NAME'];
//     _datatype = json['DATA_TYPE'];
//     _optional = json['OPTIONAL'];
//     _regex = json['REGEX'];
//     _errormessage = json['ERROR_MESSAGE'];
//     _seq = json['SEQ'];
//     _encryptionrequired = json['ENCRYPTION_REQUIRED'];
//     _babillerssysid = json['BA_BILLERS_SYS_ID'];
//   }
//   num? _basysid;
//   String? _parametername;
//   String? _datatype;
//   String? _optional;
//   String? _regex;
//   String? _errormessage;
//   num? _seq;
//   dynamic _encryptionrequired;
//   num? _babillerssysid;
//
//   num? get basysid => _basysid;
//   String? get parametername => _parametername;
//   String? get datatype => _datatype;
//   String? get optional => _optional;
//   String? get regex => _regex;
//   String? get errormessage => _errormessage;
//   num? get seq => _seq;
//   dynamic get encryptionrequired => _encryptionrequired;
//   num? get babillerssysid => _babillerssysid;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['BA_SYS_ID'] = _basysid;
//     map['PARAMETER_NAME'] = _parametername;
//     map['DATA_TYPE'] = _datatype;
//     map['OPTIONAL'] = _optional;
//     map['REGEX'] = _regex;
//     map['ERROR_MESSAGE'] = _errormessage;
//     map['SEQ'] = _seq;
//     map['ENCRYPTION_REQUIRED'] = _encryptionrequired;
//     map['BA_BILLERS_SYS_ID'] = _babillerssysid;
//     return map;
//   }
// }
//
// /// BAP_SYS_ID : 902
// /// PAYMENT_METHOD : "Cash"
// /// MIN_LIMIT : 1
// /// MAX_LIMIT : 49999
// /// AUTOPAY_ALLOWED : "N"
// /// PAYLATER_ALLOWED : "N"
// /// BAP_BILLERS_SYS_ID : 20
//
// class AllowedPaymentMethods {
//   AllowedPaymentMethods({
//     num? bapsysid,
//     String? paymentmethod,
//     num? minlimit,
//     num? maxlimit,
//     String? autopayallowed,
//     String? paylaterallowed,
//     num? bapbillerssysid,
//   }) {
//     _bapsysid = bapsysid;
//     _paymentmethod = paymentmethod;
//     _minlimit = minlimit;
//     _maxlimit = maxlimit;
//     _autopayallowed = autopayallowed;
//     _paylaterallowed = paylaterallowed;
//     _bapbillerssysid = bapbillerssysid;
//   }
//
//   AllowedPaymentMethods.fromJson(dynamic json) {
//     _bapsysid = json['BAP_SYS_ID'];
//     _paymentmethod = json['PAYMENT_METHOD'];
//     _minlimit = json['MIN_LIMIT'];
//     _maxlimit = json['MAX_LIMIT'];
//     _autopayallowed = json['AUTOPAY_ALLOWED'];
//     _paylaterallowed = json['PAYLATER_ALLOWED'];
//     _bapbillerssysid = json['BAP_BILLERS_SYS_ID'];
//   }
//   num? _bapsysid;
//   String? _paymentmethod;
//   num? _minlimit;
//   num? _maxlimit;
//   String? _autopayallowed;
//   String? _paylaterallowed;
//   num? _bapbillerssysid;
//
//   num? get bapsysid => _bapsysid;
//   String? get paymentmethod => _paymentmethod;
//   num? get minlimit => _minlimit;
//   num? get maxlimit => _maxlimit;
//   String? get autopayallowed => _autopayallowed;
//   String? get paylaterallowed => _paylaterallowed;
//   num? get bapbillerssysid => _bapbillerssysid;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['BAP_SYS_ID'] = _bapsysid;
//     map['PAYMENT_METHOD'] = _paymentmethod;
//     map['MIN_LIMIT'] = _minlimit;
//     map['MAX_LIMIT'] = _maxlimit;
//     map['AUTOPAY_ALLOWED'] = _autopayallowed;
//     map['PAYLATER_ALLOWED'] = _paylaterallowed;
//     map['BAP_BILLERS_SYS_ID'] = _bapbillerssysid;
//     return map;
//   }
// }

// @HiveType(typeId: 1)
// class BBPSCategory extends HiveObject {
//   BBPSCategory({
//     this.billerSysid,
//     this.objectid,
//     this.billerid,
//     this.billerLegalName,
//     this.billerName,
//     this.billerLocation,
//     this.billerCategory,
//     this.billerRegAddress,
//     this.billerRegCity,
//     this.billerRegPin,
//     this.billerRegState,
//     this.billerRegCountry,
//     this.billerMode,
//     this.billerStatus,
//     this.billerCreatedDate,
//     this.billerLastmodifiedDate,
//     this.billerLogo,
//     this.billerBillCopy,
//     this.billerType,
//     this.fetchBill,
//     this.partialPay,
//     this.payAfterDuedate,
//     this.onlineValidation,
//     this.isbillerbbps,
//     this.bbpsBillerid,
//     this.billPresentment,
//     this.paymentamountValidation,
//     this.allowedPaymentMethods,
//     this.authenticators,
//   });
//
//   num? billerSysid;
//   String? objectid;
//   @HiveField(0)
//   String? billerid;
//   String? billerLegalName;
//   @HiveField(1)
//   String? billerName;
//   String? billerLocation;
//   @HiveField(2)
//   String? billerCategory;
//   String? billerRegAddress;
//   String? billerRegCity;
//   String? billerRegPin;
//   String? billerRegState;
//   String? billerRegCountry;
//   String? billerMode;
//   String? billerStatus;
//   String? billerCreatedDate;
//   String? billerLastmodifiedDate;
//   @HiveField(3)
//   String? billerLogo;
//   String? billerBillCopy;
//   String? billerType;
//   @HiveField(4)
//   String? fetchBill;
//   @HiveField(5)
//   String? partialPay;
//   String? payAfterDuedate;
//   @HiveField(6)
//   String? onlineValidation;
//   @HiveField(7)
//   String? isbillerbbps;
//   String? bbpsBillerid;
//   String? billPresentment;
//   String? paymentamountValidation;
//   List<AllowedPaymentMethod>? allowedPaymentMethods;
//   @HiveField(8)
//   List<Authenticator>? authenticators;
//
//   factory BBPSCategory.fromJson(dynamic json) => BBPSCategory(
//         billerSysid: json["BILLER_SYSID"],
//         objectid: json["OBJECTID"],
//         billerid: json["BILLERID"],
//         billerLegalName: json["BILLER_LEGAL_NAME"],
//         billerName: json["BILLER_NAME"],
//         billerLocation: json["BILLER_LOCATION"],
//         billerCategory: json["BILLER_CATEGORY"],
//         billerRegAddress: json["BILLER_REG_ADDRESS"],
//         billerRegCity: json["BILLER_REG_CITY"],
//         billerRegPin: json["BILLER_REG_PIN"],
//         billerRegState: json["BILLER_REG_STATE"],
//         billerRegCountry: json["BILLER_REG_COUNTRY"],
//         billerMode: json["BILLER_MODE"],
//         billerStatus: json["BILLER_STATUS"],
//         billerCreatedDate: json["BILLER_CREATED_DATE"],
//         billerLastmodifiedDate: json["BILLER_LASTMODIFIED_DATE"],
//         billerLogo: json["BILLER_LOGO"],
//         billerBillCopy: json["BILLER_BILL_COPY"],
//         billerType: json["BILLER_TYPE"],
//         fetchBill: json["FETCH_BILL"],
//         partialPay: json["PARTIAL_PAY"],
//         payAfterDuedate: json["PAY_AFTER_DUEDATE"],
//         onlineValidation: json["ONLINE_VALIDATION"],
//         isbillerbbps: json["ISBILLERBBPS"],
//         bbpsBillerid: json["BBPS_BILLERID"],
//         billPresentment: json["BILL_PRESENTMENT"],
//         paymentamountValidation: json["PAYMENTAMOUNT_VALIDATION"],
//         allowedPaymentMethods: List<AllowedPaymentMethod>.from(
//             json["allowed_payment_methods"]
//                 .map((x) => AllowedPaymentMethod.fromJson(x))),
//       if (json['authenticators'] != null) {
// //       _authenticators = [];
// //       json['authenticators'].forEach((v) {
// //         _authenticators?.add(Authenticators.fromJson(v));
// //       });
//         authenticators: js
//   // List<Authenticator>.from(
//   //           json["authenticators"].map((x) => Authenticator.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "BILLER_SYSID": billerSysid,
//         "OBJECTID": objectid,
//         "BILLERID": billerid,
//         "BILLER_LEGAL_NAME": billerLegalName,
//         "BILLER_NAME": billerName,
//         "BILLER_LOCATION": billerLocation,
//         "BILLER_CATEGORY": billerCategory,
//         "BILLER_REG_ADDRESS": billerRegAddress,
//         "BILLER_REG_CITY": billerRegCity,
//         "BILLER_REG_PIN": billerRegPin,
//         "BILLER_REG_STATE": billerRegState,
//         "BILLER_REG_COUNTRY": billerRegCountry,
//         "BILLER_MODE": billerMode,
//         "BILLER_STATUS": billerStatus,
//         "BILLER_CREATED_DATE": billerCreatedDate,
//         "BILLER_LASTMODIFIED_DATE": billerLastmodifiedDate,
//         "BILLER_LOGO": billerLogo,
//         "BILLER_BILL_COPY": billerBillCopy,
//         "BILLER_TYPE": billerType,
//         "FETCH_BILL": fetchBill,
//         "PARTIAL_PAY": partialPay,
//         "PAY_AFTER_DUEDATE": payAfterDuedate,
//         "ONLINE_VALIDATION": onlineValidation,
//         "ISBILLERBBPS": isbillerbbps,
//         "BBPS_BILLERID": bbpsBillerid,
//         "BILL_PRESENTMENT": billPresentment,
//         "PAYMENTAMOUNT_VALIDATION": paymentamountValidation,
//         "allowed_payment_methods":
//             List<dynamic>.from(allowedPaymentMethods!.map((x) => x.toJson())),
//         "authenticators":
//             List<dynamic>.from(authenticators!.map((x) => x.toJson())),
//       };
// }
//
// class AllowedPaymentMethod {
//   AllowedPaymentMethod({
//     this.bapSysId,
//     this.paymentMethod,
//     this.minLimit,
//     this.maxLimit,
//     this.autopayAllowed,
//     this.paylaterAllowed,
//     this.bapBillersSysId,
//   });
//
//   num? bapSysId;
//   String? paymentMethod;
//   num? minLimit;
//   num? maxLimit;
//   String? autopayAllowed;
//   String? paylaterAllowed;
//   num? bapBillersSysId;
//
//   factory AllowedPaymentMethod.fromJson(dynamic json) => AllowedPaymentMethod(
//         bapSysId: json["BAP_SYS_ID"],
//         paymentMethod: json["PAYMENT_METHOD"],
//         minLimit: json["MIN_LIMIT"],
//         maxLimit: json["MAX_LIMIT"],
//         autopayAllowed: json["AUTOPAY_ALLOWED"],
//         paylaterAllowed: json["PAYLATER_ALLOWED"],
//         bapBillersSysId: json["BAP_BILLERS_SYS_ID"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "BAP_SYS_ID": bapSysId,
//         "PAYMENT_METHOD": paymentMethod,
//         "MIN_LIMIT": minLimit,
//         "MAX_LIMIT": maxLimit,
//         "AUTOPAY_ALLOWED": autopayAllowed,
//         "PAYLATER_ALLOWED": paylaterAllowed,
//         "BAP_BILLERS_SYS_ID": bapBillersSysId,
//       };
// }
//
// class Authenticator {
//   Authenticator({
//     this.baSysId,
//     this.parameterName,
//     this.dataType,
//     this.optional,
//     this.regex,
//     this.errorMessage,
//     this.seq,
//     this.encryptionRequired,
//     this.baBillersSysId,
//   });
//
//   num? baSysId;
//   String? parameterName;
//   String? dataType;
//   String? optional;
//   String? regex;
//   String? errorMessage;
//   num? seq;
//   dynamic encryptionRequired;
//   num? baBillersSysId;
//
//   factory Authenticator.fromJson(dynamic json) => Authenticator(
//         baSysId: json["BA_SYS_ID"],
//         parameterName: json["PARAMETER_NAME"],
//         dataType: json["DATA_TYPE"],
//         optional: json["OPTIONAL"],
//         regex: json["REGEX"],
//         errorMessage: json["ERROR_MESSAGE"],
//         seq: json["SEQ"],
//         encryptionRequired: json["ENCRYPTION_REQUIRED"],
//         baBillersSysId: json["BA_BILLERS_SYS_ID"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "BA_SYS_ID": baSysId,
//         "PARAMETER_NAME": parameterName,
//         "DATA_TYPE": dataType,
//         "OPTIONAL": optional,
//         "REGEX": regex,
//         "ERROR_MESSAGE": errorMessage,
//         "SEQ": seq,
//         "ENCRYPTION_REQUIRED": encryptionRequired,
//         "BA_BILLERS_SYS_ID": baBillersSysId,
//       };
// }

class AllowedPaymentMethod {
  AllowedPaymentMethod({
    this.bapSysId,
    this.paymentMethod,
    this.minLimit,
    this.maxLimit,
    this.autopayAllowed,
    this.paylaterAllowed,
    this.bapBillersSysId,
  });

  num? bapSysId;
  String? paymentMethod;
  num? minLimit;
  num? maxLimit;
  String? autopayAllowed;
  String? paylaterAllowed;
  num? bapBillersSysId;

  factory AllowedPaymentMethod.fromJson(dynamic json) => AllowedPaymentMethod(
        bapSysId: json["BAP_SYS_ID"],
        paymentMethod: json["PAYMENT_METHOD"],
        minLimit: json["MIN_LIMIT"],
        maxLimit: json["MAX_LIMIT"],
        autopayAllowed: json["AUTOPAY_ALLOWED"],
        paylaterAllowed: json["PAYLATER_ALLOWED"],
        bapBillersSysId: json["BAP_BILLERS_SYS_ID"],
      );

  Map<String, dynamic> toJson() => {
        "BAP_SYS_ID": bapSysId,
        "PAYMENT_METHOD": paymentMethod,
        "MIN_LIMIT": minLimit,
        "MAX_LIMIT": maxLimit,
        "AUTOPAY_ALLOWED": autopayAllowed,
        "PAYLATER_ALLOWED": paylaterAllowed,
        "BAP_BILLERS_SYS_ID": bapBillersSysId,
      };
}

@HiveType(typeId: 9)
class Authenticator {
  Authenticator({
    this.baSysId,
    this.parameterName,
    this.dataType,
    this.optional,
    this.regex,
    this.errorMessage,
    this.seq,
    this.encryptionRequired,
    this.baBillersSysId,
  });
  @HiveField(0)
  num? baSysId;
  @HiveField(1)
  String? parameterName;
  @HiveField(2)
  String? dataType;
  @HiveField(3)
  String? optional;
  @HiveField(4)
  String? regex;
  @HiveField(5)
  String? errorMessage;
  @HiveField(6)
  num? seq;
  @HiveField(7)
  dynamic encryptionRequired;
  @HiveField(8)
  num? baBillersSysId;

  factory Authenticator.fromJson(dynamic json) => Authenticator(
        baSysId: json["BA_SYS_ID"],
        parameterName: json["PARAMETER_NAME"],
        dataType: json["DATA_TYPE"],
        optional: json["OPTIONAL"],
        regex: json["REGEX"],
        errorMessage: json["ERROR_MESSAGE"],
        seq: json["SEQ"],
        encryptionRequired: json["ENCRYPTION_REQUIRED"],
        baBillersSysId: json["BA_BILLERS_SYS_ID"],
      );

  Map<String, dynamic> toJson() => {
        "BA_SYS_ID": baSysId,
        "PARAMETER_NAME": parameterName,
        "DATA_TYPE": dataType,
        "OPTIONAL": optional,
        "REGEX": regex,
        "ERROR_MESSAGE": errorMessage,
        "SEQ": seq,
        "ENCRYPTION_REQUIRED": encryptionRequired,
        "BA_BILLERS_SYS_ID": baBillersSysId,
      };
}
