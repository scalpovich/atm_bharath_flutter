class MobileRecharge {
  MobileRecharge({
    this.sourceid,
    this.customerid,
    this.paymentid,
    this.objectid,
    this.currency,
    this.billerid,
    this.validationid,
    this.sourceRefNo,
    this.paymentAmount,
    this.paymentRemarks,
    this.billerName,
    this.billerCategory,
    this.authenticators,
    this.paymentType,
    this.txnDateTime,
    this.billerApprovalCode,
    this.billerStatus,
    this.paymentAccount,
    this.paymentStatus,
    this.debitAmount,
    this.couConvFee,
    this.bouConvFee,
    this.consumerId,
    this.parameterName,
    this.transactionId,
  });

  String? sourceid;
  String? customerid;
  String? paymentid;
  String? objectid;
  String? currency;
  String? billerid;
  String? validationid;
  String? sourceRefNo;
  String? paymentAmount;
  String? paymentRemarks;
  String? billerName;
  String? billerCategory;
  List<Authenticator>? authenticators;
  String? paymentType;
  String? txnDateTime;
  String? billerApprovalCode;
  String? billerStatus;
  PaymentAccount? paymentAccount;
  String? paymentStatus;
  String? debitAmount;
  String? couConvFee;
  String? bouConvFee;
  String? consumerId;
  String? parameterName;
  double? transactionId;

  factory MobileRecharge.fromJson(Map<String, dynamic> json) => MobileRecharge(
        sourceid: json["sourceid"],
        customerid: json["customerid"],
        paymentid: json["paymentid"],
        objectid: json["objectid"],
        currency: json["currency"],
        billerid: json["billerid"],
        validationid: json["validationid"],
        sourceRefNo: json["source_ref_no"],
        paymentAmount: json["payment_amount"],
        paymentRemarks: json["payment_remarks"],
        billerName: json["biller_name"],
        billerCategory: json["biller_category"],
        authenticators: List<Authenticator>.from(
            json["authenticators"].map((x) => Authenticator.fromJson(x))),
        paymentType: json["payment_type"],
        txnDateTime: json["txn_date_time"],
        billerApprovalCode: json["biller_approval_code"],
        billerStatus: json["biller_status"],
        paymentAccount: PaymentAccount.fromJson(json["payment_account"]),
        paymentStatus: json["payment_status"],
        debitAmount: json["debit_amount"].toString(),
        couConvFee: json["cou_conv_fee"].toString(),
        bouConvFee: json["bou_conv_fee"].toString(),
        consumerId: json["consumer_id"],
        parameterName: json["parameter_name"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "sourceid": sourceid,
        "customerid": customerid,
        "paymentid": paymentid,
        "objectid": objectid,
        "currency": currency,
        "billerid": billerid,
        "validationid": validationid,
        "source_ref_no": sourceRefNo,
        "payment_amount": paymentAmount,
        "payment_remarks": paymentRemarks,
        "biller_name": billerName,
        "biller_category": billerCategory,
        "authenticators":
            List<dynamic>.from(authenticators!.map((x) => x.toJson())),
        "payment_type": paymentType,
        "txn_date_time": txnDateTime,
        "biller_approval_code": billerApprovalCode,
        "biller_status": billerStatus,
        "payment_account": paymentAccount,
        "payment_status": paymentStatus,
        "debit_amount": debitAmount,
        "cou_conv_fee": couConvFee,
        "bou_conv_fee": bouConvFee,
        "consumer_id": consumerId,
        "parameter_name": parameterName,
        "transaction_id": transactionId,
      };
}

class Authenticator {
  Authenticator({
    this.parameterName,
    this.value,
  });

  String? parameterName;
  String? value;

  factory Authenticator.fromJson(dynamic json) => Authenticator(
        parameterName: json["parameter_name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "parameter_name": parameterName,
        "value": value,
      };
}

class PaymentAccount {
  PaymentAccount({
    this.objectid,
    this.paymentMethod,
    this.remarks,
  });

  String? objectid;
  String? paymentMethod;
  String? remarks;

  factory PaymentAccount.fromJson(dynamic json) => PaymentAccount(
        objectid: json["objectid"],
        paymentMethod: json["payment_method"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "objectid": objectid,
        "payment_method": paymentMethod,
        "remarks": remarks,
      };
}
