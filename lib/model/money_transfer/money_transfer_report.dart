import 'dart:convert';

import 'package:hive/hive.dart';

part 'money_transfer_report.g.dart';

/// status : true
/// message : "Success"
/// data : {"report":[{"tran_type":"moneytrf","transaction_id":192975,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"mohd ","benef_acc_no":"987654321 ","benf_ifsc":"12345678RDV ","transfer_mode":"IMPS","transaction_date":"2022-01-03T09:50:52+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"kas","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":185760,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"jasir ","benef_acc_no":"123456789 ","benf_ifsc":"123456789is ","transfer_mode":"IMPS","transaction_date":"2021-12-29T12:49:54+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174425,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"jasir ","benef_acc_no":"1234567890 ","benf_ifsc":"12345678DRT ","transfer_mode":"IMPS","transaction_date":"2021-12-21T12:21:50+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174391,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"Test1 ","benef_acc_no":"88888 ","benf_ifsc":"TEST ","transfer_mode":"NEFT","transaction_date":"2021-12-21T12:01:11+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"EE","end_cstmr_mob":"7tbHytxJq1bgNhezXc4Lqg==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174385,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"Test1 ","benef_acc_no":"777 ","benf_ifsc":"TEST ","transfer_mode":"NEFT","transaction_date":"2021-12-21T11:55:40+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"EE","end_cstmr_mob":"c0XqQcbXeOQo9e68djViBg==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174381,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"Test1 ","benef_acc_no":"555 ","benf_ifsc":"TESTING ","transfer_mode":"NEFT","transaction_date":"2021-12-21T11:52:11+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"EE","end_cstmr_mob":"WZHq1vbAVkIaTHCgE5kKBA==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "}]}

/// report : [{"tran_type":"moneytrf","transaction_id":192975,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"mohd ","benef_acc_no":"987654321 ","benf_ifsc":"12345678RDV ","transfer_mode":"IMPS","transaction_date":"2022-01-03T09:50:52+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"kas","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":185760,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"jasir ","benef_acc_no":"123456789 ","benf_ifsc":"123456789is ","transfer_mode":"IMPS","transaction_date":"2021-12-29T12:49:54+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174425,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"jasir ","benef_acc_no":"1234567890 ","benf_ifsc":"12345678DRT ","transfer_mode":"IMPS","transaction_date":"2021-12-21T12:21:50+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"jasir","end_cstmr_mob":"VIgK6MU+9SnH3YkDs9vdKw==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174391,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"Test1 ","benef_acc_no":"88888 ","benf_ifsc":"TEST ","transfer_mode":"NEFT","transaction_date":"2021-12-21T12:01:11+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"EE","end_cstmr_mob":"7tbHytxJq1bgNhezXc4Lqg==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174385,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"Test1 ","benef_acc_no":"777 ","benf_ifsc":"TEST ","transfer_mode":"NEFT","transaction_date":"2021-12-21T11:55:40+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"EE","end_cstmr_mob":"c0XqQcbXeOQo9e68djViBg==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "},{"tran_type":"moneytrf","transaction_id":174381,"status":"Processing","status_description":"","from_name":"ANY TIME MONEY PVT LTD ","from_account":"08350200000431","benef_acc_name":"Test1 ","benef_acc_no":"555 ","benf_ifsc":"TESTING ","transfer_mode":"NEFT","transaction_date":"2021-12-21T11:52:11+05:30","amount":"1 ","cgst":"0 ","sgst":"0","cess":"0","conv_fee":"","type":"F","commission_amount":"0","service_type":"MONEYTRF","end_cstmr_name":"EE","end_cstmr_mob":"WZHq1vbAVkIaTHCgE5kKBA==","parameter_name":"","parameter_value":"","bbps_ref_no":"","biller_name":"","biller_id":"","is_biller_bbps":"","payment_channel":"","payment_id":" "}]

class MoneyTransferReports {
  MoneyTransferReports({
    required this.report,
    required this.total,
  });

  List<MoneyTransferReport> report;
  List<MoneyTransferReportTotal> total;

