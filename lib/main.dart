import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_codefactory_app/common/provider/go_router.dart';
import 'package:study_codefactory_app/common/view/splash_screen.dart';
import 'package:study_codefactory_app/user/provider/auth_provider.dart';
import 'package:study_codefactory_app/user/view/login_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
