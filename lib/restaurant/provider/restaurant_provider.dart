import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_codefactory_app/common/model/cursor_pagination_model.dart';
import 'package:study_codefactory_app/common/model/pagination_params.dart';
import 'package:study_codefactory_app/common/provider/pagination_provider.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_detail_model.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_model.dart';
import 'package:study_codefactory_app/restaurant/repository/restaurant_repository.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider = Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepository);
  final notifier = RestaurantStateNotifier(repository: repository);
  return notifier;
});

class RestaurantStateNotifier extends PaginationProvider<RestaurantModel, RestaurantRepository> {

  RestaurantStateNotifier({
    required super.repository,
  });

  getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await paginate();
    }

    // state가 CursorPagination이 아닐때 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // 요청 id : 10 데이터가 없는 경우 마지막에 추가
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3), RestaurantDetailModel(10),]
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[
          ...pState.data,
          resp,
        ],
      );
    }
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // id : 2인 Model을 DetailModel로 변경
    // getDetail(2)
    // [RestaurantModel(1), RestaurantDetailModel(2), RestaurantModel(3)]
    else {
      state = pState.copyWith(
        data: pState.data.map<RestaurantModel>((e) => e.id == id ? resp : e).toList(),
      );
    }
  }
}
