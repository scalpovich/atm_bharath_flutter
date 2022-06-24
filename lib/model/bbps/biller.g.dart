// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biller.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillerAdapter extends TypeAdapter<Biller> {
  @override
  final int typeId = 4;

  @override
  Biller read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Biller(
      billerid: fields[0] as String?,
      billerName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Biller obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.billerid)
      ..writeByte(1)
      ..write(obj.billerName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
