/// status : true
/// message : "success"
/// data : [{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL3013GM07","talktime":"NA","amount":"301.00","validity":"NA","plan_description":"Enjoy 50 GB and 1 year of Wynk Music Premium subscription, Validity same as your existing bundle/smart pack","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"3G/4G Data","circleid":"11","top_plan":"N"},{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL1483GM07","talktime":"NA","amount":"148.00","validity":"NA","plan_description":"Xstream Mobile Data Pack 15GB data, 28 day access to any 1 channel (SonyLiv, LionsgatePlay, ErosNow, HoiChoi, ManoramaMAX) on Airtel Xstream App at no extra cost, Validity same as your existing bundle/smart pack","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"3G/4G Data","circleid":"11","top_plan":"Y"},{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL583GM07","talktime":"NA","amount":"58.00","validity":"NA","plan_description":"Enjoy 3GB data valid till your Current Pack Validity","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"3G/4G Data","circleid":"11","top_plan":"Y"},{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL983GM07","talktime":"NA","amount":"98.00","validity":"NA","plan_description":"Wynk Premium Data Pack, 5GB data, 30 day of Wynk Premium subscription","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"3G/4G Data","circleid":"11","top_plan":"Y"},{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL1183GM07","talktime":"NA","amount":"118.00","validity":"NA","plan_description":"12 GB, Validity same as your existing bundle /smart pack","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"3G/4G Data","circleid":"11","top_plan":"Y"},{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL1083GM07","talktime":"NA","amount":"108.00","validity":"NA","plan_description":"PVME Data Pack, 6GB data, 28 day of Prime Video Mobile Edition subscription","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"3G/4G Data","circleid":"11","top_plan":"Y"},{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL18ISD07","talktime":"NA","amount":"18.00","validity":"28","plan_description":"Enjoy ISD Calling at Discounted Rates for 28 day. For Country wise tariff visit www.airtel.in","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"ISD Packs","circleid":"11","top_plan":"Y"},{"objectid":"plan","billerid":"AIRTELPRE","biller_category":"Mobile Prepaid","biller_name":"Airtel Prepaid","plan_created_on":"07-01-2022 01:05:17","planid":"ATLPKRL14998ROM07","talktime":"NA","amount":"14998.00","validity":"365","plan_description":"Unlimited incoming 7200 mins India calls 100 sms, Covered Countries : Australia Canada China Friance Japan Singapore USA UK and more","circle_name":"Kerala","plan_status":"ACTIVE","plan_category_name":"Roaming","circleid":"11","top_plan":"N"}]

/// objectid : "plan"
/// billerid : "AIRTELPRE"
/// biller_category : "Mobile Prepaid"
/// biller_name : "Airtel Prepaid"
/// plan_created_on : "07-01-2022 01:05:17"
/// planid : "ATLPKRL3013GM07"
/// talktime : "NA"
/// amount : "301.00"
/// validity : "NA"
/// plan_description : "Enjoy 50 GB and 1 year of Wynk Music Premium subscription, Validity same as your existing bundle/smart pack"
/// circle_name : "Kerala"
/// plan_status : "ACTIVE"
/// plan_category_name : "3G/4G Data"
/// circleid : "11"
/// top_plan : "N"

class MobilePlans {
  MobilePlans({
    this.objectid,
    this.billerid,
    this.billerCategory,
    this.billerName,
    this.planCreatedOn,
    this.planid,
    this.talktime,
    this.amount,
    this.validity,
    this.planDescription,
    this.circleName,
    this.planStatus,
    this.planCategoryName,
    this.circleid,
    this.topPlan,
  });

  String? objectid;
  String? billerid;
  String? billerCategory;
  String? billerName;
  String? planCreatedOn;
  String? planid;
  String? talktime;
  String? amount;
  String? validity;
  String? planDescription;
  String? circleName;
  String? planStatus;
  String? planCategoryName;
  String? circleid;
  String? topPlan;

  factory MobilePlans.fromJson(Map<String, dynamic> json) => MobilePlans(
        objectid: json["objectid"],
        billerid: json["billerid"],
        billerCategory: json["biller_category"],
        billerName: json["biller_name"],
        planCreatedOn: json["plan_created_on"],
        planid: json["planid"],
        talktime: json["talktime"],
        amount: json["amount"],
        validity: json["validity"],
        planDescription: json["plan_description"],
        circleName: json["circle_name"],
        planStatus: json["plan_status"],
        planCategoryName: json["plan_category_name"],
        circleid: json["circleid"],
        topPlan: json["top_plan"],
      );

  Map<String, dynamic> toJson() => {
        "objectid": objectid,
        "billerid": billerid,
        "biller_category": billerCategory,
        "biller_name": billerName,
        "plan_created_on": planCreatedOn,
        "planid": planid,
        "talktime": talktime,
        "amount": amount,
        "validity": validity,
        "plan_description": planDescription,
        "circle_name": circleName,
        "plan_status": planStatus,
        "plan_category_name": planCategoryName,
        "circleid": circleid,
        "top_plan": topPlan,
      };
}
