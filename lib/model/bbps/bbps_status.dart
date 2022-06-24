/// status : true
/// message : "Success"
/// data : {"biller_status":"FAILED","paymentid":" ","bbps_ref_no":" ","src_ref_no":"AJ5PQ9Z9U","transaction_id":"14214","customerid":" ","parameter_name":"Customer Id","consumer_id":"8089839408","payment_amount":"1 ","txn_date_time":"2022-01-07T00:00:00+05:30","cou_conv_fee":0,"bou_conv_fee":0}

/// biller_status : "FAILED"
/// paymentid : " "
/// bbps_ref_no : " "
/// src_ref_no : "AJ5PQ9Z9U"
/// transaction_id : "14214"
/// customerid : " "
/// parameter_name : "Customer Id"
/// consumer_id : "8089839408"
/// payment_amount : "1 "
/// txn_date_time : "2022-01-07T00:00:00+05:30"
/// cou_conv_fee : 0
/// bou_conv_fee : 0

class BBPSStatus {
  BBPSStatus({
    String? billerStatus,
    String? paymentid,
    String? bbpsRefNo,
    String? srcRefNo,
    String? transactionId,
    String? customerid,
    String? parameterName,
    String? consumerId,
    String? paymentAmount,
    String? txnDateTime,
    int? couConvFee,
    int? bouConvFee,
  }) {
    _billerStatus = billerStatus;
    _paymentid = paymentid;
    _bbpsRefNo = bbpsRefNo;
    _srcRefNo = srcRefNo;
    _transactionId = transactionId;
    _customerid = customerid;
    _parameterName = parameterName;
    _consumerId = consumerId;
    _paymentAmount = paymentAmount;
    _txnDateTime = txnDateTime;
    _couConvFee = couConvFee;
    _bouConvFee = bouConvFee;
  }

  BBPSStatus.fromJson(dynamic json) {
    _billerStatus = json['biller_status'];
    _paymentid = json['paymentid'];
    _bbpsRefNo = json['bbps_ref_no'];
    _srcRefNo = json['src_ref_no'];
    _transactionId = json['transaction_id'];
    _customerid = json['customerid'];
    _parameterName = json['parameter_name'];
    _consumerId = json['consumer_id'];
    _paymentAmount = json['payment_amount'];
    _txnDateTime = json['txn_date_time'];
    _couConvFee = json['cou_conv_fee'];
    _bouConvFee = json['bou_conv_fee'];
  }
  String? _billerStatus;
  String? _paymentid;
  String? _bbpsRefNo;
  String? _srcRefNo;
  String? _transactionId;
  String? _customerid;
  String? _parameterName;
  String? _consumerId;
  String? _paymentAmount;
  String? _txnDateTime;
  int? _couConvFee;
  int? _bouConvFee;

  String? get billerStatus => _billerStatus;
  String? get paymentid => _paymentid;
  String? get bbpsRefNo => _bbpsRefNo;
  String? get srcRefNo => _srcRefNo;
  String? get transactionId => _transactionId;
  String? get customerid => _customerid;
  String? get parameterName => _parameterName;
  String? get consumerId => _consumerId;
  String? get paymentAmount => _paymentAmount;
  String? get txnDateTime => _txnDateTime;
  int? get couConvFee => _couConvFee;
  int? get bouConvFee => _bouConvFee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['biller_status'] = _billerStatus;
    map['paymentid'] = _paymentid;
    map['bbps_ref_no'] = _bbpsRefNo;
    map['src_ref_no'] = _srcRefNo;
    map['transaction_id'] = _transactionId;
    map['customerid'] = _customerid;
    map['parameter_name'] = _parameterName;
    map['consumer_id'] = _consumerId;
    map['payment_amount'] = _paymentAmount;
    map['txn_date_time'] = _txnDateTime;
    map['cou_conv_fee'] = _couConvFee;
    map['bou_conv_fee'] = _bouConvFee;
    return map;
  }
}
