/// status : true
/// message : "Success"
/// data : [{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0002252","BRANCH":"KALLAI ROAD,KOZHIKODE","ADDRESS":"DIST KOZHIKODE, KERALA, PIN 673003","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0020735","BRANCH":"KOZHIKODE","ADDRESS":"AAAUAOAATAXUJAWAHAAAOOYAHPAAPOTOFFAUT","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0071238","BRANCH":"MCB KOZHIKODE","ADDRESS":"PBNO150THAVOTPLACEKANNURROADKOZHIKODEDISTKERALA673001","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0008268","BRANCH":"THIRUVANNUR KOZHIKODE","ADDRESS":"22 BY 361,COTTON MILL ROAD,PIN673029","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0010766","BRANCH":"CLEARING CPC, KOZHIKODE","ADDRESS":"DIST KOZHIKODESTATE KERALA","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0070520","BRANCH":"ZONAL OFFICE, KOZHIKODE","ADDRESS":"JUBILEEBHAVAN,MINIBYPASS,ERANHIPALAM,KOZHIKODE-673006673006ZOKKDATSBTCOIN","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0070653","BRANCH":"SERVICEBRANCHKOZHIKODE","ADDRESS":"THAVOT PLACE, III FLOOR, KANNUR ROAD, KOZHIKODE, P.O. 673001","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0070758","BRANCH":"PSBKOZHIKODE","ADDRESS":"BLDGNO282453B,CLOCKTOWER,MAVOORROAD,POTTAMMAL,CALICUT673016PSBKKDATSBTCOIN","DISTRICT":"KOZHIKODE","STATE":"KERALA"},{"BANK":"STATE BANK OF INDIA","IFSC":"SBIN0070905","BRANCH":"RASMECC,KOZHIKODE","ADDRESS":"THAVOTPLACE,2NDFLOORKANNURROADKOZHIKODE,KOZHIKODEKERALA,673001","DISTRICT":"KOZHIKODE","STATE":"KERALA"}]

/// BANK : "STATE BANK OF INDIA"
/// IFSC : "SBIN0002252"
/// BRANCH : "KALLAI ROAD,KOZHIKODE"
/// ADDRESS : "DIST KOZHIKODE, KERALA, PIN 673003"
/// DISTRICT : "KOZHIKODE"
/// STATE : "KERALA"

class IFSC {
  IFSC({
    String? bank,
    String? ifsc,
    String? branch,
    String? address,
    String? district,
    String? state,
  }) {
    _bank = bank;
    _ifsc = ifsc;
    _branch = branch;
    _address = address;
    _district = district;
    _state = state;
  }

  IFSC.fromJson(dynamic json) {
    _bank = json['BANK'];
    _ifsc = json['IFSC'];
    _branch = json['BRANCH'];
    _address = json['ADDRESS'];
    _district = json['DISTRICT'];
    _state = json['STATE'];
  }
  String? _bank;
  String? _ifsc;
  String? _branch;
  String? _address;
  String? _district;
  String? _state;

  String? get bank => _bank;
  String? get ifsc => _ifsc;
  String? get branch => _branch;
  String? get address => _address;
  String? get district => _district;
  String? get state => _state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BANK'] = _bank;
    map['IFSC'] = _ifsc;
    map['BRANCH'] = _branch;
    map['ADDRESS'] = _address;
    map['DISTRICT'] = _district;
    map['STATE'] = _state;
    return map;
  }
}
