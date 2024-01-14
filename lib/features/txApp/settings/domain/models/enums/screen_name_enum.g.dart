// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_name_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScreensNameAdapter extends TypeAdapter<ScreensName> {
  @override
  final int typeId = 7;

  @override
  ScreensName read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ScreensName.bankAccount;
      case 1:
        return ScreensName.category;
      case 2:
        return ScreensName.operation;
      case 3:
        return ScreensName.review;
      default:
        return ScreensName.bankAccount;
    }
  }

  @override
  void write(BinaryWriter writer, ScreensName obj) {
    switch (obj) {
      case ScreensName.bankAccount:
        writer.writeByte(0);
        break;
      case ScreensName.category:
        writer.writeByte(1);
        break;
      case ScreensName.operation:
        writer.writeByte(2);
        break;
      case ScreensName.review:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreensNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
