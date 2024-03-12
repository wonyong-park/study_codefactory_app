import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:study_codefactory_app/common/const/data.dart';
import 'package:study_codefactory_app/restaurant/component/restaurant_card.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_model.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final response = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );

    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder<List>(
        future: paginateRestaurant(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              final pItem = RestaurantModel.fromJson(
                json: item,
              );

              return RestaurantCard.fromModel(
                model: pItem,
              );
            },
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.0);
            },
          );
        },
      ),
    );
  }
}
