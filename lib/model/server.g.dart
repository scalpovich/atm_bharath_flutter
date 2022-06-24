// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerAdapter extends TypeAdapter<Server> {
  @override
  final int typeId = 10;

  @override
  Server read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Server(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as bool?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Server obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.serverUrl)
      ..writeByte(2)
      ..write(obj.serverStatus)
      ..writeByte(3)
      ..write(obj.serverState);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