  factory MoneyTransferReports.fromJson(Map<String, dynamic> json) =>
      MoneyTransferReports(
        report: List<MoneyTransferReport>.from(
            json["report"].map((x) => MoneyTransferReport.fromJson(x))),
        total: List<MoneyTransferReportTotal>.from(
            json["total"].map((x) => MoneyTransferReportTotal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "report": List<dynamic>.from(report.map((x) => x.toJson())),
        "total": List<dynamic>.from(total.map((x) => x.toJson())),
      };
}

/// tran_type : "moneytrf"
/// transaction_id : 192975
/// status : "Processing"
/// status_description : ""
/// from_name : "ANY TIME MONEY PVT LTD "
/// from_account : "08350200000431"
/// benef_acc_name : "mohd "
/// benef_acc_no : "987654321 "
/// benf_ifsc : "12345678RDV "
/// transfer_mode : "IMPS"
/// transaction_date : "2022-01-03T09:50:52+05:30"
/// amount : "1 "
/// cgst : "0 "
/// sgst : "0"
/// cess : "0"
/// conv_fee : ""
/// type : "F"
/// commission_amount : "0"
/// service_type : "MONEYTRF"
/// end_cstmr_name : "kas"
/// end_cstmr_mob : "VIgK6MU+9SnH3YkDs9vdKw=="
/// parameter_name : ""
/// parameter_value : ""
/// bbps_ref_no : ""
/// biller_name : ""
/// biller_id : ""
/// is_biller_bbps : ""
/// payment_channel : ""
/// payment_id : " "
@HiveType(typeId: 6)
class MoneyTransferReport extends HiveObject {
  // MoneyTransferReport({
  @HiveField(0)
  String? tranType;
  @HiveField(1)
  int? transactionId;
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
  String? statusFlag;
  @HiveField(30)
  String? traceId;
  String? walletAmount;

  MoneyTransferReport(
      {this.tranType,
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
      this.statusFlag,
      this.traceId,
      this.walletAmount}); // }) {

  factory MoneyTransferReport.fromRawJson(String str) =>
      MoneyTransferReport.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoneyTransferReport.fromJson(dynamic json) => MoneyTransferReport(
        tranType: json['tran_type'],
        transactionId: json['transaction_id'].toInt(),
        status: json['status'],
        statusDescription: json['status_description'],
        fromName: json['from_name'],
        fromAccount: json['from_account'],
        benefAccName: json['benef_acc_name'],
        benefAccNo: json['benef_acc_no'],
        benfIfsc: json['benf_ifsc'],
        transferMode: json['transfer_mode'],
        transactionDate: json['transaction_date'],
        amount: json['amount'],
        cgst: json['cgst'],
        sgst: json['sgst'],
        cess: json['cess'],
        convFee: json['conv_fee'],
        type: json['type'],
        commissionAmount: json['commission_amount'],
        serviceType: json['service_type'],
        endCstmrName: json['end_cstmr_name'],
        endCstmrMob: json['end_cstmr_mob'],
        parameterName: json['parameter_name'],
        parameterValue: json['parameter_value'],
        bbpsRefNo: json['bbps_ref_no'],
        billerName: json['biller_name'],
        billerId: json['biller_id'],
        isBillerBbps: json['is_biller_bbps'],
        paymentChannel: json['payment_channel'],
        paymentId: json['payment_id'],
        traceId: json['trace_id'],
        statusFlag: json['status_flag'],
        walletAmount: json['wallet_amount'],
      );

  Map<String, dynamic> toJson() => {
        'tran_type': tranType,
        'transaction_id': transactionId,
        'status': status,
        'status_description': statusDescription,
        'from_name': fromName,
        'from_account': fromAccount,
        'benef_acc_name': benefAccName,
        'benef_acc_no': benefAccNo,
        'benf_ifsc': benfIfsc,
        'transfer_mode': transferMode,
        'transaction_date': transactionDate,
        'amount': amount,
        'cgst': cgst,
        'sgst': sgst,
        'cess': cess,
        'conv_fee': convFee,
        'type': type,
        'commission_amount': commissionAmount,
        'service_type': serviceType,
        'end_cstmr_name': endCstmrName,
        'end_cstmr_mob': endCstmrMob,
        'parameter_name': parameterName,
        'parameter_value': parameterValue,
        'bbps_ref_no': bbpsRefNo,
        'biller_name': billerName,
        'biller_id': billerId,
        'is_biller_bbps': isBillerBbps,
        'payment_channel': paymentChannel,
        'payment_id': paymentId,
        'trace_id': traceId,
        'status_flag': statusFlag,
        'wallet_amount': walletAmount,
      };
}

class MoneyTransferReportTotal {
  MoneyTransferReportTotal({
    this.serviceType,
    this.totalTrnAmt,
    this.totalCmsnAmt,
  });

  String? serviceType;
  double? totalTrnAmt;
  double? totalCmsnAmt;

  factory MoneyTransferReportTotal.fromJson(dynamic json) =>
      MoneyTransferReportTotal(
        serviceType: json["service_type"],
        totalTrnAmt: json["total_trn_amt"],
        totalCmsnAmt: json["total_cmsn_amt"],
      );

  Map<String, dynamic> toJson() => {
        "service_type": serviceType,
        "total_trn_amt": totalTrnAmt,
        "total_cmsn_amt": totalCmsnAmt,
      };
}
