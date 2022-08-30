import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mpass/compromised.dart';
import 'package:mpass/compromisedList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/passwords.dart';
import 'package:mpass/categories/search.dart';
import 'package:mpass/categories/mostUsed.dart';
import 'package:mpass/categories/work.dart';
import 'package:mpass/categories/social.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart';


class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<Home>{

  //categories Button and states
  List<String> _category = ["All", "Most Used", "Social", "Work"];
  List _catSelected = [true, false, false, false];

  final PasswordPref = SharedPreferences.getInstance();

  //passwords
  accDetails _AccDetails = new accDetails();
  Compromised _Compromised = new Compromised();

  //category lists
  searchList _searchList = new searchList();
  mostUsed _mostUsed = new mostUsed();
  social _social = new social();
  work _work = new work();

  int compromised = 0;
  int _identical = 0;

  List currentList = [];
  int currIndex = 0;
  
  _searchPassword(String value) async{

    _searchList.Title.clear();
    _searchList.Email.clear();
    _searchList.Password.clear();

    if(value.isEmpty){
      setState((){
        currIndex = 0;
        _catSelected.fillRange(0, _catSelected.length, false);
        _catSelected[0] = true;
      });
    } else {
      setState((){
        currIndex = 4;
        _catSelected.fillRange(0, _catSelected.length, false);
      });
      for (int i = 0; i < _AccDetails.Title.length; i++) {
        if (_AccDetails.Title[i].contains(value)) {
          setState(() {
            _searchList.Title.add(_AccDetails.Title[i]);
            _searchList.Email.add(_AccDetails.Email[i]);
            _searchList.Password.add(_AccDetails.Password[i]);
            _searchList.pointer.add(i);
          });
        }
      }
    }
  }

    _getPasswords() async {
      final PasswordPref = await SharedPreferences.getInstance();


      setState(() {

        _AccDetails.Title = PasswordPref.getStringList('Titles')!;
        _AccDetails.Email = PasswordPref.getStringList('Emails')!;
        _AccDetails.Password = PasswordPref.getStringList('Passwords')!;
      });
      print("Loaded" + _AccDetails.Title.toString() + ", " + _AccDetails.Email.toString()+ ","+ _AccDetails.Password.toString());
    }

    _addPasswords(tempName, tempMail, tempPass){


          setState(() {
            _AccDetails.Title.add(tempName);
            print(_AccDetails.Title);
          });

          setState((){
            _AccDetails.Email.add(tempMail);
            print(_AccDetails.Email);
          });

          setState((){
            _AccDetails.Password.add(tempPass);
            print(_AccDetails.Password);
          });

      _savePasswords();
      _checkBreached();
    }

    _savePasswords() async{


    final PasswordPref = await SharedPreferences.getInstance();

    await PasswordPref.setStringList('Titles', _AccDetails.Title);
    await PasswordPref.setStringList('Emails', _AccDetails.Email);
    await PasswordPref.setStringList('Passwords', _AccDetails.Password);
  }


