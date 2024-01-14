// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioEntity _$PortfolioEntityFromJson(Map<String, dynamic> json) =>
    PortfolioEntity(
      totalValue: json['total_value'] as int?,
      absoluteChange: json['absolute_change_24h'] as int?,
      relativeChange: json['relative_change_24h'] as int?,
    );

Map<String, dynamic> _$PortfolioEntityToJson(PortfolioEntity instance) =>
    <String, dynamic>{
      'total_value': instance.totalValue,
      'absolute_change_24h': instance.absoluteChange,
      'relative_change_24h': instance.relativeChange,
    };
