// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bbps_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BBPSCategoryAdapter extends TypeAdapter<BBPSCategory> {
  @override
  final int typeId = 1;

  @override
  BBPSCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BBPSCategory(
      billerId: fields[0] as String?,
      billerName: fields[1] as String?,
      billerCategory: fields[2] as String?,
      billerLogo: fields[3] as String?,
      fetchBill: fields[4] as String?,
      partialPay: fields[5] as String?,
      onlineValidation: fields[6] as String?,
      isBillerBBPS: fields[7] as String?,
      authenticators: (fields[8] as List?)?.cast<Authenticator>(),
    );
  }

  @override
  void write(BinaryWriter writer, BBPSCategory obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.billerId)
      ..writeByte(1)
      ..write(obj.billerName)
      ..writeByte(2)
      ..write(obj.billerCategory)
      ..writeByte(3)
      ..write(obj.billerLogo)
      ..writeByte(4)
      ..write(obj.fetchBill)
      ..writeByte(5)
      ..write(obj.partialPay)
      ..writeByte(6)
      ..write(obj.onlineValidation)
      ..writeByte(7)
      ..write(obj.isBillerBBPS)
      ..writeByte(8)
      ..write(obj.authenticators);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BBPSCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AuthenticatorAdapter extends TypeAdapter<Authenticator> {
  @override
  final int typeId = 9;

  @override
  Authenticator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Authenticator(
      baSysId: fields[0] as num?,
      parameterName: fields[1] as String?,
      dataType: fields[2] as String?,
      optional: fields[3] as String?,
      regex: fields[4] as String?,
      errorMessage: fields[5] as String?,
      seq: fields[6] as num?,
      encryptionRequired: fields[7] as dynamic,
      baBillersSysId: fields[8] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, Authenticator obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.baSysId)
      ..writeByte(1)
      ..write(obj.parameterName)
      ..writeByte(2)
      ..write(obj.dataType)
      ..writeByte(3)
      ..write(obj.optional)
      ..writeByte(4)
      ..write(obj.regex)
      ..writeByte(5)
      ..write(obj.errorMessage)
      ..writeByte(6)
      ..write(obj.seq)
      ..writeByte(7)
      ..write(obj.encryptionRequired)
      ..writeByte(8)
      ..write(obj.baBillersSysId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
