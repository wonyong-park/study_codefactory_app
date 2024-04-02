import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:study_codefactory_app/common/const/data.dart';
import 'package:study_codefactory_app/user/model/user_model.dart';
import 'package:study_codefactory_app/user/repository/user_me_repository.dart';

class UserModelStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserModelStateNotifier({
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (accessToken == null || refreshToken == null) {
      state = null;
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }
}