    _checkBreached()async{
      var tempTotalCompro = 0;
      _Compromised.Title.clear();
      _Compromised.Email.clear();
      _Compromised.Password.clear();
      _Compromised.pointer.clear();
      _Compromised.severity.clear();

      Timer(const Duration(seconds: 3), () async{
        for(int i = 0; i < _AccDetails.Title.length; i++) {
          var hashedPass = sha1.convert(utf8.encode(_AccDetails.Password[i])).toString();
          print(hashedPass);
          print(hashedPass.substring(5, hashedPass.length));
          var trimHash = hashedPass.substring(0, 5);
          var remainHash = hashedPass.substring(5, hashedPass.length);
          Response response = await get(Uri.parse("https://api.pwnedpasswords.com/range/$trimHash"));
          LineSplitter splt = const LineSplitter();
          List<String> SplittedResponse = splt.convert(response.body);
          //print(SplittedResponse);
          for(int j = 0; j < SplittedResponse.length; j++){
            //print(SplittedResponse[j] + " : " + remainHash+ "\n");
            if(SplittedResponse[j].contains(remainHash.toUpperCase())){
              tempTotalCompro +=1;
              List<String> severety = SplittedResponse[j].split(":");
              _Compromised.Title.add(_AccDetails.Title[i]);
              _Compromised.Email.add(_AccDetails.Email[i]);
              _Compromised.Password.add(_AccDetails.Password[i]);
              _Compromised.pointer.add(i);

              _Compromised.severity.add(int.parse(severety[1]));
            }
          }
        }
        setState((){
          compromised = tempTotalCompro;
        });

        if(compromised != 0){
          showBottomSheet(context: context, builder: (BuildContext context){
            return Container(
              color: Colors.redAccent,
              height: 200,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 40,
                  ),
                  const Text(
                    "Compromised Passwords\nFound",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,

                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1.5
                      )
                    ),
                      onPressed: (){
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Center(
                                  child: Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Container(
                                      height: 500,
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      padding: const EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
                                      decoration: const BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: Column(
                                         children: [
                                           const Text(
                                             "Compromised Accounts",
                                             style: TextStyle(
                                               color: Colors.redAccent,
                                               fontWeight: FontWeight.bold,
                                               fontSize: 18,
                                             ),
                                           ),
                                           Expanded(
                                             flex: 1,
                                             child: ListView.builder(
                                               shrinkWrap: true,
                                               itemCount: _Compromised.Title.length,
                                               itemBuilder: (BuildContext context, int index) {
                                                 return SingleChildScrollView(
                                                   child: ExpansionTile(
                                                     leading: Icon(Icons.warning),
                                                     title: Text(_Compromised.Title[index]),
                                                     expandedAlignment: Alignment.centerLeft,
                                                     expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       const AutoSizeText("The password of this account has been found on previously leaked databases. We suggest that you change your password ASAP.", style: TextStyle(fontSize: 12)),
                                                       Text("\nEmail: ${_Compromised.Email[index]}", textAlign: TextAlign.start, style: TextStyle(fontSize: 12),),
                                                       Text("Password: ${_Compromised.Password[index]}", textAlign: TextAlign.start, style: TextStyle(fontSize: 12)),
                                                       AutoSizeText("Password was previously leaked ${_Compromised.severity[index]} times.", style: TextStyle(color: Colors.redAccent, fontSize: 12),),
                                                     ],

                                                   ),
                                                 );

                                                   ExpansionTile(
                                                   leading: Icon(Icons.warning),
                                                   title: Text(_Compromised.Title[index]),
                                                   expandedAlignment: Alignment.centerLeft,
                                                   expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     const AutoSizeText("The password of this account has been found on previously leaked databases. We suggest that you change your password ASAP.", maxLines: 3, minFontSize: 1,),
                                                     Text("\nEmail: ${_Compromised.Email[index]}", textAlign: TextAlign.start, style: TextStyle(fontSize: 12),),
                                                     Text("Password: ${_Compromised.Password[index]}", textAlign: TextAlign.start, style: TextStyle(fontSize: 12)),
                                                     AutoSizeText("Password was previously leaked ${_Compromised.severity[index]} times.", style: TextStyle(color: Colors.redAccent, fontSize: 12),),
                                                   ],

                                                   );
                                               },
                                             ),
                                           ),
                                           ElevatedButton(
                                               onPressed: (){
                                                 Navigator.pop(context);
                                                 _fixPasswords();
                                                 showDialog(barrierDismissible: false, context: context, builder: (BuildContext context){
                                                   return Center(
                                                     child: Card(
                                                       shape: const RoundedRectangleBorder(
                                                           borderRadius: BorderRadius.all(Radius.circular(15))
                                                       ),
                                                       child: Container(
                                                         height: 500,
                                                         width: MediaQuery.of(context).size.width * 0.8,
                                                         padding: const EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
                                                         decoration: const BoxDecoration(
                                                             color: Colors.white60,
                                                             borderRadius: BorderRadius.all(Radius.circular(15))
                                                         ),
                                                         child: Column(
                                                           children: [
                                                             const Text(
                                                               "Accounts Fixed",
                                                               style: TextStyle(
                                                                 color: Color(0xff8269B8),
                                                                 fontWeight: FontWeight.bold,
                                                                 fontSize: 18,
                                                               ),
                                                             ),
                                                             const Text("\nAll affected passwords have been replaced with strong passwords. You can copy the new passwords below and change them in their respective app settings.\n",textAlign: TextAlign.justify, style: TextStyle(color: Colors.black, fontSize: 11),),
                                                             Expanded(
                                                               flex: 1,
                                                               child: ListView.builder(
                                                                 itemCount: _Compromised.Title.length,
                                                                   shrinkWrap: true,
                                                                   itemBuilder: (BuildContext context,int index){
                                                                 return ListTile(
                                                                     contentPadding: const EdgeInsets.all(0),
                                                                     leading: Container(
                                                                       padding: const EdgeInsets.only(
                                                                           top: 10, bottom: 10),
                                                                       child: Image.asset(
                                                                           "assets/images/fbIcon.png"),
                                                                     ),

                                                                     trailing: IconButton(
                                                                       onPressed: () {
                                                                         Clipboard.setData(ClipboardData(
                                                                             text: _Compromised.Password[index]));
                                                                         Fluttertoast.showToast(
                                                                             msg: "Password Copied!");
                                                                       },
                                                                       icon: Image.asset(
                                                                           "assets/images/copyicon.png"),
                                                                       padding: const EdgeInsets.only(
                                                                           top: 15, bottom: 15),
                                                                     ),
                                                                     title: Container(
                                                                       padding: const EdgeInsets.only(
                                                                           left: 10),
                                                                       child: Column(
                                                                         crossAxisAlignment: CrossAxisAlignment
                                                                             .start,
                                                                         mainAxisAlignment: MainAxisAlignment
                                                                             .spaceEvenly,
                                                                         children: [
                                                                           Text(

                                                                             _Compromised.Title[index],
                                                                             style: const TextStyle(
                                                                                 fontWeight: FontWeight.bold,
                                                                               fontSize: 14
                                                                             ),
                                                                           ),
                                                                           AutoSizeText(
                                                                             _Compromised.Email[index],
                                                                             //_Emails![index],
                                                                             style: const TextStyle(fontSize: 12),
                                                                             maxLines: 1,
                                                                           )
                                                                         ],
                                                                       ),
                                                                     )
                                                                 );
                                                               }),
                                                             ),
                                                             ElevatedButton(
                                                                 onPressed: (){
                                                                   Navigator.pop(context);
                                                                   },
                                                                 child: Text("Done")),
                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                   );
                                                 });
                                               },
                                               child: Text("Fix All"),
                                           )
                                         ],
                                      ),
                                    ),
                                  )
                              );
                            });
                      },
                      child: const Text("Show Compromised Passwords", style: TextStyle(color: Colors.white),)
                  )
                ],
              )
            );
          },
          );
        }
        print("Checking done");
      //print(SplittedResponse);
      });
    }

    _fixPasswords(){
      String strCollection = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz123456789!_&@123456789!_&@123456789!_&@123456789!_&@";
      var rand = Random();

      for(int i = 0; i < _Compromised.Title.length; i++){
        String temp = "";
        for(int j = 0; j < 8; j++){
          temp += strCollection[rand.nextInt(104)];
        }
        _Compromised.Password[i] = temp;
        _AccDetails.Password[_Compromised.pointer[i]] = temp;
      }

      _savePasswords();
    }

    _checkIdentical()async{
      
    }

  @override
  void initState() {
    _getPasswords();
    _checkBreached();
    currentList = [_AccDetails,_mostUsed,_social,_work, _searchList,];
    super.initState();
  }


  @override
  Widget build(BuildContext context){
      _AccDetails.isShow = true;
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
                    children: [
                        FadeIn(
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            compromised.toString(),
                            style: const TextStyle(
                                color: const Color(0xffFFF9F9),
                                fontSize: 34,
                                fontWeight: FontWeight.bold

                            ),
                          ),
                        ),

                      const FadeIn(
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 700),
                        child: Text(
                          "Compromised Passwords",
                          style: TextStyle(
                            color: const Color(0xffFFF9F9),
                            fontSize: 18,


                          ),
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
                      //Text Label and Categories
                      Expanded(
                          flex: 16,
                          child: Column(
                            children: [
                              //Text Lbl
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height: 25,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Password Vault",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),
                                    ),
                                    IconButton(
                                        iconSize: 20,
                                        padding: const EdgeInsets.all(0),
                                        onPressed: (){
                                          showDialog(context: context, builder: (_){
                                            return Center(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                ),
                                                child: Container(
                                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xffFFF9F9),
                                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                                    ),
                                                    width: MediaQuery.of(context).size.width * 0.8,
                                                    height: 50,
                                                    child:Column(
                                                      children: [

                                                        TextField(
                                                          onChanged: (value){
                                                            _searchPassword(value);
                                                          },
                                                          onSubmitted: (value){
                                                            _searchPassword(value);
                                                            Navigator.pop(context, true);
                                                          },

                                                          decoration: const InputDecoration(
                                                              hintText: "Search Account",
                                                              border: InputBorder.none,
                                                            prefixIcon: Icon(Icons.search)
                                                          ),
                                                        )
                                                      ],
                                                    )

                                                ),
                                              )
                                            );
                                          });
                                        },
                                        icon: const Icon(Icons.search),

                                    )
                                  ],
                                ),
                              ),
                              //Button Row
                                   SizedBox(
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 33,
                                    child: ListView.builder(
                                      itemCount: 4,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index){
                                        return AnimatedContainer(
                                          duration: Duration(milliseconds: 500),
                                          margin: const EdgeInsets.only(right: 10),
                                          child: OutlinedButton(
                                            onPressed: () => {
                                              setState((){
                                                _catSelected[index] = true;
                                                currIndex = index;
                                                for(int i = 0; i < _category.length; i++){
                                                  if(i != index){
                                                    _catSelected[i] = false;
                                                  }
                                                }
                                              })
                                            },
                                            style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: _catSelected[index] ? const Color(0xffA491CD) : const Color(0xff8269B8), width: 1
                                                ),

                                                backgroundColor: _catSelected[index] ? const Color(0xffA491CD) : const Color(0xffFFF9F9),
                                                minimumSize: const Size(20, 0.5)

                                            ),
                                            child: Text(
                                              _category[index],
                                              style: TextStyle(
                                                color: _catSelected[index] ? const Color(0xffFFF9F9) : const Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 5),

                                    ) ,
                                  )
                            ],
                          )
                      ),

                      //password list
                      Expanded(
                          flex: 63,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ListView.builder(
                              itemCount: currentList[currIndex].Title.length,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                    width: MediaQuery.of(context).size.width * 1,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 50,
                                    child: ListTile(
                                        onTap: (){
                                          showDialog(context: context, builder: (BuildContext context){
                                            return Center(
                                              child: Card(
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(15))
                                                ),
                                                child: Container(
                                                padding: const EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
                                                width: MediaQuery.of(context).size.width * 0.8,
                                                height: 230,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffFFF9F9),
                                                  borderRadius: BorderRadius.all(Radius.circular(15))
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    AutoSizeText(
                                                      currentList[currIndex].Title[index],
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Icon(Icons.email),
                                                        Expanded(
                                                            child: AutoSizeText(" : " + currentList[currIndex].Email[index], maxLines: 1,),
                                                        ),
                                                        IconButton(
                                                            onPressed: (){
                                                              Clipboard.setData(ClipboardData(
                                                                  text: currentList[currIndex].Email[index]));
                                                              Fluttertoast.showToast(msg: "Email Copied!");
                                                            },
                                                            icon: Image.asset("assets/images/copyicon.png", width: 25, height: 25,)
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Icon(Icons.password),
                                                        Expanded(
                                                            child: Text(" : " + currentList[currIndex].Password[index]),
                                                        ),
                                                        IconButton(
                                                            onPressed: (){
                                                              Clipboard.setData(ClipboardData(
                                                                  text: currentList[currIndex].Password[index]));
                                                              Fluttertoast.showToast(msg: "Password Copied");
                                                            },
                                                            icon: Image.asset("assets/images/copyicon.png", width: 25, height: 25,))
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        TextButton(
                                                            onPressed: (){

                                                              if(currIndex == 0){
                                                                setState((){
                                                                  currentList[currIndex].Title.removeAt(index);
                                                                  currentList[currIndex].Email.removeAt(index);
                                                                  currentList[currIndex].Password.removeAt(index);
                                                                });
                                                              } else if(currIndex == 4) {
                                                                setState((){
                                                                  //deletes from main list
                                                                  _AccDetails.Title.removeAt(_searchList.pointer[index]);
                                                                  _AccDetails.Email.removeAt(_searchList.pointer[index]);
                                                                  _AccDetails.Password.removeAt(_searchList.pointer[index]);

                                                                  //deletes from search list
                                                                  currentList[currIndex].Title.removeAt(index);
                                                                  currentList[currIndex].Email.removeAt(index);
                                                                  currentList[currIndex].Password.removeAt(index);
                                                                });
                                                              }
                                                              _savePasswords();

                                                              Fluttertoast.showToast(msg: "Account Removed");
                                                              _savePasswords();
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text(
                                                                "Delete",
                                                              style: TextStyle(
                                                                color: Colors.redAccent
                                                              ),
                                                            )
                                                        ),
                                                        TextButton(
                                                            onPressed: (){
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text("Close")
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              )
                                            );
                                          });
                                        },
                                        contentPadding: const EdgeInsets.all(0),
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Image.asset(
                                              "assets/images/fbIcon.png"),
                                        ),

                                        trailing: IconButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: currentList[currIndex].Password[index]));
                                            Fluttertoast.showToast(
                                                msg: "Password Copied!");
                                          },
                                          icon: Image.asset(
                                              "assets/images/copyicon.png"),
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                        ),
                                        title: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Text(

                                                currentList[currIndex].Title[index],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                              AutoSizeText(
                                                currentList[currIndex].Email[index],
                                                //_Emails![index],
                                                style: const TextStyle(fontSize: 14),
                                                maxLines: 1,
                                              )
                                            ],
                                          ),
                                        )
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
                              onPressed: () {
                                String tempName = "a";
                                String tempMail = "a";
                                String tempPass = "a";
                                final TextEditingController _titleCon = TextEditingController();
                                final TextEditingController _emailCon = TextEditingController();
                                final TextEditingController _passCon = TextEditingController();
                                showDialog(context: context, builder: (_) =>
                                Center(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      height: 275,
                                      padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: Column(
                                        children: [
                                        Text("Add Account", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                          Expanded(
                                            flex: 1,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [

                                                  TextField(
                                                      decoration: const InputDecoration(hintText: "App Name"),
                                                      style: TextStyle(fontSize: 14),
                                                      onChanged: (val) {
                                                        setState((){
                                                          tempName = _titleCon.text;
                                                        });
                                                      },
                                                      controller: _titleCon,
                                                    ),
                                                  TextField(
                                                    decoration: const InputDecoration(hintText: "Email"),
                                                    onChanged: (val2){
                                                      setState((){
                                                        tempMail = _emailCon.text;
                                                      });
                                                    },
                                                    style: TextStyle(fontSize: 14),
                                                    controller: _emailCon,
                                                    autofillHints: [AutofillHints.email],
                                                  ),
                                                  TextField(
                                                    decoration: const InputDecoration(hintText: "Password"),
                                                    onChanged: (val3){
                                                      setState((){
                                                        tempPass = _passCon.text;
                                                      });
                                                    },
                                                    style: TextStyle(fontSize: 14),
                                                    controller: _passCon,
                                                    autofillHints: [AutofillHints.password],
                                                    onEditingComplete: () => TextInput.finishAutofillContext(),
                                                  ),
                                                ],
                                              )
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: (){
                                                  Navigator.pop(context, true);
                                                },
                                                child: const Text("Close"),
                                              ),
                                              TextButton(
                                                  onPressed: (){
                                                    _addPasswords(tempName,_emailCon.text,_passCon.text);
                                                    Navigator.pop(context, true);
                                                  },

                                                  child: const Text("Add")
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                );
                              },
                              child: const Text("Add Account"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff8269B8)),
                                  foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffFFF9F9)),
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
                flex: 36,
                child: Container(

                  width: MediaQuery.of(context).size.width * .85,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      color: const Color(0xffFFF9F9),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        _AccDetails.Title.length.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                        ),
                                      ),
                                      const Text("Total\nPasswords")
                                    ],
                                  ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15, bottom: 15),
                              width: MediaQuery.of(context).size.width * 0.01,
                              decoration: BoxDecoration(
                                color: const Color(0xffBAABDA),
                                borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),
                                    ),
                                    Text("Identical\nPasswords")
                                  ],
                                ),
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
      )
    );
  }
}