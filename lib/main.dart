import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mpass/colors/AppColors.dart';
import 'package:mpass/passwords.dart';
import 'package:mpass/providers/WorkProvider.dart';
import 'package:mpass/providers/allPassProvider.dart';
import 'package:mpass/providers/colors.dart';
import 'package:mpass/providers/mostUsedProvider.dart';
import 'package:mpass/providers/searchProvider.dart';
import 'package:mpass/providers/socialProvider.dart';
import 'package:mpass/providers/isFirstLaunch.dart';
import 'package:mpass/screens/generate.dart';
import 'package:mpass/screens/home.dart';
import 'package:mpass/screens/onboard.dart';
import 'package:mpass/screens/pageView.dart';
import 'package:mpass/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories/mostUsed.dart';
import 'categories/search.dart';
import 'categories/social.dart';
import 'categories/work.dart';
import 'compromised.dart';

void main() async {
  await Future.delayed(const Duration(milliseconds: 200));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> colorProvider()),
        ChangeNotifierProvider(create: (_)=> allPassProvider()),
        ChangeNotifierProvider(create: (_)=> socialProvider()),
        ChangeNotifierProvider(create: (_)=> workProvider()),
        ChangeNotifierProvider(create: (_)=> mostUsedProvider()),
        ChangeNotifierProvider(create: (_)=> searchProvider()),
        ChangeNotifierProvider(create: (_)=> isFirstLaunch()),
      ],
      child: const MyApp(),
    )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppColors _appColors = new AppColors();

    int currColor = context.watch<colorProvider>().colorIndex;
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: _appColors.primary[currColor], //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MPass',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
      ),

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  //State<MyHomePage> createState() => splashScreen();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  AppColors _appColors = new AppColors();
  late final AnimationController _controller;

  int currColor = 0 ;
  bool isFirst = true;

  @override
  void initState() {
    late PageController controller;
    //_checkColors();
    context.read<colorProvider>().initColor();
    context.read<socialProvider>().initSocial();
    context.read<allPassProvider>().initallPass();
    context.read<workProvider>().initWork();
    context.read<mostUsedProvider>().initMostUsed();
    context.read<searchProvider>().initSearch();
    context.read<isFirstLaunch>().initIsFirst();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _controller.reset();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const pageViewScreen()),);

      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isFirst = context.watch<isFirstLaunch>().isFirst;
    
    currColor = context.watch<colorProvider>().colorIndex;
    return SafeArea(
      child: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          padding: EdgeInsets.all(125),
          child: Lottie.asset(
              "assets/lottie/logo.json",
              repeat: false,
              controller: _controller,
              onLoaded: (composition){
                _controller.duration = composition.duration;
                _controller.forward().whenComplete(() => (){

                });
              }
          ),
        ),
      ),
    );
  }
}
