import 'package:flutter/material.dart';
import 'package:mpass/main.dart';

class Home extends StatefulWidget{
  @override
  _homePage createState() => new _homePage();
}

class _homePage extends State<Home>{

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: [
          //Top Part
          Expanded(
            flex: 30,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "0",
                    style: TextStyle(
                        color: Color(0xffFFF9F9),
                        fontSize: 34,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Compromised Passwords",
                    style: TextStyle(
                      color: Color(0xffFFF9F9),
                      fontSize: 18,

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
                  //Text Label and Categories
                  Expanded(
                      flex: 15,
                      child: Column(
                        children: [
                          //Text Lbl
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            margin: EdgeInsets.only(bottom: 5),
                            child: const Text(
                              "Password Vault",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          //Button Row
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,

                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlinedButton(
                                        onPressed: null,
                                        child: Text("All"),
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: Color(0xff8269B8), width: 1),
                                            minimumSize: Size(20, 0.5)

                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlinedButton(
                                        onPressed: null,
                                        child: Text("Most Used"),
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: Color(0xff8269B8), width: 1),
                                            minimumSize: Size(20, 0.5)

                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlinedButton(
                                        onPressed: null,
                                        child: Text("Social"),
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: Color(0xff8269B8), width: 1),
                                            minimumSize: Size(20, 0.5)

                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlinedButton(
                                        onPressed: null,
                                        child: Text("Work"),
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: Color(0xff8269B8), width: 1),
                                            minimumSize: Size(20, 0.5)

                                        ),
                                      ),
                                    ),


                                  ],
                                ) ,
                              )

                          ),
                        ],
                      )
                  ),

                  //password list
                  Expanded(
                      flex: 70,
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              width: MediaQuery.of(context).size.width * 1,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                leading: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset("assets/images/fbIcon.png"),
                                ),

                                trailing: IconButton(
                                    onPressed: null,
                                    icon: Image.asset("assets/images/copyicon.png")
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Facebook",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "sample@mail.com",
                                      style: TextStyle(fontSize: 14),
                                    )
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
                          onPressed: null,
                          child: Text("Add Account"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xff8269B8)),
                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xffFFF9F9)),
                              minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width * 0.8, 50))

                          ),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}