// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QRReportAdapter extends TypeAdapter<QRReport> {
  @override
  final int typeId = 8;

  @override
  QRReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QRReport(
      tranType: fields[0] as String?,
      transactionId: fields[1] as String?,
      status: fields[2] as String?,
      statusDescription: fields[3] as String?,
      invoiceName: fields[4] as String?,
      invoiceNo: fields[5] as String?,
      invoiceDate: fields[6] as String?,
      transactionDate: fields[7] as String?,
      amount: fields[8] as String?,
      cgst: fields[9] as num?,
      sgst: fields[10] as num?,
      cess: fields[11] as num?,
      gst: fields[12] as num?,
      igst: fields[13] as num?,
      gstPct: fields[14] as num?,
      gstIncentive: fields[15] as num?,
      gstIn: fields[16] as String?,
      payerName: fields[17] as String?,
      paymentChannel: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QRReport obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.tranType)
      ..writeByte(1)
      ..write(obj.transactionId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.statusDescription)
      ..writeByte(4)
      ..write(obj.invoiceName)
      ..writeByte(5)
      ..write(obj.invoiceNo)
      ..writeByte(6)
      ..write(obj.invoiceDate)
      ..writeByte(7)
      ..write(obj.transactionDate)
      ..writeByte(8)
      ..write(obj.amount)
      ..writeByte(9)
      ..write(obj.cgst)
      ..writeByte(10)
      ..write(obj.sgst)
      ..writeByte(11)
      ..write(obj.cess)
      ..writeByte(12)
      ..write(obj.gst)
      ..writeByte(13)
      ..write(obj.igst)
      ..writeByte(14)
      ..write(obj.gstPct)
      ..writeByte(15)
      ..write(obj.gstIncentive)
      ..writeByte(16)
      ..write(obj.gstIn)
      ..writeByte(17)
      ..write(obj.payerName)
      ..writeByte(18)
      ..write(obj.paymentChannel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QRReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
