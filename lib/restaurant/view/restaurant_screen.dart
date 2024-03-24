import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_codefactory_app/common/const/data.dart';
import 'package:study_codefactory_app/common/dio/dio.dart';
import 'package:study_codefactory_app/common/model/cursor_pagination_model.dart';
import 'package:study_codefactory_app/restaurant/component/restaurant_card.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_model.dart';
import 'package:study_codefactory_app/restaurant/repository/restaurant_repository.dart';
import 'package:study_codefactory_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder<CursorPagination<RestaurantModel>>(
        future: ref.watch(restaurantRepository).paginate(),
        builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final pItem = snapshot.data!.data[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(
                        id: pItem.id,
                      ),
                    ),
                  );
                },
                child: RestaurantCard.fromModel(
                  model: pItem,
                ),
              );
            },
            itemCount: snapshot.data!.data.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.0);
            },
          );
        },
      ),
    );
  }
}
