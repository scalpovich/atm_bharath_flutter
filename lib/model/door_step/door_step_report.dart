import 'package:hive/hive.dart';

part 'door_step_report.g.dart';

@HiveType(typeId: 5)
class DoorStepReports extends HiveObject {
  @HiveField(0)
  int? orderId;
  @HiveField(1)
  String? orderDate;
  @HiveField(2)
  String? orderTime;
  @HiveField(3)
  String? endTime;
  @HiveField(4)
  String? addressType;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? buildingType;
  @HiveField(7)
  String? landmark;
  @HiveField(8)
  String? latitude;
  @HiveField(9)
  String? longitude;
  @HiveField(10)
  String? orderStatus;
  List<Product>? product;

  DoorStepReports(
      {this.orderId,
      this.orderDate,
      this.orderTime,
      this.endTime,
      this.addressType,
      this.address,
      this.buildingType,
      this.landmark,
      this.latitude,
      this.longitude,
      this.orderStatus,
      this.product});

  factory DoorStepReports.fromJson(dynamic json) => DoorStepReports(
        orderId: json['orderId'].toInt(),
        orderDate: json['order_date'],
        orderTime: json['order_time'],
        endTime: json['end_time'],
        addressType: json['address_type'],
        address: json['full_address'],
        buildingType: json['building_type'],
        landmark: json['landmark'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        orderStatus: json['order_status'],
        product:
            List<Product>.from(json['product'].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'order_date': orderDate,
        'order_time': orderTime,
        'end_time': endTime,
        'address_type': addressType,
        'full_address': address,
        'building_type': buildingType,
        'landmark': landmark,
        'latitude': latitude,
        'longitude': longitude,
        'order_status': orderStatus,
        'product': List<dynamic>.from(product!.map((v) => v.toJson())),
      };
}

class Product {
  Product({
    String? productName,
    String? amount,
    String? imageName,
    String? cartId,
  }) {
    _productName = productName;
    _amount = amount;
    _imageName = imageName;
    _cartId = cartId;
  }

  Product.fromJson(dynamic json) {
    _productName = json['product_name'];
    _amount = json['amount'];
    _imageName = json['image_name'];
    _cartId = json['cart_id'];
  }

  String? _productName;
  String? _amount;
  String? _imageName;
  String? _cartId;

  String? get productName => _productName;
  String? get amount => _amount;
  String? get imageName => _imageName;
  String? get cartId => _cartId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name'] = _productName;
    map['amount'] = _amount;
    map['image_name'] = _imageName;
    map['cart_id'] = _cartId;
    return map;
  }
}
