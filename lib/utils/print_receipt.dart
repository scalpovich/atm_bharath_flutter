import 'dart:typed_data';

import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class PrintReceipt {
  String customerName = PrefManager().getCustomerName.toString();
  String shopAddress1 = PrefManager().getShopAddress.toString();
  String shopAddress2 = PrefManager().getShopAddressLine.toString();
  String gstn = PrefManager().getShopGstNo.toString();
  String customerEmail = PrefManager().getCustomerEmail.toString();
  String customerMobile = PrefManager().getCustomerMobile.toString();
  String currentDate =
      DateFormat('dd/MM/yyyy  HH:mm:ss').format(DateTime.now()).toString();
  void moneyTransferReceiptPrint(String name, String accNo, String ifscCode,
      String transfermode, String purpose, String amount) async {
    Uint8List byte = await _getImageFromAsset('assets/icons/sign.png');
    Uint8List byte2 = await _getImageFromAsset('assets/icons/thank_you.png');
    Log().logs('image--', byte.toString());
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('  ' + customerName,
        style: SunmiStyle(
            bold: true,
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.LG));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(shopAddress1,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText(' ' + shopAddress2,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Email: $customerEmail',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Contact: $customerMobile',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('GSTN: $gstn',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Date: $currentDate',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Name: $name',
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('AccNo: $accNo',
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.MD,
        ));
    await SunmiPrinter.printText('IFSC: $ifscCode',
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.MD,
        ));
    await SunmiPrinter.printText('Transfer Mode: $transfermode',
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.MD,
        ));
    await SunmiPrinter.printText('Purpose: $purpose',
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.MD,
        ));
    await SunmiPrinter.printText(
        AppStrings.txtAmount + '     ' + 'rupee'.tr + ': ' + amount,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printImage(byte);
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.printImage(byte2);
    await SunmiPrinter.lineWrap(4);
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }

  void moneyTransferTransactionReceiptPrint(String name, String accNo,
      String date, String transNo, String transferMode, String amount) async {
    Uint8List byte = await _getImageFromAsset('assets/icons/sign.png');
    Uint8List byte2 = await _getImageFromAsset('assets/icons/thank_you.png');
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('  ' + customerName,
        style: SunmiStyle(
            bold: true,
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.LG));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(shopAddress1,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText(' ' + shopAddress2,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Email: $customerEmail',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Contact: $customerMobile',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('GSTN: $gstn',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Date: $currentDate',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(AppStrings.txtName + ': ' + name,
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.LG,
        ));
    await SunmiPrinter.printText(AppStrings.txtAccNo + accNo,
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.LG,
        ));
    await SunmiPrinter.printText(AppStrings.txtTransactionNo + ': ' + transNo,
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.LG,
        ));
    await SunmiPrinter.printText(AppStrings.txtTransactionDate + ': ' + date,
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.LG,
        ));
    await SunmiPrinter.printText(
        AppStrings.txtTransferMode + ': ' + transferMode,
        style: SunmiStyle(
          align: SunmiPrintAlign.LEFT,
          fontSize: SunmiFontSize.LG,
        ));
    await SunmiPrinter.printText(
        AppStrings.txtAmount + '     ' + 'rupee'.tr + ': ' + amount,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.LG,
            bold: true));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printImage(byte);
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.printImage(byte2);
    await SunmiPrinter.lineWrap(4);
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes(iconPath);
  }

  void qrCodePrint(Uint8List data, String amount) async {
    Log().logs('reached--', '-----------+++');
    Uint8List byte2 = await _getImageFromAsset('assets/icons/thank_you.png');
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('  ' + customerName,
        style: SunmiStyle(
            bold: true,
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.LG));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(shopAddress1,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText(' ' + shopAddress2,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Email: $customerEmail',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Contact: $customerMobile',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('GSTN: $gstn',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Date: $currentDate',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('QR Code',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.XL));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printImage(data);
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Rs:  ' + 'rupee'.tr + amount,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.XL));
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.printImage(byte2);
    await SunmiPrinter.lineWrap(4);
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }

  void qrReceiptPrint(
      String amount,
      String invoiceName,
      String invoiceNo,
      String invoiceDate,
      String gstIn,
      String gst,
      String cgst,
      String igst,
      String sgst,
      String cess,
      String gstIncentive,
      String gstPct) async {
    Log().logs('cgst', cgst);
    Log().logs('igst', igst);
    Log().logs('sgst', sgst);
    Log().logs('cess', cess);
    Log().logs('gstIncentive', gstIncentive);
    Log().logs('gstPCT', gstPct);
    Uint8List byte2 = await _getImageFromAsset('assets/icons/thank_you.png');
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText('  ' + customerName,
        style: SunmiStyle(
            bold: true,
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.LG));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(shopAddress1,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText(' ' + shopAddress2,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Email: $customerEmail',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Contact: $customerMobile',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('GSTN: $gstn',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Date: $currentDate',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('QR Code Receipt',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.XL));
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.printText('Invoice Name:' + invoiceName,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Invoice No:' + invoiceNo,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Invoice Date:' + invoiceDate,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('GST:' + gst,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('GST In:' + gstIn,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    if (cgst != '0') {
      await SunmiPrinter.printText('CGST:' + cgst,
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(1);
    }
    if (igst != '0') {
      await SunmiPrinter.printText('IGST:' + igst,
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(1);
    }
    if (sgst != '0') {
      await SunmiPrinter.printText('SGST:' + sgst,
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(1);
    }
    if (cess != '0') {
      await SunmiPrinter.printText('CESS:' + cess,
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(1);
    }
    if (gstIncentive != '0') {
      await SunmiPrinter.printText('GST Incentive:' + gstIncentive,
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(1);
    }
    if (gstPct != '0') {
      await SunmiPrinter.printText('GST Pct:' + gstPct,
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(1);
    }
    await SunmiPrinter.printText('Received Amount: ' + 'rupee'.tr + amount,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.printImage(byte2);
    await SunmiPrinter.lineWrap(4);
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }

  void bbpsReceiptPrint(
      String transactionId,
      String cusMobile,
      String parameterName,
      String parameterValue,
      String bbpsRefNo,
      String billerName,
      String billerId,
      String billDate,
      double convFee,
      String amount,
      String paymentChannel) async {
    Uint8List byte = await _getImageFromAsset('assets/icons/b_assured.png');
    Uint8List byte2 = await _getImageFromAsset('assets/icons/thank_you.png');
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printImage(byte);
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('  ' + customerName,
        style: SunmiStyle(
            bold: true,
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.LG));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(shopAddress1,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText(' ' + shopAddress2,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Email: $customerEmail',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Contact: $customerMobile',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('GSTN: $gstn',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Date: $currentDate',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('Pay. Id: ' + transactionId,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Sender Info: ' + cusMobile,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText(parameterName + ': ' + parameterValue,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('BBPS Ref No: ' + bbpsRefNo,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Biller Name: ' + billerName,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Biller Id: ' + billerId,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Bill Date: ' + billDate,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    if (convFee != 0) {
      await SunmiPrinter.printText('Bill Amount: ' + amount,
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.printText('Convenience Fee: ' + convFee.toString(),
          style: SunmiStyle(
              align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    }
    await SunmiPrinter.printText('Payment Channel: ' + paymentChannel,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('Payment Mode: Cash/' + paymentChannel,
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText(
        'Rs. ' + 'rupee'.tr + ' ' + double.tryParse(amount).toString(),
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT, fontSize: SunmiFontSize.XL));
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.printImage(byte2);
    await SunmiPrinter.lineWrap(4);
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}
