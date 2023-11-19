// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculateListAdapter extends TypeAdapter<CalculateList> {
  @override
  final int typeId = 13;

  @override
  CalculateList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculateList(
      calculate: (fields[1] as List).cast<CalculateCrypt>(),
    );
  }

  @override
  void write(BinaryWriter writer, CalculateList obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.calculate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculateListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
