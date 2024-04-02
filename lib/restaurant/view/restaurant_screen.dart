import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_codefactory_app/common/component/pagination_list_view.dart';
import 'package:study_codefactory_app/restaurant/component/restaurant_card.dart';
import 'package:study_codefactory_app/restaurant/provider/restaurant_provider.dart';
import 'package:study_codefactory_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(
              RestaurantDetailScreen.routName,
              pathParameters: {
                'rid': model.id,
              },
            );
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
