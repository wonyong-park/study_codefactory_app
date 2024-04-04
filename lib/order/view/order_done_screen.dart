import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_codefactory_app/common/const/colors.dart';
import 'package:study_codefactory_app/common/layout/default_layout.dart';
import 'package:study_codefactory_app/common/view/root_tab.dart';

class OrderDoneScreen extends StatelessWidget {
  static String get routeName => 'orderDone';
  const OrderDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.thumb_up_alt_outlined,
              color: PRIMARY_COLOR,
              size: 50.0,
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              '결제가 완료되었습니다.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(RootTab.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
              ),
              child: const Text(
                '홈으로',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
