// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bbps_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BBPSReportAdapter extends TypeAdapter<BBPSReport> {
  @override
  final int typeId = 2;

  @override
  BBPSReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BBPSReport(
      tranType: fields[0] as String?,
      transactionId: fields[1] as num?,
      status: fields[2] as String?,
      statusDescription: fields[3] as String?,
      fromName: fields[4] as String?,
      fromAccount: fields[5] as String?,
      benefAccName: fields[6] as String?,
      benefAccNo: fields[7] as String?,
      benfIfsc: fields[8] as String?,
      transferMode: fields[9] as String?,
      transactionDate: fields[10] as String?,
      amount: fields[11] as String?,
      cgst: fields[12] as String?,
      sgst: fields[13] as String?,
      cess: fields[14] as String?,
      convFee: fields[15] as String?,
      type: fields[16] as String?,
      commissionAmount: fields[17] as String?,
      serviceType: fields[18] as String?,
      endCstmrName: fields[19] as String?,
      endCstmrMob: fields[20] as String?,
      parameterName: fields[21] as String?,
      parameterValue: fields[22] as String?,
      bbpsRefNo: fields[23] as String?,
      billerName: fields[24] as String?,
      billerId: fields[25] as String?,
      isBillerBbps: fields[26] as String?,
      paymentChannel: fields[27] as String?,
      paymentId: fields[28] as String?,
      billerCategory: fields[29] as String?,
      referenceNo: fields[30] as String?,
      authCount: fields[31] as String?,
      billerLogo: fields[32] as String?,
      traceId: fields[33] as String?,
      paramsValue: fields[34] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BBPSReport obj) {
    writer
      ..writeByte(35)
      ..writeByte(0)
      ..write(obj.tranType)
      ..writeByte(1)
      ..write(obj.transactionId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.statusDescription)
      ..writeByte(4)
      ..write(obj.fromName)
      ..writeByte(5)
      ..write(obj.fromAccount)
      ..writeByte(6)
      ..write(obj.benefAccName)
      ..writeByte(7)
      ..write(obj.benefAccNo)
      ..writeByte(8)
      ..write(obj.benfIfsc)
      ..writeByte(9)
      ..write(obj.transferMode)
      ..writeByte(10)
      ..write(obj.transactionDate)
      ..writeByte(11)
      ..write(obj.amount)
      ..writeByte(12)
      ..write(obj.cgst)
      ..writeByte(13)
      ..write(obj.sgst)
      ..writeByte(14)
      ..write(obj.cess)
      ..writeByte(15)
      ..write(obj.convFee)
      ..writeByte(16)
      ..write(obj.type)
      ..writeByte(17)
      ..write(obj.commissionAmount)
      ..writeByte(18)
      ..write(obj.serviceType)
      ..writeByte(19)
      ..write(obj.endCstmrName)
      ..writeByte(20)
      ..write(obj.endCstmrMob)
      ..writeByte(21)
      ..write(obj.parameterName)
      ..writeByte(22)
      ..write(obj.parameterValue)
      ..writeByte(23)
      ..write(obj.bbpsRefNo)
      ..writeByte(24)
      ..write(obj.billerName)
      ..writeByte(25)
      ..write(obj.billerId)
      ..writeByte(26)
      ..write(obj.isBillerBbps)
      ..writeByte(27)
      ..write(obj.paymentChannel)
      ..writeByte(28)
      ..write(obj.paymentId)
      ..writeByte(29)
      ..write(obj.billerCategory)
      ..writeByte(30)
      ..write(obj.referenceNo)
      ..writeByte(31)
      ..write(obj.authCount)
      ..writeByte(32)
      ..write(obj.billerLogo)
      ..writeByte(33)
      ..write(obj.traceId)
      ..writeByte(34)
      ..write(obj.paramsValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BBPSReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
