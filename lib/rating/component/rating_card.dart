import 'package:flutter/material.dart';
import 'package:study_codefactory_app/common/const/colors.dart';

class RatingCard extends StatelessWidget {
  // CircleAvatar
  final ImageProvider avatarImage;

  // 리스트로 위젯 이미지를 보여줄 때
  final List<Image> images;

  // 별점
  final int rating;

  // 이메일
  final String email;

  // 리뷰 내용
  final String content;

  const RatingCard({
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        _Body(),
        _Images(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  // CircleAvatar
  final ImageProvider avatarImage;

  // 별점
  final int rating;

  // 이메일
  final String email;

  const _Header({
    required this.avatarImage,
    required this.rating,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avatarImage,
          radius: 12.0,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: PRIMARY_COLOR,
          ),
        ).toList(),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _Images extends StatelessWidget {
  const _Images({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
