import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors/AppColors.dart';
import '../providers/colors.dart';


class Generate extends StatefulWidget{
  @override
  _generate createState() => new _generate();
}

class _generate extends State<Generate>{

  //Colors object instance
  final AppColors ColorObject = AppColors();
  int currentPrim = 0, currentAccent = 0, currColor = 0;

  //String _Password = "";
  List<String> _Password = ["a", "a", "a", "a"];

  //symbol length boolean
  bool addSymbols = false;
  bool addLength = false;



  _generatePasswords(){
    setState(() {
      var rand = Random();

      int sizeRange = 61;
      int lengthRange = 8;

      if(addSymbols == true){
        sizeRange = 104;
      }

      if(addLength == true){
        lengthRange = 14;
      }

      _Password = ["a", "a", "a", "a"];
      String strCollection = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz123456789!_&@123456789!_&@123456789!_&@123456789!_&@";
      for(int j = 0; j < 4; j++){
        String temp = "";
        for(int i = 0; i < lengthRange; i++){
         temp += strCollection[rand.nextInt(sizeRange)];
        }
        _Password.insert(j ,temp);
      }
    });
  }

  initPref()async{
    final prefs = await SharedPreferences.getInstance();



  }

  @override
  void initState() {
    super.initState();
    //initPref();
    _generatePasswords();
    // Obtain shared preferences.
  }

  @override
  Widget build(BuildContext context){
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
                        "Password Generator",
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
                      //Text Label
                      Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              //Text Lbl
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: const Text(
                                  "Generated Passwords",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),

                      //password list
                      Expanded(
                          flex: 71,
                          child: Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 10),
                            child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: 50,
                                  margin: const EdgeInsets.only(bottom: 20),

                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: Container(
                                      width: 15,
                                      decoration: BoxDecoration(
                                          color: ColorObject.accent[currColor],
                                          borderRadius: const BorderRadius.all(Radius.circular(4))
                                      ),
                                    ),

                                    trailing: IconButton(
                                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                                        onPressed: (){
                                          Clipboard.setData(ClipboardData(
                                              text: _Password[index]));

                                          Fluttertoast.showToast(msg: "Password Copied!");
                                          },
                                        icon: Image.asset("assets/images/copyicon.png")
                                    ),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _Password[index],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 5),

                            ) ,

                          )

                      ),

                      //Add button
                      Expanded(
                        //button
                        flex: 13,
                        child: Container(
                            color: const Color(0xffA491CD),
                            width: MediaQuery.of(context).size.width * 1,
                            child: ElevatedButton(
                              onPressed: _generatePasswords,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>( ColorObject.primary[currColor]),
                                  foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffFFFFFF)),
                                  minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width * 0.8, 50))

                              ),
                              child: const Text("Generate"),
                            )
                        ),
                      )
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Checkbox(
                                          value: addSymbols,
                                          activeColor: ColorObject.accent[currColor],
                                          onChanged: (value){
                                            setState((){});
                                            if(value == true){
                                              addSymbols = true;
                                            } else{
                                              addSymbols = false;
                                            }
                                          },
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(6, 0),
                                        child: const Text("Add Symbols"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Checkbox(
                                          activeColor: ColorObject.accent[currColor],
                                          value: addLength,
                                          onChanged: (value){

                                            setState((){});
                                            if(value == true){
                                              addLength = true;
                                            } else{
                                              addLength = false;
                                            }
                                          },
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(6, 0),
                                        child: const Text("Add Length", textAlign: TextAlign.left),
                                      )
                                    ],
                                  )
                                ],
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