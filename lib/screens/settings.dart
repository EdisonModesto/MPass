import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/dialogs/backupDialog.dart';
import 'package:mpass/dialogs/category.dart';
import 'package:mpass/dialogs/colorPicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../colors/AppColors.dart';
import '../providers/colors.dart';

class Settings extends StatefulWidget{
  @override
  _settings createState() => new _settings();
}

class _settings extends State<Settings>{
  final AppColors ColorObject = AppColors();
  int currColor = 0;


  List<String> settingsLbl = [ "Appearance", "Categories", "Scan Settings", "Backup Settings","Privacy and Policy"];
  
  bool scanMode = false;
  
  _setScanMode(value)async{
    final scanPref = await SharedPreferences.getInstance();
    await scanPref.setBool("isScan", value);
    _getScanMode();

  }
  
  _getScanMode() async{
    final scanPref = await SharedPreferences.getInstance();
    setState((){
      scanMode = scanPref.getBool("isScan")!;
    });
  }
  
  @override
  void initState() {
    _getScanMode();

    context.read<colorProvider>().initColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currColor = context.watch<colorProvider>().colorIndex;
    return SafeArea(
      child: Stack(
        children: [

          Column(
            children: [
              //Top Part
              Expanded(
                flex: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FadeIn(
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 600),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            color: Color(0xffFFF9F9),
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //Lower Part
              Expanded(
                flex: 70,
                child: Container(
                  //padding
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.09,
                      right: MediaQuery.of(context).size.width * 0.09,
                      top: MediaQuery.of(context).size.height * 0.07,
                      bottom: MediaQuery.of(context).size.height * 0.03
                  ),
                  //sets width and height
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,

                  //adds border radius
                  decoration: const BoxDecoration(

                    color: Color(0xffFFF9F9),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),

                  //child
                  child: Column(

                    children: [
                      Expanded(
                        flex: 100,
                          child: ListView(
                            children: [
                              SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (BuildContext context){
                                    return customColorPicker();
                                  });
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(
                                          settingsLbl[0],
                                          style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Text(
                                          ">",
                                          style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(context: context, builder: (BuildContext context){
                                        return catDialog();
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          settingsLbl[1],
                                          style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Text(
                                          ">",
                                          style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {  },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          settingsLbl[2],
                                          style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                          ),
                                        ),
                                        Switch(value: scanMode, onChanged: (bool value){
                                          _setScanMode(value);
                                          Fluttertoast.showToast(msg: "Scanning ${scanMode ? "disabled" : "enabled"}");
                                        })
                                      ],
                                    ),
                                  )
                              ),
                              //Backup Tile
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(context: context, builder: (BuildContext context){
                                        return backupDialog();
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          settingsLbl[3],
                                          style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Text(
                                          ">",
                                          style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {  },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          settingsLbl[4],
                                          style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Text(
                                          ">",
                                          style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Expanded(
                flex: 36,
                child: SizedBox(

                  width: MediaQuery.of(context).size.width * .85,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      color: const Color(0xffFFF9F9),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Center(
                                  child: TextButton(

                                    onPressed: () {
                                      showDialog(context: context, builder: (BuildContext context){
                                        return Center(
                                          child: Card(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15))
                                            ),
                                            child: SizedBox(
                                              height: 500,
                                              width: MediaQuery.of(context).size.width * 0.8,
                                              child: const ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                                child: WebView(
                                                  initialUrl: "https://ko-fi.com/edisonmodesto",
                                                  javascriptMode: JavascriptMode.unrestricted,
                                                ),
                                              ),
                                            ),
                                          ) ,
                                        );
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          "assets/images/coffeeIcon.png",
                                          width: 30,
                                          height: 35,

                                        ),
                                        const AutoSizeText(
                                          "Buy us a\ncoffee",
                                          style: TextStyle(
                                              color: Color(0xff000000)
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15, bottom: 15),
                              width: MediaQuery.of(context).size.width * 0.01,
                              decoration: BoxDecoration(
                                  color: ColorObject.accent[currColor],
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Center(
                                  child: TextButton(

                                    onPressed: () {  },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          "assets/images/settingsIcon.png",
                                          width: 30,
                                          height: 35,

                                        ),
                                        const Text(
                                          "Advanced\nSettings",
                                          style: TextStyle(
                                              color: Color(0xff000000)
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              ),
              Expanded(
                flex: 65,
                child: Container(

                  width: MediaQuery.of(context).size.width * 1,

                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}