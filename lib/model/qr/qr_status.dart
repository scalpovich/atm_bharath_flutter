/// status : true
/// message : "Success"
/// data : {"upiTransRefNo":" ","pspRefNo":"CUS001-3-20220107100634","Amount":1,"txnAuthDate":"2022-01-07T00:00:00+05:30","Status":"PENDING","statusDesc":" ","responseCode":"","approvalNumber":" ","payerVPA":" ","payeeVPA":" ","custRefNo":" ","npciTransId":"","payer_name":" ","addInfo":null}

/// upiTransRefNo : " "
/// pspRefNo : "CUS001-3-20220107100634"
/// Amount : 1
/// txnAuthDate : "2022-01-07T00:00:00+05:30"
/// Status : "PENDING"
/// statusDesc : " "
/// responseCode : ""
/// approvalNumber : " "
/// payerVPA : " "
/// payeeVPA : " "
/// custRefNo : " "
/// npciTransId : ""
/// payer_name : " "
/// addInfo : null

class QrStatus {
  QrStatus({
    this.upiTransRefNo,
    this.pspRefNo,
    this.amount,
    this.txnAuthDate,
    this.status,
    this.statusDesc,
    this.responseCode,
    this.approvalNumber,
    this.payerVpa,
    this.payeeVpa,
    this.custRefNo,
    this.npciTransId,
    this.payerName,
    this.addInfo,
  });

  String? upiTransRefNo;
  String? pspRefNo;
  String? amount;
  String? txnAuthDate;
  String? status;
  String? statusDesc;
  String? responseCode;
  String? approvalNumber;
  String? payerVpa;
  String? payeeVpa;
  String? custRefNo;
  String? npciTransId;
  String? payerName;
  dynamic addInfo;

  factory QrStatus.fromJson(Map<String, dynamic> json) => QrStatus(
        upiTransRefNo: json["upiTransRefNo"],
        pspRefNo: json["pspRefNo"],
        amount: json["Amount"].toString(),
        txnAuthDate: json["txnAuthDate"],
        status: json["Status"],
        statusDesc: json["statusDesc"],
        responseCode: json["responseCode"],
        approvalNumber: json["approvalNumber"],
        payerVpa: json["payerVPA"],
        payeeVpa: json["payeeVPA"],
        custRefNo: json["custRefNo"],
        npciTransId: json["npciTransId"],
        payerName: json["payer_name"],
        addInfo: json["addInfo"],
      );

  Map<String, dynamic> toJson() => {
        "upiTransRefNo": upiTransRefNo,
        "pspRefNo": pspRefNo,
        "Amount": amount.toString(),
        "txnAuthDate": txnAuthDate,
        "Status": status,
        "statusDesc": statusDesc,
        "responseCode": responseCode,
        "approvalNumber": approvalNumber,
        "payerVPA": payerVpa,
        "payeeVPA": payeeVpa,
        "custRefNo": custRefNo,
        "npciTransId": npciTransId,
        "payer_name": payerName,
        "addInfo": addInfo,
      };
}
