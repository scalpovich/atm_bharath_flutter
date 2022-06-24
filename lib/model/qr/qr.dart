/// status : true
/// message : "Success"
/// data : "upi://pay?pa=atmbharath@barodampay&pn=ANY TIME MONEY PVT LTD(JASIR)&mc=5399&tr=CUS001-3-20220107100634&am=1.00&mode=23&gstIn=&gstBrkUp=0|0|0|0|0|0|0&qrMedium=02&invoiceNo=455&invoiceDate=2022-01-07T00:00:00+05:30&invoiceName=jasir&QRexpire=2022-01-07T10:11:44+05:30&ver=01&orgid=159012&sign=MEUCIEGfof05zw7rGshR/DJ77Fh+eCuK10/kFUNGkZuYsFhwAiEA/LyHns3+sx4fbzD4sHatOVQ/bx5LOFuo8M1q+wvAyPg="

class Qr {
  Qr({
    bool? status,
    String? message,
    String? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Qr.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _status;
  String? _message;
  String? _data;

  bool? get status => _status;
  String? get message => _message;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}
