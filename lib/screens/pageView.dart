import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mpass/backup/writeClass.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:flutter/material.dart';
import 'package:mpass/screens/settings.dart';
import 'package:provider/provider.dart';

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

class _pageViewScreenState extends State<pageViewScreen> {

  AppColors _appColors = new AppColors();
  late final AnimationController _controller;

  List<Person> people = [];
  int currColor = 0 ;
  bool isFirst = true;



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
