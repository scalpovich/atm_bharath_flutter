/// status : true
/// message : "Success"
/// data : {"customer_name":"ANY TIME MONEY PVT LTD(JASIR)","wallet_amount":"996462","customer_address1":"Aadarsh Arcade, L1/1353 (1), 2nd Floor, ","customer_address2":"Opp. Railway Muthappan Temple, Thavakkara Road, Kannur","customer_email":"hr@techlogica.com","customer_mob":"9988776655","locking_amount":"1000","active":"Y","GST":"V455577FF65","door_step_agent":"Y","customer_code":"CUS001","Services":[{"serviceName":"Door Step","passWord":null},{"serviceName":"QR","passWord":null},{"serviceName":"Money Transfer","passWord":null},{"serviceName":"BBPS","passWord":null}]}

/// customer_name : "ANY TIME MONEY PVT LTD(JASIR)"
/// wallet_amount : "996462"
/// customer_address1 : "Aadarsh Arcade, L1/1353 (1), 2nd Floor, "
/// customer_address2 : "Opp. Railway Muthappan Temple, Thavakkara Road, Kannur"
/// customer_email : "hr@techlogica.com"
/// customer_mob : "9988776655"
/// locking_amount : "1000"
/// active : "Y"
/// GST : "V455577FF65"
/// door_step_agent : "Y"
/// customer_code : "CUS001"
/// Services : [{"serviceName":"Door Step","passWord":null},{"serviceName":"QR","passWord":null},{"serviceName":"Money Transfer","passWord":null},{"serviceName":"BBPS","passWord":null}]

class LoginResponse {
  LoginResponse({
    String? customerName,
    String? walletAmount,
    String? customerAddress1,
    String? customerAddress2,
    String? customerEmail,
    String? customerMob,
    String? lockingAmount,
    String? active,
    String? gst,
    String? doorStepAgent,
    String? customerCode,
    String? driverName,
    String? driverCode,
    String? driverStatus,
    List<Services>? services,
  }) {
    _customerName = customerName;
    _walletAmount = walletAmount;
    _customerAddress1 = customerAddress1;
    _customerAddress2 = customerAddress2;
    _customerEmail = customerEmail;
    _customerMob = customerMob;
    _lockingAmount = lockingAmount;
    _active = active;
    _gst = gst;
    _doorStepAgent = doorStepAgent;
    _customerCode = customerCode;
    _driverName = driverName;
    _driverCode = driverCode;
    _driverStatus = driverStatus;
    _services = services;
  }

  LoginResponse.fromJson(dynamic json) {
    _customerName = json['customer_name'];
    _walletAmount = json['wallet_amount'];
    _customerAddress1 = json['customer_address1'];
    _customerAddress2 = json['customer_address2'];
    _customerEmail = json['customer_email'];
    _customerMob = json['customer_mob'];
    _lockingAmount = json['locking_amount'];
    _active = json['active'];
    _gst = json['GST'];
    _doorStepAgent = json['door_step_agent'];
    _customerCode = json['customer_code'];
    _driverName = json['driver_name'];
    _driverCode = json['driver_code'];
    _driverStatus = json['onduty'];
    if (json['Services'] != null) {
      _services = [];
      json['Services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }
  String? _customerName;
  String? _walletAmount;
  String? _customerAddress1;
  String? _customerAddress2;
  String? _customerEmail;
  String? _customerMob;
  String? _lockingAmount;
  String? _active;
  String? _gst;
  String? _doorStepAgent;
  String? _customerCode;
  String? _driverName;
  String? _driverCode;
  String? _driverStatus;
  List<Services>? _services;

  String? get customerName => _customerName;
  String? get walletAmount => _walletAmount;
  String? get customerAddress1 => _customerAddress1;
  String? get customerAddress2 => _customerAddress2;
  String? get customerEmail => _customerEmail;
  String? get customerMob => _customerMob;
  String? get lockingAmount => _lockingAmount;
  String? get active => _active;
  String? get gst => _gst;
  String? get doorStepAgent => _doorStepAgent;
  String? get customerCode => _customerCode;
  String? get driverName => _driverName;
  String? get driverCode => _driverCode;
  String? get driverStatus => _driverStatus;
  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_name'] = _customerName;
    map['wallet_amount'] = _walletAmount;
    map['customer_address1'] = _customerAddress1;
    map['customer_address2'] = _customerAddress2;
    map['customer_email'] = _customerEmail;
    map['customer_mob'] = _customerMob;
    map['locking_amount'] = _lockingAmount;
    map['active'] = _active;
    map['GST'] = _gst;
    map['door_step_agent'] = _doorStepAgent;
    map['customer_code'] = _customerCode;
    map['driver_name'] = _driverName;
    map['driver_code'] = _driverCode;
    map['onduty'] = _driverStatus;
    if (_services != null) {
      map['Services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// serviceName : "Door Step"
/// passWord : null

class Services {
  Services({
    String? serviceName,
    dynamic passWord,
  }) {
    _serviceName = serviceName;
    _passWord = passWord;
  }

  Services.fromJson(dynamic json) {
    _serviceName = json['serviceName'];
    _passWord = json['passWord'];
  }
  String? _serviceName;
  dynamic _passWord;

  String? get serviceName => _serviceName;
  dynamic get passWord => _passWord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceName'] = _serviceName;
    map['passWord'] = _passWord;
    return map;
  }
}
