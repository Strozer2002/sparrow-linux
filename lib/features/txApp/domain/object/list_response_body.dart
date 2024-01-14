import 'package:data_source/callback_result/misc/typedef_list.dart';
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sparrow/features/txApp/domain/interface/general_ressponse_body.dart';
import 'package:sparrow/features/txApp/domain/object/pagination_data.dart';
part 'list_response_body.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
final class ListResponseBody<T extends DTO>
    extends GeneralResponseBody<List<T>> {
  PaginationData? pagination;

  ListResponseBody({
    super.message,
    super.data,
    super.success,
    super.errors,
    this.pagination,
  });

  factory ListResponseBody.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ListResponseBodyFromJson(json, fromJsonT);

  @override
  Json toJson() => throw UnimplementedError();
}
