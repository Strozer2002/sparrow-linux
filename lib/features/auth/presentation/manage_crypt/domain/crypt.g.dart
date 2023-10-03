// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptAdapter extends TypeAdapter<Crypt> {
  @override
  final int typeId = 8;

  @override
  Crypt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Crypt(
      amount: fields[3] as int?,
      name: fields[1] as String,
      shortName: fields[2] as String,
      isChoose: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Crypt obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.shortName)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.isChoose);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
