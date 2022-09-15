import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:lottie/lottie.dart';
import 'package:mpass/backup/writeClass.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:flutter/material.dart';
import 'package:mpass/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backup/classPass.dart';
import '../colors/AppColors.dart';
import '../providers/colors.dart';
import '../providers/isFirstLaunch.dart';
import 'generate.dart';
import 'home.dart';
import 'onboard.dart';

class pageViewScreen extends StatefulWidget {

  const pageViewScreen({Key? key}) : super(key: key);


  @override
  State<pageViewScreen> createState() => _pageViewScreenState();
}

class _pageViewScreenState extends State<pageViewScreen> with TickerProviderStateMixin{

  late final AnimationController _controller;

  AppColors _appColors = new AppColors();

  List<Person> people = [];
  int currColor = 0 ;
  bool isFirst = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _showDialog();
  }


  _showDialog()async{
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    final bool? isTut = prefs.getBool('isTut');
    await Future.delayed(const Duration(seconds: 1));
    if(isTut == null) {
      showDialog(context: context, builder: (BuildContext context) {
        return Center(
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Swipe to Navigate",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Lottie.asset(
                        "assets/lottie/swipe.json",
                        repeat: true,
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () async {
                    Navigator.pop(context);
                    await prefs.setBool('isTut', true);
                  }, child: Text("Got it!", style: TextStyle(fontSize: 16),))
                ],
              ),
            ),
          ),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    isFirst = context.watch<isFirstLaunch>().isFirst;

    currColor = context.watch<colorProvider>().colorIndex;

    return Scaffold(
        backgroundColor: _appColors.primary[currColor],
        resizeToAvoidBottomInset: false,

        body: context.watch<isFirstLaunch>().isFirst ? onBoardScreen() : PageView(
          controller: PageController(initialPage: 1),
          children: [
            //Settings
            Settings(),

            //Home
            Home(),

            //Generate
            Generate()

          ],
        )
    );
  }


}
