import 'package:json_annotation/json_annotation.dart';
import 'package:study_codefactory_app/common/model/model_with_id.dart';
import 'package:study_codefactory_app/common/utils/data_utils.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  @override
  final String id;
  // 상품 이름
  final String name;
  // 이미지 URL
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  // 상품 상세 정보
  final String detail;
  // 상품 가격
  final int price;
  // 레스토랑 정보
  final RestaurantModel restaurant;

  ProductModel({
    required this.id,
    required this.restaurant,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}
