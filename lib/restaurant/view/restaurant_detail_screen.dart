import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';
import 'package:study_codefactory_app/common/const/colors.dart';
import 'package:study_codefactory_app/common/layout/default_layout.dart';
import 'package:study_codefactory_app/common/model/cursor_pagination_model.dart';
import 'package:study_codefactory_app/common/utils/pagination_utils.dart';
import 'package:study_codefactory_app/product/component/product_card.dart';
import 'package:study_codefactory_app/product/model/product_model.dart';
import 'package:study_codefactory_app/rating/component/rating_card.dart';
import 'package:study_codefactory_app/rating/model/rating_model.dart';
import 'package:study_codefactory_app/restaurant/component/restaurant_card.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_detail_model.dart';
import 'package:study_codefactory_app/restaurant/model/restaurant_model.dart';
import 'package:study_codefactory_app/restaurant/provider/restaurant_provider.dart';
import 'package:study_codefactory_app/restaurant/provider/restaurant_rating_provider.dart';
import 'package:study_codefactory_app/restaurant/repository/restaurant_repository.dart';
import 'package:study_codefactory_app/restaurant/view/basket_screen.dart';
import 'package:study_codefactory_app/user/provider/basket_provider.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routName => 'restaurantDetail';
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    _controller.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.scrollListener(controller: _controller, provider: ref.read(restaurantRatingProvider(widget.id).notifier));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(BasketScreen.routeName);
        },
        child: Badge(
          isLabelVisible: basket.isNotEmpty,
          label: Text(
            basket
                .fold<int>(
                  0,
                  (previousValue, element) => previousValue + element.count,
                )
                .toString(),
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 10.0,
            ),
          ),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.shopping_basket_outlined,
          ),
        ),
      ),
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          renderTop(
            model: state,
          ),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              restaurant: state,
              products: state.products,
            ),
          if (ratingsState is CursorPagination<RatingModel>)
            renderRatings(models: ratingsState.data),
        ],
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RatingCard.fromModel(
              model: models[index],
            ),
          ),
          childCount: models.length
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(
                bottom: 32.0,
              ),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  renderProducts({
    required RestaurantDetailModel restaurant,
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return InkWell(
              onTap: () {
                ref.watch(basketProvider.notifier).addToBasket(
                      product: ProductModel(
                        id: model.id,
                        restaurant: restaurant,
                        name: model.name,
                        imgUrl: model.imgUrl,
                        detail: model.detail,
                        price: model.price,
                      ),
                    );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: ProductCard.fromRestaurantProductModel(
                  model: model,
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
