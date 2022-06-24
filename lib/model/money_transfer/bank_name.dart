import 'package:hive/hive.dart';

part 'bank_name.g.dart';

/// status : true
/// message : "Success"
/// data : [{"bank_name":"BANK OF MAHARASHTRA"},{"bank_name":"BHAGINI NIVEDITA SAHAKARI BANK LTD PUNE"},{"bank_name":"BHARAT COOPERATIVE BANK MUMBAI LIMITED"},{"bank_name":"CENTRAL BANK OF INDIA"},{"bank_name":"EXPORT IMPORT BANK OF INDIA"},{"bank_name":"FIRST ABU DHABI BANK PJSC"},{"bank_name":"G P PARSIK BANK"},{"bank_name":"IDBI BANK"},{"bank_name":"INDIAN OVERSEAS BANK"},{"bank_name":"INDUSTRIAL AND COMMERCIAL BANK OF CHINA LIMITED"},{"bank_name":"JALGAON JANATA SAHAKARI BANK LIMITED"},{"bank_name":"JANATA SAHAKARI BANK LIMITED"},{"bank_name":"KARNATAKA GRAMIN BANK"},{"bank_name":"NUTAN NAGARIK SAHAKARI BANK LIMITED"},{"bank_name":"RAJARSHI SHAHU SAHAKARI BANK LTD  PUNE"},{"bank_name":"SBM BANK INDIA LIMITED"},{"bank_name":"SOCIETE GENERALE"},{"bank_name":"STATE BANK OF INDIA"},{"bank_name":"SUTEX COOPERATIVE BANK LIMITED"},{"bank_name":"SYNDICATE BANK"},{"bank_name":"Shivalik Small Finance Bank Limited"},{"bank_name":"Suco Souharda Sahakari Bank Ltd"},{"bank_name":"THE A.P. MAHESH COOPERATIVE URBAN BANK LIMITED"},{"bank_name":"THE COSMOS CO OPERATIVE BANK LIMITED"},{"bank_name":"THE SURAT DISTRICT COOPERATIVE BANK LIMITED"},{"bank_name":"THE TAMIL NADU STATE APEX COOPERATIVE BANK"},{"bank_name":"THE UDAIPUR URBAN CO OPERATIVE BANK LTD"},{"bank_name":"THE VISHWESHWAR SAHAKARI BANK LIMITED"},{"bank_name":"THE ZOROASTRIAN COOPERATIVE BANK LIMITED"},{"bank_name":"AKOLA JANATA COMMERCIAL COOPERATIVE BANK"},{"bank_name":"APNA SAHAKARI BANK LIMITED"},{"bank_name":"CITI BANK"},{"bank_name":"DCB BANK LIMITED"},{"bank_name":"DEPOSIT INSURANCE AND CREDIT GUARANTEE CORPORATION"},{"bank_name":"FIRSTRAND BANK LIMITED"},{"bank_name":"JANAKALYAN SAHAKARI BANK LIMITED"},{"bank_name":"KALLAPPANNA AWADE ICHALKARANJI JANATA SAHAKARI BANK LIMITED"},{"bank_name":"KERALA GRAMIN BANK"},{"bank_name":"MASHREQBANK PSC"},{"bank_name":"MIZUHO BANK LTD"},{"bank_name":"Mahesh Sahakari Bank Ltd Pune"},{"bank_name":"NORTH EAST SMALL FINANCE BANK LIMITED"},{"bank_name":"PUNJAB NATIONAL BANK"},{"bank_name":"SANT SOPANKAKA SAHAKARI BANK LTD"},{"bank_name":"SREE CHARAN SOUHARDHA CO OPERATIVE BANK LTD"},{"bank_name":"SUMITOMO MITSUI BANKING CORPORATION"},{"bank_name":"THE MEHSANA URBAN COOPERATIVE BANK"},{"bank_name":"THE SEVA VIKAS COOPERATIVE BANK LIMITED"},{"bank_name":"THE SHAMRAO VITHAL COOPERATIVE BANK"},{"bank_name":"THE THANE BHARAT SAHAKARI BANK LIMITED"},{"bank_name":"The Pusad Urban Cooperative Bank Ltd Pusad"},{"bank_name":"Ujjivan Small Finance Bank Limited"},{"bank_name":"VIJAYA BANK"},{"bank_name":"AHMEDABAD MERCANTILE COOPERATIVE BANK"},{"bank_name":"AMBARNATH JAIHIND COOP BANK LTD AMBARNATH"},{"bank_name":"AU SMALL FINANCE BANK LIMITED"},{"bank_name":"BANDHAN BANK LIMITED"},{"bank_name":"BANK OF BARODA"},{"bank_name":"BARCLAYS BANK"},{"bank_name":"CITIZEN CREDIT COOPERATIVE BANK LIMITED"},{"bank_name":"CORPORATION BANK"},{"bank_name":"EQUITAS SMALL FINANCE BANK LIMITED"},{"bank_name":"INDIAN BANK"},{"bank_name":"MUFG BANK, LTD"},{"bank_name":"NAV JEEVAN CO OP BANK LTD"},{"bank_name":"NKGSB COOPERATIVE BANK LIMITED"},{"bank_name":"PUNJAB AND SIND BANK"},{"bank_name":"RAJARAMBAPU SAHAKARI BANK LIMITED"},{"bank_name":"RAJASTHAN MARUDHARA GRAMIN BANK"},{"bank_name":"RESERVE BANK OF INDIA"},{"bank_name":"SHIKSHAK SAHAKARI BANK LIMITED"},{"bank_name":"SHRI CHHATRAPATI RAJASHRI SHAHU URBAN COOPERATIVE BANK LIMITED"},{"bank_name":"THE MUMBAI DISTRICT CENTRAL COOPERATIVE BANK LIMITED"},{"bank_name":"THE NAINITAL BANK LIMITED"},{"bank_name":"THE RAJASTHAN STATE COOPERATIVE BANK LIMITED"},{"bank_name":"The Vijay Co Operative Bank Limited"},{"bank_name":"AIRTEL PAYMENTS BANK LIMITED"},{"bank_name":"BANK OF INDIA"},{"bank_name":"CAPITAL SMALL FINANCE BANK LIMITED"},{"bank_name":"CITY UNION BANK LIMITED"},{"bank_name":"DEUSTCHE BANK"},{"bank_name":"DHANALAKSHMI BANK"},{"bank_name":"DURGAPUR STEEL PEOPLES CO-OPERATIVE BANK LTD"},{"bank_name":"ESAF SMALL FINANCE BANK LIMITED"},{"bank_name":"HARYANA STATE COOPERATIVE BANK"}]

/// bank_name : "BANK OF MAHARASHTRA"

// class BankName extends HiveObject {
//   BankName({@HiveField(1) String? bankName}) {
//     _bankName = bankName;
//   }
//
//   BankName.fromJson(dynamic json) {
//     _bankName = json['bank_name'];
//   }
//   String? _bankName;
//
//   String? get bankName => _bankName;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['bank_name'] = _bankName;
//     return map;
//   }
// }

// List<BankName> bankNameFromJson(String str) => List<BankName>.from(json.decode(str).map((x) => BankName.fromJson(x)));
//
// String bankNameToJson(List<BankName> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class BankName extends HiveObject {
  BankName({
    required this.bankName,
  });

  @HiveField(0)
  String bankName;

  factory BankName.fromJson(dynamic json) => BankName(
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "bank_name": bankName,
      };
}
