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
      amount: fields[3] as double,
      amountInCurrency: fields[4] as double,
      priceForOne: fields[5] as double,
      changesCrypt: fields[7] as Changes,
      iconName: fields[0] as String,
      name: fields[1] as String,
      shortName: fields[2] as String,
      isChoose: fields[6] as bool,
      tokenAddress: fields[8] as String,
      swapAddress: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Crypt obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.iconName)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.shortName)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.amountInCurrency)
      ..writeByte(5)
      ..write(obj.priceForOne)
      ..writeByte(6)
      ..write(obj.isChoose)
      ..writeByte(7)
      ..write(obj.changesCrypt)
      ..writeByte(8)
      ..write(obj.tokenAddress)
      ..writeByte(9)
      ..write(obj.swapAddress);
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
