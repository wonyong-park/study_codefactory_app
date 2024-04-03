import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_codefactory_app/product/model/product_model.dart';
import 'package:study_codefactory_app/user/model/basket_item_model.dart';
import 'package:collection/collection.dart';

final basketProvider = StateNotifierProvider<BasketProvider, List<BasketItemModel>>((ref) {
  return BasketProvider();
});

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    // 1) 장바구니에 상품이 없을 때 > 장바구니에 상품을 추가
    // 2) 장바구니에 상품이 있을 때 > 해당 상품에 +1

    final exists = state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      state = state
          .map((e) => e.product.id == product.id
              ? e.copyWith(
                  count: e.count + 1,
                )
              : e)
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(
          product: product,
          count: 1,
        ),
      ];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false,
  }) async {
    // 1) 장바구니의 상품이 존재할 때
    //    1) 상품의 개수가 1개보다 큰 경우 > -1
    //    2) 상품의 개수가 1개인 경우 > 삭제
    // 2) 장바구니의 상품이 존재하지 않은 경우 > 즉시 리턴

    final exists = state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) return;

    final existingProduct = state.firstWhere(
      (e) => e.product.id == product.id,
    );

    if (existingProduct.count == 1 || isDelete) {
      state = state
          .where(
            (e) => e.product.id != product.id,
          )
          .toList();
    } else {
      state = state
          .map((e) => e.product.id == product.id
              ? e.copyWith(
                  count: e.count - 1,
                )
              : e)
          .toList();
    }
  }
}
