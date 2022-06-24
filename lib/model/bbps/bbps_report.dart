import 'package:hive/hive.dart';

part 'bbps_report.g.dart';

/// status : true
/// message : "Success"
/// data : {"report":[{"tran_type":"bbps","transaction_id":13600,"status":"FAILED","status_description":"Technical exception from biller","from_name":" ","from_account":"","benef_acc_name":"","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2022-01-03T00:00:00+05:30","amount":"1 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"Customer Id","parameter_value":"VIgK6MU+9SnH3YkDs9vdKw==","bbps_ref_no":" ","biller_name":"Airtel DTH","biller_id":"AIRT00000NAT87 ","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":" ","biller_category":"DTH ","reference_no":"R222MLPVY","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/AIRT00000NAT87.gif ","trace_id":"r222mlpvy "},{"tran_type":"bbps","transaction_id":13268,"status":"FAILED","status_description":"Amount not within biller configured range for this payment method","from_name":" ","from_account":"","benef_acc_name":"","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2021-12-30T00:00:00+05:30","amount":"10 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"hh\ngg","end_cstmr_mob":"qBi6Ppjtsx9Qkbye4DObhw==","parameter_name":"Customer Id","parameter_value":"VLdIXbJCzoUeHrlyB39uQA==","bbps_ref_no":" ","biller_name":"Airtel DTH","biller_id":"AIRT00000NAT87 ","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":" ","biller_category":"DTH ","reference_no":"WUHPE55ZN","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/AIRT00000NAT87.gif ","trace_id":"wuhpe55zn "},{"tran_type":"bbps","transaction_id":13264,"status":"SUCCESS","status_description":"","from_name":" ","from_account":"","benef_acc_name":"KUNJAHAMMED  HAJI   SON  OF AHAMMADKUTTY","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2021-12-30T00:00:00+05:30","amount":"2530 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"Consumer Number","parameter_value":"FoHgchQrnFCvoYs0qzGUjg==","bbps_ref_no":"BB011364BA3AAAAAK4QH","biller_name":"Kerala State Electricity Board Ltd. (KSEBL)","biller_id":"KSEBL0000KER01","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":"HGA3P176470473974061","biller_category":"Electricity","reference_no":"261638930403","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/KSEBL0000KER01.gif ","trace_id":"gfa0u0qmj "},{"tran_type":"bbps","transaction_id":13259,"status":"FAILED","status_description":"Technical exception from biller","from_name":" ","from_account":"","benef_acc_name":"","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2021-12-30T00:00:00+05:30","amount":"1 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"Customer Id","parameter_value":"VIgK6MU+9SnH3YkDs9vdKw==","bbps_ref_no":" ","biller_name":"Airtel DTH","biller_id":"AIRT00000NAT87 ","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":" ","biller_category":"DTH ","reference_no":"3GZTUV1ZJ","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/AIRT00000NAT87.gif ","trace_id":"3gztuv1zj "}]}

/// report : [{"tran_type":"bbps","transaction_id":13600,"status":"FAILED","status_description":"Technical exception from biller","from_name":" ","from_account":"","benef_acc_name":"","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2022-01-03T00:00:00+05:30","amount":"1 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"Customer Id","parameter_value":"VIgK6MU+9SnH3YkDs9vdKw==","bbps_ref_no":" ","biller_name":"Airtel DTH","biller_id":"AIRT00000NAT87 ","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":" ","biller_category":"DTH ","reference_no":"R222MLPVY","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/AIRT00000NAT87.gif ","trace_id":"r222mlpvy "},{"tran_type":"bbps","transaction_id":13268,"status":"FAILED","status_description":"Amount not within biller configured range for this payment method","from_name":" ","from_account":"","benef_acc_name":"","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2021-12-30T00:00:00+05:30","amount":"10 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"hh\ngg","end_cstmr_mob":"qBi6Ppjtsx9Qkbye4DObhw==","parameter_name":"Customer Id","parameter_value":"VLdIXbJCzoUeHrlyB39uQA==","bbps_ref_no":" ","biller_name":"Airtel DTH","biller_id":"AIRT00000NAT87 ","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":" ","biller_category":"DTH ","reference_no":"WUHPE55ZN","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/AIRT00000NAT87.gif ","trace_id":"wuhpe55zn "},{"tran_type":"bbps","transaction_id":13264,"status":"SUCCESS","status_description":"","from_name":" ","from_account":"","benef_acc_name":"KUNJAHAMMED  HAJI   SON  OF AHAMMADKUTTY","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2021-12-30T00:00:00+05:30","amount":"2530 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"Consumer Number","parameter_value":"FoHgchQrnFCvoYs0qzGUjg==","bbps_ref_no":"BB011364BA3AAAAAK4QH","biller_name":"Kerala State Electricity Board Ltd. (KSEBL)","biller_id":"KSEBL0000KER01","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":"HGA3P176470473974061","biller_category":"Electricity","reference_no":"261638930403","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/KSEBL0000KER01.gif ","trace_id":"gfa0u0qmj "},{"tran_type":"bbps","transaction_id":13259,"status":"FAILED","status_description":"Technical exception from biller","from_name":" ","from_account":"","benef_acc_name":"","benef_acc_no":" ","benf_ifsc":" ","transfer_mode":"Cash","transaction_date":"2021-12-30T00:00:00+05:30","amount":"1 ","cgst":" ","sgst":"","cess":"","conv_fee":"0.00","type":"","commission_amount":"","service_type":"","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"Customer Id","parameter_value":"VIgK6MU+9SnH3YkDs9vdKw==","bbps_ref_no":" ","biller_name":"Airtel DTH","biller_id":"AIRT00000NAT87 ","is_biller_bbps":"Y","payment_channel":"Agent","payment_id":" ","biller_category":"DTH ","reference_no":"3GZTUV1ZJ","auth_count":"1","biller_logo":"https://payments.billdesk.com/hg/images/billerlogo/AIRT00000NAT87.gif ","trace_id":"3gztuv1zj "}]

