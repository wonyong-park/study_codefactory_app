import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_codefactory_app/user/provider/auth_provider.dart';
import 'package:study_codefactory_app/user/provider/user_me_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.read(userMeProvider.notifier).logout();
        },
        child: Text('Logout'),
      ),
    );
  }
}
