import 'package:atm_flutter_app/constants/api_constants.dart';
import 'package:intl/intl.dart';

//money transfer report body
Future<dynamic> moneyTransferReportBody(
    {required DateTime startDate,
    required DateTime endDate,
    required String sync,
    int? pageNo,
    String? searchText}) async {
  dynamic body = {
    aStartDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate).toString(),
    aEndDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate).toString(),
    aPageNo: pageNo ?? '',
    aSync: sync,
    aSearchText: searchText,
  };
  return body;
}

Future<dynamic> syncReportBody(
    {required DateTime startDate,
    required DateTime endDate,
    required String sync}) async {
  dynamic body = {
    aStartDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate).toString(),
    aEndDate: DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate).toString(),
    aSync: sync
  };
  return body;
}

Future<dynamic> bbpsBillerBody({required String categoryName}) async {
  dynamic body = {aCategory: categoryName};
  return body;
}

Future<dynamic> qrCodeGenerateBody(
    {required String transactionId,
    required String transactionDate,
    required String amount,
    String? invoiceNo,
    String? invoiceDate,
    String? invoiceName,
    String? gst,
    String? gstIn,
    String? cess,
    String? cgst,
    String? sgst,
    String? igst,
    String? gstIncentive,
    String? gstPct}) async {
  dynamic body = {
    'transaction_id': transactionId,
    'transaction_date': transactionDate,
    'amount': amount,
    'status': '',
    'payer_name': '',
    'invoice_no': invoiceNo ?? '',
    'invoice_date': invoiceDate ?? '',
    'invoice_name': invoiceName ?? '',
    'gst': gst ?? '',
    'gst_in': gstIn ?? '',
    'cess': cess ?? '',
    'cgst': cgst ?? '',
    'sgst': sgst ?? '',
    'igst': igst ?? '',
    'gst_incentive': gstIncentive ?? '',
    'gst_pct': gstPct ?? '',
  };
  return body;
}

Future<dynamic> addTransactionBody(
    {required String cusMob,
    required String cusName,
    required String benefName,
    required String benefAccNo,
    required String ifscCode,
    required String amount,
    required String purpose,
    required String mode,
    String? imageUrl}) async {
  dynamic body = {
    'end_customer_mob': cusMob,
    'end_customer_name': cusName,
    'b_name': benefName,
    'b_accno': benefAccNo,
    'payment_mode': mode,
    'b_ifsc_code': ifscCode,
    'amount': amount,
    'purpose': purpose,
    'image_Url': imageUrl ?? '',
  };
  return body;
}

// Future<dynamic> bbpsPaymentValidationBody(
//     {required String billerId,
//     required String senderName,
//     required String circleName,
//     String? imageUrl,
//     required dynamic additionalValidation,
//     required dynamic authenticators,
//     required String paymentAmount,
//     required String mobileNo,
//     required String geocode,
//     required String postalCode,
//     required String mac,
//     required String ip,
//     required String isBBPS,
//     required String billerCategory}) async {
//   dynamic body = {
//     'biller_id': billerId,
//     'sender_name': senderName,
//     'circle_name': circleName,
//     'image_url': '',
//     'additional_validations': additionalValidation,
//     'authenticators': authenticators,
//     'payment_amount': paymentAmount,
//     'mobile': mobileNo,
//     'geocode': geocode,
//     'postal_code': postalCode,
//     'mac': mac,
//     'ip': ip,
//     'is_bbps': isBBPS,
//     'biller_category': billerCategory
//   };
//   return body;
// }
