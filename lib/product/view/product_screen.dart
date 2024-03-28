import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_codefactory_app/common/component/pagination_list_view.dart';
import 'package:study_codefactory_app/product/component/product_card.dart';
import 'package:study_codefactory_app/product/model/product_model.dart';
import 'package:study_codefactory_app/product/provider/product_provider.dart';
import 'package:study_codefactory_app/restaurant/component/restaurant_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return ProductCard.fromModel(
          model: model,
        );
      },
    );
  }
}
