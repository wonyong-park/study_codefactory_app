import 'package:json_annotation/json_annotation.dart';
import 'package:study_codefactory_app/common/model/model_with_id.dart';
import 'package:study_codefactory_app/common/utils/data_utils.dart';
import 'package:study_codefactory_app/user/model/user_model.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId{
  @override
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(
    fromJson: DataUtils.listPathsToUrls,
  )
  final List<String> imgUrls;

  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.imgUrls,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
