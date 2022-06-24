/// status : true
/// message : "Success"
/// data : [{"benef_account":"1234567890","benef_name":"jasir","benef_ifsc":"12345678DRT"},{"benef_account":"987654321","benef_name":"mohd","benef_ifsc":"12345678RDV"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"9876543210","benef_name":"jasir","benef_ifsc":"CNRB0005630"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123698712","benef_name":"egfd","benef_ifsc":"WTT23563476"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"987654321","benef_name":"mohd","benef_ifsc":"12345678RDV"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123654789","benef_name":"mohd","benef_ifsc":"12345678WER"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"},{"benef_account":"123456789","benef_name":"jasir","benef_ifsc":"123456789DS"}]

/// benef_account : "1234567890"
/// benef_name : "jasir"
/// benef_ifsc : "12345678DRT"

class MobileSearch {
  MobileSearch({
    String? benefAccount,
    String? benefName,
    String? benefIfsc,
    String? mobileNo,
    String? cusName,
  }) {
    _benefAccount = benefAccount;
    _benefName = benefName;
    _benefIfsc = benefIfsc;
    _mobileNo = mobileNo;
    _cusName = cusName;
  }

  MobileSearch.fromJson(dynamic json) {
    _benefAccount = json['benef_account'];
    _benefName = json['benef_name'];
    _benefIfsc = json['benef_ifsc'] ?? '';
    _mobileNo = json['mobile'] ?? '';
    _cusName = json['end_customer_name'] ?? '';
  }
  String? _benefAccount;
  String? _benefName;
  String? _benefIfsc;
  String? _mobileNo;
  String? _cusName;

  String? get benefAccount => _benefAccount;
  String? get benefName => _benefName;
  String? get benefIfsc => _benefIfsc;
  String? get mobileNo => _mobileNo;
  String? get cusName => _cusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['benef_account'] = _benefAccount;
    map['benef_name'] = _benefName;
    map['benef_ifsc'] = _benefIfsc;
    map['mobile'] = _mobileNo;
    map['end_customer_name'] = _cusName;
    return map;
  }
}
