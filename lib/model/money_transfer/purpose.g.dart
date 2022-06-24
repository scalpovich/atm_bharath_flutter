// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurposeAdapter extends TypeAdapter<Purpose> {
  @override
  final int typeId = 7;

  @override
  Purpose read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Purpose(
      mtpsSysId: fields[0] as int,
      mtpsPurposename: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Purpose obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.mtpsSysId)
      ..writeByte(1)
      ..write(obj.mtpsPurposename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurposeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
