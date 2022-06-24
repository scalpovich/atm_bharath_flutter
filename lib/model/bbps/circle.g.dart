// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CircleAdapter extends TypeAdapter<Circle> {
  @override
  final int typeId = 3;

  @override
  Circle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Circle(
      circleid: fields[0] as String?,
      circleName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Circle obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.circleid)
      ..writeByte(1)
      ..write(obj.circleName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CircleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
