// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankNameAdapter extends TypeAdapter<BankName> {
  @override
  final int typeId = 0;

  @override
  BankName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankName(
      bankName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BankName obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bankName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
