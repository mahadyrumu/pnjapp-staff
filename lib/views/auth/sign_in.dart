import 'package:flutter/material.dart';
import 'package:jetdispatch/layouts/oriantation_layout.dart';
import 'package:jetdispatch/layouts/screen_type_layout.dart';
import 'package:jetdispatch/views/auth/mobile/sign_in_p.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: SignInP(),
        landscape: SignInP(),
      ),
    ));
  }
}
