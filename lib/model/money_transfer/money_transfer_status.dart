/// status : true
/// message : "Success"
/// data : [{"transaction_id":192975,"status":"Processing","benef_acc_name":"mohd","transfer_mode":"IMPS","transaction_date":"2022-01-03T09:50:52+05:30","amount":1,"cgst":0,"sgst":0,"cess":0,"type":"F","commission_amount":0},{"transaction_id":200682,"status":"Processing","benef_acc_name":"jasir","transfer_mode":"IMPS","transaction_date":"2022-01-06T18:58:24+05:30","amount":1,"cgst":0,"sgst":0,"cess":0,"type":"F","commission_amount":0}]

/// transaction_id : 192975
/// status : "Processing"
/// benef_acc_name : "mohd"
/// transfer_mode : "IMPS"
/// transaction_date : "2022-01-03T09:50:52+05:30"
/// amount : 1
/// cgst : 0
/// sgst : 0
/// cess : 0
/// type : "F"
/// commission_amount : 0

class MoneyTransferStatus {
  MoneyTransferStatus({
    num? transactionId,
    String? status,
    String? benefAccName,
    String? transferMode,
    String? transactionDate,
    num? amount,
    num? cgst,
    num? sgst,
    num? cess,
    String? type,
    num? commissionAmount,
  }) {
    _transactionId = transactionId;
    _status = status;
    _benefAccName = benefAccName;
    _transferMode = transferMode;
    _transactionDate = transactionDate;
    _amount = amount;
    _cgst = cgst;
    _sgst = sgst;
    _cess = cess;
    _type = type;
    _commissionAmount = commissionAmount;
  }

  MoneyTransferStatus.fromJson(dynamic json) {
    _transactionId = json['transaction_id'];
    _status = json['status'];
    _benefAccName = json['benef_acc_name'];
    _transferMode = json['transfer_mode'];
    _transactionDate = json['transaction_date'];
    _amount = json['amount'];
    _cgst = json['cgst'];
    _sgst = json['sgst'];
    _cess = json['cess'];
    _type = json['type'];
    _commissionAmount = json['commission_amount'];
  }
  num? _transactionId;
  String? _status;
  String? _benefAccName;
  String? _transferMode;
  String? _transactionDate;
  num? _amount;
  num? _cgst;
  num? _sgst;
  num? _cess;
  String? _type;
  num? _commissionAmount;

  num? get transactionId => _transactionId;
  String? get status => _status;
  String? get benefAccName => _benefAccName;
  String? get transferMode => _transferMode;
  String? get transactionDate => _transactionDate;
  num? get amount => _amount;
  num? get cgst => _cgst;
  num? get sgst => _sgst;
  num? get cess => _cess;
  String? get type => _type;
  num? get commissionAmount => _commissionAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_id'] = _transactionId;
    map['status'] = _status;
    map['benef_acc_name'] = _benefAccName;
    map['transfer_mode'] = _transferMode;
    map['transaction_date'] = _transactionDate;
    map['amount'] = _amount;
    map['cgst'] = _cgst;
    map['sgst'] = _sgst;
    map['cess'] = _cess;
    map['type'] = _type;
    map['commission_amount'] = _commissionAmount;
    return map;
  }
}
