import 'dart:convert';

import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';

import '../../helper/prefManager.dart';
import '../../utils/aes_encryption.dart';
import '../../utils/api_req_res_format.dart';

dynamic bbpsPaymentValidationBody(
    {required String billerId,
    required String senderName,
    required String circleName,
    String? imageUrl,
    dynamic additionalValidation,
    required dynamic authenticators,
    required String paymentAmount,
    required String mobileNo,
    required String geocode,
    required String postalCode,
    required String mac,
    required String ip,
    required String isBBPS,
    required String billerCategory}) async {
  dynamic body = {};
  if (additionalValidation == null) {
    body = {
      'biller_id': billerId,
      'sender_name': senderName,
      'circle_name': circleName,
      'image_url': '',
      'authenticators': authenticators,
      'payment_amount': paymentAmount,
      'mobile': mobileNo,
      'geocode': geocode,
      'postal_code': postalCode,
      'mac': mac,
      'ip': ip,
      'is_bbps': isBBPS,
      'biller_category': billerCategory
    };
  } else {
    body = {
      'biller_id': billerId,
      'sender_name': senderName,
      'circle_name': circleName,
      'image_url': '',
      'additional_validations': additionalValidation,
      'authenticators': authenticators,
      'payment_amount': paymentAmount,
      'mobile': mobileNo,
      'geocode': geocode,
      'postal_code': postalCode,
      'mac': mac,
      'ip': ip,
      'is_bbps': isBBPS,
      'biller_category': billerCategory
    };
  }
  Log().logs('body--', body.toString());
  return body;
}

Future<dynamic> bbpsValidateBillerBody(
    {required String billerId,
    required dynamic authenticators,
    required String latLng,
    required String postalCode,
    required String macAddress,
    required String ipAddress,
    required String mobileNo,
    required String isBBPS,
    required String billerCategory}) async {
  dynamic body = {
    'biller_id': billerId,
    'authenticators': authenticators,
    'geocode': latLng,
    'postal_code': postalCode,
    'mac': macAddress,
    'ip': ipAddress,
    'mobile': mobileNo,
    'is_bbps': isBBPS,
    'biller_category': billerCategory
  };
  return body;
}

Future<dynamic> bbpsValidatePay(
    {required String billerId,
    required String senderName,
    String? imageUrl,
    required dynamic authenticators,
    required String paymentAmount,
    required String mobileNo,
    required String geocode,
    required String postalCode,
    required String mac,
    required String ip,
    required String isBBPS,
    required String billerCategory}) async {
  dynamic body = {
    'biller_id': billerId,
    'sender_name': senderName,
    'image_url': '',
    'authenticators': authenticators,
    'payment_amount': paymentAmount,
    'mobile': mobileNo,
    'geocode': geocode,
    'postal_code': postalCode,
    'mac': mac,
    'ip': ip,
    'is_bbps': isBBPS,
    'biller_category': billerCategory
  };
  Log().logs('body--', body.toString());
  return body;
}

// dynamic bbps
