import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {

}

/// 에러가 났을 때 상태
/// cursorPaginationBase is CursorPaginationError == true
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

/// 로딩중일때
/// cursorPaginationBase is CursorPaginationLoading == true
class CursorPaginationLoading extends CursorPaginationBase {

}

/// 성공일때
/// cursorPaginationBase is CursorPagination == true
@JsonSerializable(
  genericArgumentFactories: true, // 제너릭을 사용할 때
)
class CursorPagination<T> extends CursorPaginationBase{
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) => _$CursorPaginationMetaFromJson(json);
}

/// 다시 처음부터 불러올때
/// instance is CursorPaginationRefetching == true && instance is CursorPagination == true
class CursorPaginationRefetching extends CursorPagination {
  CursorPaginationRefetching({
    required super.data,
    required super.meta,
  });
}

/// 리스트의 맨 아래로 내려서 추가 데이터를 요청 할 때
/// instance is CursorPaginationFetchingMore == true && instance is CursorPagination == true
class CursorPaginationFetchingMore extends CursorPagination {
  CursorPaginationFetchingMore({
    required super.data,
    required super.meta,
  });
}