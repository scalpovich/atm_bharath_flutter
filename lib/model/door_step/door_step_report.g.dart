// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'door_step_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoorStepReportsAdapter extends TypeAdapter<DoorStepReports> {
  @override
  final int typeId = 5;

  @override
  DoorStepReports read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoorStepReports(
      orderId: fields[0] as int?,
      orderDate: fields[1] as String?,
      orderTime: fields[2] as String?,
      endTime: fields[3] as String?,
      addressType: fields[4] as String?,
      address: fields[5] as String?,
      buildingType: fields[6] as String?,
      landmark: fields[7] as String?,
      latitude: fields[8] as String?,
      longitude: fields[9] as String?,
      orderStatus: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DoorStepReports obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.orderDate)
      ..writeByte(2)
      ..write(obj.orderTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.addressType)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.buildingType)
      ..writeByte(7)
      ..write(obj.landmark)
      ..writeByte(8)
      ..write(obj.latitude)
      ..writeByte(9)
      ..write(obj.longitude)
      ..writeByte(10)
      ..write(obj.orderStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoorStepReportsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
