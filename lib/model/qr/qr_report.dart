import 'package:hive_flutter/hive_flutter.dart';

part 'qr_report.g.dart';

/// status : true
/// message : "Success"
/// data : {"report":[{"tran_type":"QR Code","transaction_id":"CUS001-3-20220103095226","status":"FAILED","status_description":"","invoice_name":"jasir ","invoice_no":"45838 ","invoice_date":"2022-01-03T00:00:00+05:30","transaction_date":"2022-01-03T09:52:32+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217170356","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T17:04:06+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217165943","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:59:49+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217165819","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:58:25+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217164404","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:44:10+05:30","amount":"100 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217162314","status":"FAILED","status_description":"","invoice_name":"jas ","invoice_no":"1 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:23:24+05:30","amount":"1000 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217161617","status":"FAILED","status_description":"","invoice_name":"jasir ","invoice_no":"123 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:16:23+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217161558","status":"FAILED","status_description":"","invoice_name":"jasir ","invoice_no":"123 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:16:07+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217155433","status":"FAILED","status_description":"","invoice_name":"jas ","invoice_no":"2356 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T15:54:43+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211215111947","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-15T00:00:00+05:30","transaction_date":"2021-12-15T11:19:54+05:30","amount":"50 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"}]}

/// report : [{"tran_type":"QR Code","transaction_id":"CUS001-3-20220103095226","status":"FAILED","status_description":"","invoice_name":"jasir ","invoice_no":"45838 ","invoice_date":"2022-01-03T00:00:00+05:30","transaction_date":"2022-01-03T09:52:32+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217170356","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T17:04:06+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217165943","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:59:49+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217165819","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:58:25+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217164404","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:44:10+05:30","amount":"100 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217162314","status":"FAILED","status_description":"","invoice_name":"jas ","invoice_no":"1 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:23:24+05:30","amount":"1000 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217161617","status":"FAILED","status_description":"","invoice_name":"jasir ","invoice_no":"123 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:16:23+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217161558","status":"FAILED","status_description":"","invoice_name":"jasir ","invoice_no":"123 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T16:16:07+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211217155433","status":"FAILED","status_description":"","invoice_name":"jas ","invoice_no":"2356 ","invoice_date":"2021-12-17T00:00:00+05:30","transaction_date":"2021-12-17T15:54:43+05:30","amount":"1 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"},{"tran_type":"QR Code","transaction_id":"CUS001-3-20211215111947","status":"FAILED","status_description":"","invoice_name":" ","invoice_no":" ","invoice_date":"2021-12-15T00:00:00+05:30","transaction_date":"2021-12-15T11:19:54+05:30","amount":"50 ","cgst":0,"sgst":0,"cess":0,"gst":0,"igst":0,"gst_pct":0,"gst_incentive":0,"gst_in":" ","payer_name":" ","payment_channel":"Agent"}]

/// tran_type : "QR Code"
/// transaction_id : "CUS001-3-20220103095226"
/// status : "FAILED"
/// status_description : ""
/// invoice_name : "jasir "
/// invoice_no : "45838 "
/// invoice_date : "2022-01-03T00:00:00+05:30"
/// transaction_date : "2022-01-03T09:52:32+05:30"
/// amount : "1 "
/// cgst : 0
/// sgst : 0
/// cess : 0
/// gst : 0
/// igst : 0
/// gst_pct : 0
/// gst_incentive : 0
/// gst_in : " "
/// payer_name : " "
/// payment_channel : "Agent"

class QRReports {
  QRReports({
    this.report,
    this.total,
  });

  List<QRReport>? report;
  List<QRReportTotal>? total;

  factory QRReports.fromJson(Map<String, dynamic> json) => QRReports(
        report: List<QRReport>.from(
            json["report"].map((x) => QRReport.fromJson(x))),
        total: List<QRReportTotal>.from(
            json["total"].map((x) => QRReportTotal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "report": List<dynamic>.from(report!.map((x) => x.toJson())),
        "total": List<dynamic>.from(total!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 8)
class QRReport {
  QRReport({
    this.tranType,
    this.transactionId,
    this.status,
    this.statusDescription,
    this.invoiceName,
    this.invoiceNo,
    this.invoiceDate,
    this.transactionDate,
    this.amount,
    this.cgst,
    this.sgst,
    this.cess,
    this.gst,
    this.igst,
    this.gstPct,
    this.gstIncentive,
    this.gstIn,
    this.payerName,
    this.paymentChannel,
  });

  @HiveField(0)
  String? tranType;
  @HiveField(1)
  String? transactionId;
  @HiveField(2)
  String? status;
  @HiveField(3)
  String? statusDescription;
  @HiveField(4)
  String? invoiceName;
  @HiveField(5)
  String? invoiceNo;
  @HiveField(6)
  String? invoiceDate;
  @HiveField(7)
  String? transactionDate;
  @HiveField(8)
  String? amount;
  @HiveField(9)
  num? cgst;
  @HiveField(10)
  num? sgst;
  @HiveField(11)
  num? cess;
  @HiveField(12)
  num? gst;
  @HiveField(13)
  num? igst;
  @HiveField(14)
  num? gstPct;
  @HiveField(15)
  num? gstIncentive;
  @HiveField(16)
  String? gstIn;
  @HiveField(17)
  String? payerName;
  @HiveField(18)
  String? paymentChannel;

  factory QRReport.fromJson(dynamic json) => QRReport(
        tranType: json["tran_type"],
        transactionId: json["transaction_id"],
        status: json["status"],
        statusDescription: json["status_description"],
        invoiceName: json["invoice_name"],
        invoiceNo: json["invoice_no"],
        invoiceDate: json["invoice_date"],
        transactionDate: json["transaction_date"],
        amount: json["amount"],
        cgst: json["cgst"] ?? 0,
        sgst: json["sgst"] ?? 0,
        cess: json["cess"] ?? 0,
        gst: json["gst"] ?? 0,
        igst: json["igst"] ?? 0,
        gstPct: json["gst_pct"] ?? 0,
        gstIncentive: json["gst_incentive"] ?? 0,
        gstIn: json["gst_in"] ?? 0,
        payerName: json["payer_name"],
        paymentChannel: json["payment_channel"],
      );

  Map<String, dynamic> toJson() => {
        "tran_type": tranType,
        "transaction_id": transactionId,
        "status": status,
        "status_description": statusDescription,
        "invoice_name": invoiceName,
        "invoice_no": invoiceNo,
        "invoice_date": invoiceDate,
        "transaction_date": transactionDate,
        "amount": amount,
        "cgst": cgst,
        "sgst": sgst,
        "cess": cess,
        "gst": gst,
        "igst": igst,
        "gst_pct": gstPct,
        "gst_incentive": gstIncentive,
        "gst_in": gstIn,
        "payer_name": payerName,
        "payment_channel": paymentChannel,
      };
}

class QRReportTotal {
  QRReportTotal({
    this.totalTrnAmt,
  });

  double? totalTrnAmt;

  factory QRReportTotal.fromJson(dynamic json) => QRReportTotal(
        totalTrnAmt: json["total_trn_amt"],
      );

  Map<String, dynamic> toJson() => {
        "total_trn_amt": totalTrnAmt,
      };
}
