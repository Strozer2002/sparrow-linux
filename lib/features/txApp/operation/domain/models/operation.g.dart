// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationAdapter extends TypeAdapter<Operation> {
  @override
  final int typeId = 4;

  @override
  Operation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operation(
      date: fields[0] as DateTime,
      amount: fields[1] as double,
      category: fields[2] as Category,
      bankAccount: fields[3] as BankAccount,
      id: fields[4] as int,
      isSyncOrDelete: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Operation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.bankAccount)
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
      other is OperationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
