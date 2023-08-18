import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelio/config/app_color.dart';
import 'package:hotelio/config/session.dart';
import 'package:hotelio/page/detail_page.dart';
import 'package:hotelio/page/home_page.dart';
import 'package:hotelio/page/intro_page.dart';
import 'package:hotelio/page/signin_page.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/app_route.dart';
import 'firebase_options.dart';
import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: AppColor.backgroundScaffold,
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
            primary: AppColor.primary,
            secondary: AppColor.secondary,
          ),
        ),
        routes: {
          '/': (context) {
            return FutureBuilder(
                future: Session.getUser(),
                builder: (context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.data == null || snapshot.data!.id == null) {
                    return const IntroPage();
                  } else {
                    return HomePage();
                  }
                });
          },
          AppRoute.intro: (context) => const IntroPage(),
          AppRoute.home: (context) => HomePage(),
          AppRoute.signin: (context) => SigninPage(),
          AppRoute.detail: (context) => DetailPage(),
          AppRoute.checkout: (context) => const IntroPage(),
          AppRoute.checkoutSuccess: (context) => const IntroPage(),
          AppRoute.detailBooking: (context) => const IntroPage(),
        });
  }
}
