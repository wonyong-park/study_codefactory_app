import 'package:flutter/material.dart';
import 'package:study_codefactory_app/common/component/custom_text_form_field.dart';
import 'package:study_codefactory_app/common/const/colors.dart';
import 'package:study_codefactory_app/user/view/login_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
