/// status : true
/// message : "Success"
/// data : {"transaction_id":"200682","transaction_date":"2022-01-06T18:58:24+05:30","is_fee":"F","commision_fees":"0","CESS":"0","CGST":"0","SGST":"0","status":"Processing","trace_id":"V222201B01844202201061858166PVM","wallet_amount":"996461"}

/// transaction_id : "200682"
/// transaction_date : "2022-01-06T18:58:24+05:30"
/// is_fee : "F"
/// commision_fees : "0"
/// CESS : "0"
/// CGST : "0"
/// SGST : "0"
/// status : "Processing"
/// trace_id : "V222201B01844202201061858166PVM"
/// wallet_amount : "996461"

class MoneyTransfer {
  MoneyTransfer({
    String? transactionId,
    String? transactionDate,
    String? isFee,
    String? commisionFees,
    String? cess,
    String? cgst,
    String? sgst,
    String? status,
    String? traceId,
    String? walletAmount,
  }) {
    _transactionId = transactionId;
    _transactionDate = transactionDate;
    _isFee = isFee;
    _commisionFees = commisionFees;
    _cess = cess;
    _cgst = cgst;
    _sgst = sgst;
    _status = status;
    _traceId = traceId;
    _walletAmount = walletAmount;
  }

  MoneyTransfer.fromJson(dynamic json) {
    _transactionId = json['transaction_id'].toString();
    _transactionDate = json['transaction_date'];
    _isFee = json['is_fee'];
    _commisionFees = json['commision_fees'];
    _cess = json['CESS'];
    _cgst = json['CGST'];
    _sgst = json['SGST'];
    _status = json['status'];
    _traceId = json['trace_id'];
    _walletAmount = json['wallet_amount'];
  }
  String? _transactionId;
  String? _transactionDate;
  String? _isFee;
  String? _commisionFees;
  String? _cess;
  String? _cgst;
  String? _sgst;
  String? _status;
  String? _traceId;
  String? _walletAmount;

  String? get transactionId => _transactionId;
  String? get transactionDate => _transactionDate;
  String? get isFee => _isFee;
  String? get commisionFees => _commisionFees;
  String? get cess => _cess;
  String? get cgst => _cgst;
  String? get sgst => _sgst;
  String? get status => _status;
  String? get traceId => _traceId;
  String? get walletAmount => _walletAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_id'] = _transactionId;
    map['transaction_date'] = _transactionDate;
    map['is_fee'] = _isFee;
    map['commision_fees'] = _commisionFees;
    map['CESS'] = _cess;
    map['CGST'] = _cgst;
    map['SGST'] = _sgst;
    map['status'] = _status;
    map['trace_id'] = _traceId;
    map['wallet_amount'] = _walletAmount;
    return map;
  }
}
