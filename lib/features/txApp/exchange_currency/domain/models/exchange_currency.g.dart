// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_currency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExchangeCurrencyAdapter extends TypeAdapter<ExchangeCurrency> {
  @override
  final int typeId = 9;

  @override
  ExchangeCurrency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExchangeCurrency(
      currencyFrom: fields[0] as Currency,
      currencyInto: fields[1] as Currency,
      amountFrom: fields[2] as double,
      amountInto: fields[3] as double,
      id: fields[4] as int,
      isSyncOrDelete: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ExchangeCurrency obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.currencyFrom)
      ..writeByte(1)
      ..write(obj.currencyInto)
      ..writeByte(2)
      ..write(obj.amountFrom)
      ..writeByte(3)
      ..write(obj.amountInto)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.isSyncOrDelete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeCurrencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
