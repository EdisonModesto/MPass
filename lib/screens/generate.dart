import 'package:flutter/material.dart';
import 'dart:math';


class Generate extends StatefulWidget{
  @override
  _generate createState() => new _generate();
}

class _generate extends State<Generate>{

  //String _Password = "";
  List<String> _Password = ["a", "a", "a", "a"];

  _generatePasswords(){
    setState(() {
      var rand = Random();
      _Password = ["a", "a", "a", "a"];
      String strCollection = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz123456789!_&@";
      for(int j = 0; j < 4; j++){
        String temp = "";
        for(int i = 0; i < 8; i++){
         temp += strCollection[rand.nextInt(65)];
        }
        _Password.insert(j ,temp);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatePasswords();
  }

  @override
  Widget build(BuildContext context){
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
                      Text(
                        "Password Generator",
                        style: TextStyle(
                            color: Color(0xffFFF9F9),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
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
                      top: MediaQuery.of(context).size.width * 0.1,
                      bottom: MediaQuery.of(context).size.width * 0.05
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
                          flex: 10,
                          child: Column(
                            children: [
                              //Text Lbl
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                child: const Text(
                                  "Generated Passwords",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),

                      //password list
                      Expanded(
                          flex: 75,
                          child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  margin: const EdgeInsets.only(bottom: 10),

                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: Container(
                                      width: 15,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffBAABDA),
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                    ),

                                    trailing: IconButton(
                                        onPressed: null,
                                        icon: Image.asset("assets/images/copyicon.png")
                                    ),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _Password[index],
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 5),

                            ) ,

                          )

                      ),

                      //Add button
                      Expanded(
                        //button
                        flex: 13,
                        child: Container(
                            color: Color(0xffA491CD),
                            width: MediaQuery.of(context).size.width * 1,
                            child: ElevatedButton(
                              onPressed: _generatePasswords,
                              child: Text("Generate"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff8269B8)),
                                  foregroundColor: MaterialStateProperty.all<Color>(Color(0xffFFF9F9)),
                                  minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width * 0.8, 50))

                              ),
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
                flex: 35,
                child: Container(

                  width: MediaQuery.of(context).size.width * .8,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      color: Color(0xffFFF9F9),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .09,
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