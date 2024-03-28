import 'package:flutter/material.dart';
import 'package:study_codefactory_app/common/const/colors.dart';
import 'package:study_codefactory_app/common/const/data.dart';
import 'package:study_codefactory_app/product/model/product_model.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    Key? key,
  }) : super(key: key);

  factory ProductCard.fromModel({
    required ProductModel model,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        fit: BoxFit.cover,
        width: 110,
        height: 110,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        fit: BoxFit.cover,
        width: 110,
        height: 110,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            child: image,
              // Image.asset(
            //               'asset/img/food/ddeok_bok_gi.jpg',
            //               width: 110,
            //               height: 110,
            //               fit: BoxFit.cover,
            //             ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$price원',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
