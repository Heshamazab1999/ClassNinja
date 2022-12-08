import 'dart:async';
import 'package:class_ninja/screens/ads/ads.dart';
import 'package:class_ninja/screens/ads/new_ad.dart';
import 'package:class_ninja/screens/ads/all_ads.dart';
import 'package:class_ninja/screens/auth/login.dart';
import 'package:class_ninja/screens/auth/new_pass.dart';
import 'package:class_ninja/screens/auth/send_code.dart';
import 'package:class_ninja/screens/auth/send_mail.dart';
import 'package:class_ninja/screens/auth/sign_socail.dart';
import 'package:class_ninja/screens/auth/sign_up.dart';
import 'package:class_ninja/screens/auth/splash1.dart';
import 'package:class_ninja/screens/auth/splash2.dart';
import 'package:class_ninja/screens/main/details.dart';
import 'package:class_ninja/screens/main/edit_profile.dart';
import 'package:class_ninja/screens/main/favourite.dart';
import 'package:class_ninja/screens/main/home.dart';
import 'package:class_ninja/screens/main/home_ads.dart';
import 'package:class_ninja/screens/main/profile.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/get_token.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ClassNinja',
    getPages: [
      GetPage(name: "/splash", page: () => Splash()),
      GetPage(name: "/splash2", page: () => Splash2()),
      GetPage(name: "/login", page: () => Login()),
      GetPage(name: "/signup", page: () => SignUp()),
      GetPage(name: "/social", page: () => SignSocial()),
      GetPage(name: "/code", page: () => SendCode()),
      GetPage(name: "/email", page: () => Email()),
      GetPage(name: "/pass", page: () => NewPass()),
      GetPage(name: "/home", page: () => Home()),
      GetPage(name: "/profile", page: () => Profile()),
      GetPage(name: "/ads", page: () => NewAd()),
      GetPage(name: "/fav", page: () => Favourite()),
      GetPage(name: "/edit", page: () => EditProfile()),
      GetPage(name: "/allAds", page: () => AllAds()),
      GetPage(name: "/myAds", page: () => MyAds()),
      GetPage(name: "/homeAds", page: () => HomeAds()),
      // GetPage(name: "/allDocs", page:()=>AllDoctors()),
      GetPage(name: "/details", page: () => Details()),
    ],
    home: token == null ? Splash2() : Home(),
    // home:userToken.isNotEmpty?Home():Splash2(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getToken();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClassNinja',
      getPages: [
        GetPage(name: "/splash", page: () => Splash()),
        GetPage(name: "/splash2", page: () => Splash2()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/social", page: () => SignSocial()),
        GetPage(name: "/code", page: () => SendCode()),
        GetPage(name: "/email", page: () => Email()),
        GetPage(name: "/pass", page: () => NewPass()),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/profile", page: () => Profile()),
        GetPage(name: "/ads", page: () => NewAd()),
        GetPage(name: "/fav", page: () => Favourite()),
        GetPage(name: "/edit", page: () => EditProfile()),
        GetPage(name: "/allAds", page: () => AllAds()),
        GetPage(name: "/myAds", page: () => MyAds()),
        GetPage(name: "/homeAds", page: () => HomeAds()),
        // GetPage(name: "/allDocs", page:()=>AllDoctors()),
        GetPage(name: "/details", page: () => Details()),
      ],
      home: Splash(),
      // home:userToken.isNotEmpty?Home():Splash2(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool load = false;

  @override
  void initState() {
    getToken();
    Timer(const Duration(seconds: 3), () {
      setState(() => load = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (userToken.isNotEmpty) ? Home() : (load ? Splash2() : Splash1());
  }
}
