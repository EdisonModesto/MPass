import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:webviewx/webviewx.dart';

class Settings extends StatefulWidget{
  @override
  _settings createState() => new _settings();
}

class _settings extends State<Settings>{

  List<String> settingsLbl = [ "Appearance", "Categories", "Scan Settings", "Backup Settings","Privacy and Policy"];
  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [

          Column(
            children: [
              //Top Part
              Expanded(
                flex: 30,
                child: Container(
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
                          child: ListView.builder(
                          itemCount: settingsLbl.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: 50,
                              child: TextButton(
                                onPressed: () {  },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      settingsLbl[index],
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
                            );
                          })
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
                child: Container(

                  width: MediaQuery.of(context).size.width * .85,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      color: Color(0xffFFF9F9),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
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
                                            child: Container(
                                              height: 500,
                                              width: MediaQuery.of(context).size.width * 0.8,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(15))
                                              ),
                                              child: WebViewX(
                                                initialContent: "https://ko-fi.com/edisonmodesto",
                                                width: MediaQuery.of(context).size.width * 1,
                                                height: MediaQuery.of(context).size.height * 1,
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
                              margin: EdgeInsets.only(top: 15, bottom: 15),
                              width: MediaQuery.of(context).size.width * 0.01,
                              decoration: BoxDecoration(
                                  color: Color(0xffBAABDA),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            Container(
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