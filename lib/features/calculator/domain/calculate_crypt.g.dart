// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_crypt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculateCryptAdapter extends TypeAdapter<CalculateCrypt> {
  @override
  final int typeId = 12;

  @override
  CalculateCrypt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculateCrypt(
      name: fields[1] as String,
      shortName: fields[2] as String,
      price: fields[3] as double,
      isChoose: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CalculateCrypt obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.shortName)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.isChoose);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculateCryptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