// class BBPSReports {
//   BBPSReports({
//     List<BBPSReport>? report,
//   }) {
//     _report = report;
//   }
//
//   BBPSReports.fromJson(dynamic json) {
//     if (json['report'] != null) {
//       _report = [];
//       json['report'].forEach((v) {
//         _report?.add(BBPSReport.fromJson(v));
//       });
//     }
//   }
//
//   List<BBPSReport>? _report;
//
//   List<BBPSReport>? get report => _report;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_report != null) {
//       map['report'] = _report?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// /// tran_type : "bbps"
// /// transaction_id : 13600
// /// status : "FAILED"
// /// status_description : "Technical exception from biller"
// /// from_name : " "
// /// from_account : ""
// /// benef_acc_name : ""
// /// benef_acc_no : " "
// /// benf_ifsc : " "
// /// transfer_mode : "Cash"
// /// transaction_date : "2022-01-03T00:00:00+05:30"
// /// amount : "1 "
// /// cgst : " "
// /// sgst : ""
// /// cess : ""
// /// conv_fee : "0.00"
// /// type : ""
// /// commission_amount : ""
// /// service_type : ""
// /// end_cstmr_name : "jasir"
// /// end_cstmr_mob : "VIgK6MU+9SnH3YkDs9vdKw=="
// /// parameter_name : "Customer Id"
// /// parameter_value : "VIgK6MU+9SnH3YkDs9vdKw=="
// /// bbps_ref_no : " "
// /// biller_name : "Airtel DTH"
// /// biller_id : "AIRT00000NAT87 "
// /// is_biller_bbps : "Y"
// /// payment_channel : "Agent"
// /// payment_id : " "
// /// biller_category : "DTH "
// /// reference_no : "R222MLPVY"
// /// auth_count : "1"
// /// biller_logo : "https://payments.billdesk.com/hg/images/billerlogo/AIRT00000NAT87.gif "
// /// trace_id : "r222mlpvy "
//
// @HiveType(typeId: 2)
// class BBPSReport extends HiveObject {
//   BBPSReport({
//     @HiveField(1) String? tranType,
//     @HiveField(2) int? transactionId,
//     @HiveField(3) String? status,
//     @HiveField(4) String? statusDescription,
//     @HiveField(5) String? fromName,
//     @HiveField(6) String? fromAccount,
//     @HiveField(7) String? benefAccName,
//     @HiveField(8) String? benefAccNo,
//     @HiveField(9) String? benfIfsc,
//     @HiveField(10) String? transferMode,
//     @HiveField(11) String? transactionDate,
//     @HiveField(12) String? amount,
//     @HiveField(13) String? cgst,
//     @HiveField(14) String? sgst,
//     @HiveField(15) String? cess,
//     @HiveField(16) String? convFee,
//     @HiveField(17) String? type,
//     @HiveField(18) String? commissionAmount,
//     @HiveField(19) String? serviceType,
//     @HiveField(20) String? endCstmrName,
//     @HiveField(21) String? endCstmrMob,
//     @HiveField(22) String? parameterName,
//     @HiveField(23) String? parameterValue,
//     @HiveField(24) String? bbpsRefNo,
//     @HiveField(25) String? billerName,
//     @HiveField(26) String? billerId,
//     @HiveField(27) String? isBillerBbps,
//     @HiveField(28) String? paymentChannel,
//     @HiveField(28) String? paymentId,
//     @HiveField(30) String? billerCategory,
//     @HiveField(31) String? referenceNo,
//     @HiveField(32) String? authCount,
//     @HiveField(33) String? billerLogo,
//     @HiveField(34) String? traceId,
//   }) {
//     _tranType = tranType;
//     _transactionId = transactionId;
//     _status = status;
//     _statusDescription = statusDescription;
//     _fromName = fromName;
//     _fromAccount = fromAccount;
//     _benefAccName = benefAccName;
//     _benefAccNo = benefAccNo;
//     _benfIfsc = benfIfsc;
//     _transferMode = transferMode;
//     _transactionDate = transactionDate;
//     _amount = amount;
//     _cgst = cgst;
//     _sgst = sgst;
//     _cess = cess;
//     _convFee = convFee;
//     _type = type;
//     _commissionAmount = commissionAmount;
//     _serviceType = serviceType;
//     _endCstmrName = endCstmrName;
//     _endCstmrMob = endCstmrMob;
//     _parameterName = parameterName;
//     _parameterValue = parameterValue;
//     _bbpsRefNo = bbpsRefNo;
//     _billerName = billerName;
//     _billerId = billerId;
//     _isBillerBbps = isBillerBbps;
//     _paymentChannel = paymentChannel;
//     _paymentId = paymentId;
//     _billerCategory = billerCategory;
//     _referenceNo = referenceNo;
//     _authCount = authCount;
//     _billerLogo = billerLogo;
//     _traceId = traceId;
//   }
//
//   BBPSReport.fromJson(dynamic json) {
//     _tranType = json['tran_type'];
//     _transactionId = json['transaction_id'].toInt();
//     _status = json['status'];
//     _statusDescription = json['status_description'];
//     _fromName = json['from_name'];
//     _fromAccount = json['from_account'];
//     _benefAccName = json['benef_acc_name'];
//     _benefAccNo = json['benef_acc_no'];
//     _benfIfsc = json['benf_ifsc'];
//     _transferMode = json['transfer_mode'];
//     _transactionDate = json['transaction_date'];
//     _amount = json['amount'];
//     _cgst = json['cgst'];
//     _sgst = json['sgst'];
//     _cess = json['cess'];
//     _convFee = json['conv_fee'];
//     _type = json['type'];
//     _commissionAmount = json['commission_amount'];
//     _serviceType = json['service_type'];
//     _endCstmrName = json['end_cstmr_name'];
//     _endCstmrMob = json['end_cstmr_mob'];
//     _parameterName = json['parameter_name'];
//     _parameterValue = json['parameter_value'];
//     _bbpsRefNo = json['bbps_ref_no'];
//     _billerName = json['biller_name'];
//     _billerId = json['biller_id'];
//     _isBillerBbps = json['is_biller_bbps'];
//     _paymentChannel = json['payment_channel'];
//     _paymentId = json['payment_id'];
//     _billerCategory = json['biller_category'];
//     _referenceNo = json['reference_no'];
//     _authCount = json['auth_count'];
//     _billerLogo = json['biller_logo'];
//     _traceId = json['trace_id'];
//   }
//
//   String? _tranType;
//   int? _transactionId;
//   String? _status;
//   String? _statusDescription;
//   String? _fromName;
//   String? _fromAccount;
//   String? _benefAccName;
//   String? _benefAccNo;
//   String? _benfIfsc;
//   String? _transferMode;
//   String? _transactionDate;
//   String? _amount;
//   String? _cgst;
//   String? _sgst;
//   String? _cess;
//   String? _convFee;
//   String? _type;
//   String? _commissionAmount;
//   String? _serviceType;
//   String? _endCstmrName;
//   String? _endCstmrMob;
//   String? _parameterName;
//   String? _parameterValue;
//   String? _bbpsRefNo;
//   String? _billerName;
//   String? _billerId;
//   String? _isBillerBbps;
//   String? _paymentChannel;
//   String? _paymentId;
//   String? _billerCategory;
//   String? _referenceNo;
//   String? _authCount;
//   String? _billerLogo;
//   String? _traceId;
//
//   String? get tranType => _tranType;
//
//   int? get transactionId => _transactionId;
//
//   String? get status => _status;
//
//   String? get statusDescription => _statusDescription;
//
//   String? get fromName => _fromName;
//
//   String? get fromAccount => _fromAccount;
//
//   String? get benefAccName => _benefAccName;
//
//   String? get benefAccNo => _benefAccNo;
//
//   String? get benfIfsc => _benfIfsc;
//
//   String? get transferMode => _transferMode;
//
//   String? get transactionDate => _transactionDate;
//
//   String? get amount => _amount;
//
//   String? get cgst => _cgst;
//
//   String? get sgst => _sgst;
//
//   String? get cess => _cess;
//
//   String? get convFee => _convFee;
//
//   String? get type => _type;
//
//   String? get commissionAmount => _commissionAmount;
//
//   String? get serviceType => _serviceType;
//
//   String? get endCstmrName => _endCstmrName;
//
//   String? get endCstmrMob => _endCstmrMob;
//
//   String? get parameterName => _parameterName;
//
//   String? get parameterValue => _parameterValue;
//
//   String? get bbpsRefNo => _bbpsRefNo;
//
//   String? get billerName => _billerName;
//
//   String? get billerId => _billerId;
//
//   String? get isBillerBbps => _isBillerBbps;
//
//   String? get paymentChannel => _paymentChannel;
//
//   String? get paymentId => _paymentId;
//
//   String? get billerCategory => _billerCategory;
//
//   String? get referenceNo => _referenceNo;
//
//   String? get authCount => _authCount;
//
//   String? get billerLogo => _billerLogo;
//
//   String? get traceId => _traceId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['tran_type'] = _tranType;
//     map['transaction_id'] = _transactionId;
//     map['status'] = _status;
//     map['status_description'] = _statusDescription;
//     map['from_name'] = _fromName;
//     map['from_account'] = _fromAccount;
//     map['benef_acc_name'] = _benefAccName;
//     map['benef_acc_no'] = _benefAccNo;
//     map['benf_ifsc'] = _benfIfsc;
//     map['transfer_mode'] = _transferMode;
//     map['transaction_date'] = _transactionDate;
//     map['amount'] = _amount;
//     map['cgst'] = _cgst;
//     map['sgst'] = _sgst;
//     map['cess'] = _cess;
//     map['conv_fee'] = _convFee;
//     map['type'] = _type;
//     map['commission_amount'] = _commissionAmount;
//     map['service_type'] = _serviceType;
//     map['end_cstmr_name'] = _endCstmrName;
//     map['end_cstmr_mob'] = _endCstmrMob;
//     map['parameter_name'] = _parameterName;
//     map['parameter_value'] = _parameterValue;
//     map['bbps_ref_no'] = _bbpsRefNo;
//     map['biller_name'] = _billerName;
//     map['biller_id'] = _billerId;
//     map['is_biller_bbps'] = _isBillerBbps;
//     map['payment_channel'] = _paymentChannel;
//     map['payment_id'] = _paymentId;
//     map['biller_category'] = _billerCategory;
//     map['reference_no'] = _referenceNo;
//     map['auth_count'] = _authCount;
//     map['biller_logo'] = _billerLogo;
//     map['trace_id'] = _traceId;
//     return map;
//   }
// }

