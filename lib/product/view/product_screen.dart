import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_codefactory_app/common/component/pagination_list_view.dart';
import 'package:study_codefactory_app/product/component/product_card.dart';
import 'package:study_codefactory_app/product/model/product_model.dart';
import 'package:study_codefactory_app/product/provider/product_provider.dart';
import 'package:study_codefactory_app/restaurant/component/restaurant_card.dart';
import 'package:study_codefactory_app/restaurant/view/restaurant_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(RestaurantDetailScreen.routName, pathParameters: {
              'rid': model.restaurant.id,
            });
          },
          child: ProductCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
