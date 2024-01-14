// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsTxAppAdapter extends TypeAdapter<SettingsTxApp> {
  @override
  final int typeId = 5;

  @override
  SettingsTxApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsTxApp(
      mainCurrency: fields[0] as Currency,
      mainScreen: fields[1] as ScreensName,
      password: fields[2] as String?,
      mainDay: fields[3] as WeekDay,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsTxApp obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.mainCurrency)
      ..writeByte(1)
      ..write(obj.mainScreen)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.mainDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsTxAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
