// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_by_chain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionByChainAdapter extends TypeAdapter<PositionByChain> {
  @override
  final int typeId = 4;

  @override
  PositionByChain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionByChain(
      arbitrum: fields[0] as int,
      aurora: fields[1] as int,
      avalanche: fields[2] as int,
      binanceSmartChain: fields[3] as int,
      ethereum: fields[4] as int,
      fantom: fields[5] as int,
      loopring: fields[6] as int,
      optimism: fields[7] as int,
      polygon: fields[8] as int,
      solana: fields[9] as int,
      xdai: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PositionByChain obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.arbitrum)
      ..writeByte(1)
      ..write(obj.aurora)
      ..writeByte(2)
      ..write(obj.avalanche)
      ..writeByte(3)
      ..write(obj.binanceSmartChain)
      ..writeByte(4)
      ..write(obj.ethereum)
      ..writeByte(5)
      ..write(obj.fantom)
      ..writeByte(6)
      ..write(obj.loopring)
      ..writeByte(7)
      ..write(obj.optimism)
      ..writeByte(8)
      ..write(obj.polygon)
      ..writeByte(9)
      ..write(obj.solana)
      ..writeByte(10)
      ..write(obj.xdai);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionByChainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
