import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_codefactory_app/user/model/user_model.dart';
import 'package:study_codefactory_app/user/provider/user_me_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) notifyListeners();
    });
  }

  // SplashScreen
  // 앱이 처음 시작했을때
  // 토큰이 존재하는지 확인하고 로그인/홈 스크린으로 보내주는 과정이 필요하다
  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    // 로그인 화면인지
    final loginIn = state.matchedLocation == '/login';

    // 로그인 정보가 없는데
    // 1) 로그인 중이면 -> 로그인 페이지에 둔다
    // 2) 로그인 중이 아니면 -> 로그인 페이지로 이동 시킨다
    if (user == null) {
      return loginIn ? null : '/login';
    }

    // 로그인 정보가 있을때
    // UserModel (로그인이 된 상태)
    // 사용자 정보가 있고, 로그인 중(로그인 화면)이거나 현재 위치가 스플래시 화면인경우 홈으로 이동
    if (user is UserModel) {
      return loginIn || state.matchedLocation == '/splash' ? '/home' : null;
    }

    if (user is UserModelError) {
      return !loginIn ? '/login' : null;
    }

    return null;
  }
}
