import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:study_codefactory_app/common/const/data.dart';
import 'package:study_codefactory_app/common/dio/dio.dart';
import 'package:study_codefactory_app/common/model/cursor_pagination_model.dart';
import 'package:study_codefactory_app/common/model/pagination_params.dart';
import 'package:study_codefactory_app/rating/model/rating_model.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepository = Provider.family<RestaurantRatingRepository, String>(
      (ref, id) {
    final dio = ref.watch(dioProvider);

    final repository = RestaurantRatingRepository(dio, baseUrl: 'http://$ip/restaurant/$id/rating');

    return repository;
  },
);

// http://$ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) = _RestaurantRatingRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

}