class BBPSReports {
  BBPSReports({
    this.report,
    this.total,
  });

  List<BBPSReport>? report;
  List<BBPSReportTotal>? total;

  factory BBPSReports.fromJson(Map<String, dynamic> json) => BBPSReports(
        report: List<BBPSReport>.from(
            json["report"].map((x) => BBPSReport.fromJson(x))),
        total: List<BBPSReportTotal>.from(
            json["total"].map((x) => BBPSReportTotal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "report": List<dynamic>.from(report!.map((x) => x.toJson())),
        // "total": List<dynamic>.from(total!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 2)
class BBPSReport {
  BBPSReport({
    this.tranType,
    this.transactionId,
    this.status,
    this.statusDescription,
    this.fromName,
    this.fromAccount,
    this.benefAccName,
    this.benefAccNo,
    this.benfIfsc,
    this.transferMode,
    this.transactionDate,
    this.amount,
    this.cgst,
    this.sgst,
    this.cess,
    this.convFee,
    this.type,
    this.commissionAmount,
    this.serviceType,
    this.endCstmrName,
    this.endCstmrMob,
    this.parameterName,
    this.parameterValue,
    this.bbpsRefNo,
    this.billerName,
    this.billerId,
    this.isBillerBbps,
    this.paymentChannel,
    this.paymentId,
    this.billerCategory,
    this.referenceNo,
    this.authCount,
    this.billerLogo,
    this.traceId,
    this.paramsValue,
  });

  @HiveField(0)
  String? tranType;
  @HiveField(1)
  num? transactionId;
  @HiveField(2)
  String? status;
  @HiveField(3)
  String? statusDescription;
  @HiveField(4)
  String? fromName;
  @HiveField(5)
  String? fromAccount;
  @HiveField(6)
  String? benefAccName;
  @HiveField(7)
  String? benefAccNo;
  @HiveField(8)
  String? benfIfsc;
  @HiveField(9)
  String? transferMode;
  @HiveField(10)
  String? transactionDate;
  @HiveField(11)
  String? amount;
  @HiveField(12)
  String? cgst;
  @HiveField(13)
  String? sgst;
  @HiveField(14)
  String? cess;
  @HiveField(15)
  String? convFee;
  @HiveField(16)
  String? type;
  @HiveField(17)
  String? commissionAmount;
  @HiveField(18)
  String? serviceType;
  @HiveField(19)
  String? endCstmrName;
  @HiveField(20)
  String? endCstmrMob;
  @HiveField(21)
  String? parameterName;
  @HiveField(22)
  String? parameterValue;
  @HiveField(23)
  String? bbpsRefNo;
  @HiveField(24)
  String? billerName;
  @HiveField(25)
  String? billerId;
  @HiveField(26)
  String? isBillerBbps;
  @HiveField(27)
  String? paymentChannel;
  @HiveField(28)
  String? paymentId;
  @HiveField(29)
  String? billerCategory;
  @HiveField(30)
  String? referenceNo;
  @HiveField(31)
  String? authCount;
  @HiveField(32)
  String? billerLogo;
  @HiveField(33)
  String? traceId;
  @HiveField(34)
  String? paramsValue;

  factory BBPSReport.fromJson(dynamic json) => BBPSReport(
        tranType: json["tran_type"],
        transactionId: json["transaction_id"],
        status: json["status"],
        statusDescription: json["status_description"],
        fromName: json["from_name"],
        fromAccount: json["from_account"],
        benefAccName: json["benef_acc_name"],
        benefAccNo: json["benef_acc_no"],
        benfIfsc: json["benf_ifsc"],
        transferMode: json["transfer_mode"],
        transactionDate: json["transaction_date"],
        amount: json["amount"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        cess: json["cess"],
        convFee: json["conv_fee"],
        type: json["type"],
        commissionAmount: json["commission_amount"],
        serviceType: json["service_type"],
        endCstmrName: json["end_cstmr_name"],
        endCstmrMob: json["end_cstmr_mob"],
        parameterName: json["parameter_name"],
        parameterValue: json["value"],
        paramsValue: json['parameter_value'],
        bbpsRefNo: json["bbps_ref_no"],
        billerName: json["biller_name"],
        billerId: json["biller_id"],
        isBillerBbps: json["is_biller_bbps"],
        paymentChannel: json["payment_channel"],
        paymentId: json["payment_id"],
        billerCategory: json["biller_category"],
        referenceNo: json["reference_no"],
        authCount: json["auth_count"],
        billerLogo: json["biller_logo"],
        traceId: json["trace_id"],
      );

  Map<String, dynamic> toJson() => {
        "tran_type": tranType,
        "transaction_id": transactionId,
        "status": status,
        "status_description": statusDescription,
        "from_name": fromName,
        "from_account": fromAccount,
        "benef_acc_name": benefAccName,
        "benef_acc_no": benefAccNo,
        "benf_ifsc": benfIfsc,
        "transfer_mode": transferMode,
        "transaction_date": transactionDate,
        "amount": amount,
        "cgst": cgst,
        "sgst": sgst,
        "cess": cess,
        "conv_fee": convFee,
        "type": type,
        "commission_amount": commissionAmount,
        "service_type": serviceType,
        "end_cstmr_name": endCstmrName,
        "end_cstmr_mob": endCstmrMob,
        "parameter_name": parameterName,
        "value": parameterValue,
        "parameter_value": paramsValue,
        "bbps_ref_no": bbpsRefNo,
        "biller_name": billerName,
        "biller_id": billerId,
        "is_biller_bbps": isBillerBbps,
        "payment_channel": paymentChannel,
        "payment_id": paymentId,
        "biller_category": billerCategory,
        "reference_no": referenceNo,
        "auth_count": authCount,
        "biller_logo": billerLogo,
        "trace_id": traceId,
      };
}

class BBPSReportTotal {
  BBPSReportTotal({
    this.totalTrnAmt,
  });

  double? totalTrnAmt;

  factory BBPSReportTotal.fromJson(dynamic json) => BBPSReportTotal(
        totalTrnAmt: json["total_trn_amt"],
      );

  Map<String, dynamic> toJson() => {
        "total_trn_amt": totalTrnAmt,
      };
}
