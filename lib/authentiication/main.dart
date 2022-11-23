import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/responsive/responsive_login.dart';
import 'package:flutter_application_2/screens/screen_home.dart';
import 'package:flutter_application_2/screens/screen_login.dart';
import 'package:flutter_application_2/screens/screen_login_small.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ScreenHome();
          } else {
            return const ResponsiveLayoutLogin(
              mobileBody: ScreenLoginSmall(),
              desktopBody: ScreenLogin(),
            );
          }
        },
      ),
    );
  }
}
