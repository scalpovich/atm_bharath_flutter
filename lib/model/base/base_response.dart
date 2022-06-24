class BaseResponse {
  BaseResponse({
    bool? status,
    String? message,
    dynamic data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  BaseResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _status;
  String? _message;
  dynamic _data;

  bool? get status => _status;
  String? get message => _message;
  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}
