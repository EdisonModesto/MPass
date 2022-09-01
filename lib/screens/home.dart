import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mpass/colors/AppColors.dart';
import 'package:mpass/compromised.dart';
import 'package:mpass/dialogs/viewPassDialog.dart';
import 'package:mpass/listviews/allList.dart';
import 'package:mpass/listviews/searchListView.dart';
import 'package:mpass/listviews/socialListView.dart';
import 'package:mpass/providers/WorkProvider.dart';
import 'package:mpass/providers/allPassProvider.dart';
import 'package:mpass/providers/mostUsedProvider.dart';
import 'package:mpass/providers/searchProvider.dart';
import 'package:mpass/providers/socialProvider.dart';
import 'package:provider/provider.dart';
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

import '../providers/colors.dart';


class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<Home> with TickerProviderStateMixin{

  //Color Object instance
  AppColors ColorObject = AppColors();
  int currColor = 0;

  //categories Button and states
  final List<String> _category = ["All", "Most Used", "Social", "Work"];
  final List _catSelected = [true, false, false, false];

  final PasswordPref = SharedPreferences.getInstance();

  //passwords
  final accDetails _AccDetails = new accDetails();
  final Compromised _Compromised = new Compromised();

  //category lists
  final searchList _searchList = new searchList();
  final mostUsed _mostUsed = new mostUsed();
  final social _social = new social();
  final work _work = new work();

  int compromised = 0;
  int _identical = 0;

  List currentList = [];
  int currIndex = 0;

  late AnimationController _lottieController;

  //variable to control widget visibility when using lottie
  bool LottieEffect = false;
  var lottieVisible = true;

  @override
  void initState() {
    currentList = [_AccDetails,_mostUsed,_social,_work, _searchList];
    _lottieController = AnimationController(vsync: this);
    _lottieController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
       _lottieController.reset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  _searchPassword(String value) async{

    context.read<searchProvider>().clearSearch();

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
      for (int i = 0; i < context.read<allPassProvider>().Title.length; i++) {
        if (context.read<allPassProvider>().Title[i].contains(value)) {
          setState(() {
            context.read<searchProvider>().addSearchPass(context.read<allPassProvider>().Title[i], context.read<allPassProvider>().Email[i], context.read<allPassProvider>().Password[i], i);
          });
        }
      }
    }
  }

    _savePasswords() async{

    final PasswordPref = await SharedPreferences.getInstance();

    await PasswordPref.setStringList('Titles', _AccDetails.Title);
    await PasswordPref.setStringList('Emails', _AccDetails.Email);
    await PasswordPref.setStringList('Passwords', _AccDetails.Password);
  }

    _checkBreached()async{
    final PasswordPref = await SharedPreferences.getInstance();
    if(PasswordPref.getBool("isScan")!) {
        var tempTotalCompro = 0;
        _Compromised.Title.clear();
        _Compromised.Email.clear();
        _Compromised.Password.clear();
        _Compromised.pointer.clear();
        _Compromised.severity.clear();

        Timer(const Duration(seconds: 3), () async {
          for (int i = 0; i < context.read<allPassProvider>().Title.length; i++) {
            var hashedPass = sha1.convert(utf8.encode(context.read<allPassProvider>().Password[i]))
                .toString();
            print(hashedPass);
            print(hashedPass.substring(5, hashedPass.length));
            var trimHash = hashedPass.substring(0, 5);
            var remainHash = hashedPass.substring(5, hashedPass.length);
            Response response = await get(
                Uri.parse("https://api.pwnedpasswords.com/range/$trimHash"));
            LineSplitter splt = const LineSplitter();
            List<String> SplittedResponse = splt.convert(response.body);
            //print(SplittedResponse);
            for (int j = 0; j < SplittedResponse.length; j++) {
              //print(SplittedResponse[j] + " : " + remainHash+ "\n");
              if (SplittedResponse[j].contains(remainHash.toUpperCase())) {
                tempTotalCompro += 1;
                List<String> severety = SplittedResponse[j].split(":");
                _Compromised.Title.add(context.read<allPassProvider>().Title[i]);
                _Compromised.Email.add(context.read<allPassProvider>().Email[i]);
                _Compromised.Password.add(context.read<allPassProvider>().Password[i]);
                _Compromised.pointer.add(i);

                _Compromised.severity.add(int.parse(severety[1]));
              }
            }
          }
          setState(() {
            compromised = tempTotalCompro;
          });

          if (compromised != 0) {
            showBottomSheet(context: context, builder: (BuildContext context) {
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
                              side: const BorderSide(color: Colors.white, width: 1.5
                              )
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(context: context, builder: (BuildContext context) {
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
                                                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 18,
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
                                                        leading: const Icon(Icons.warning),
                                                        title: Text(_Compromised.Title[index]),
                                                        expandedAlignment: Alignment.centerLeft,
                                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const AutoSizeText(
                                                              "The password of this account has been found on previously leaked databases. We suggest that you change your password ASAP.",
                                                              style: TextStyle(
                                                                  fontSize: 12)),
                                                          Text(
                                                            "\nEmail: ${_Compromised.Email[index]}",
                                                            textAlign: TextAlign.start,
                                                            style: const TextStyle(fontSize: 12),),
                                                          Text(
                                                              "Password: ${_Compromised.Password[index]}",
                                                              textAlign: TextAlign.start,
                                                              style: const TextStyle(fontSize: 12)),
                                                          AutoSizeText(
                                                            "Password was previously leaked ${_Compromised.severity[index]} times.",
                                                            style: const TextStyle(
                                                                color: Colors.redAccent, fontSize: 12),),
                                                        ],

                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _fixPasswords();
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        LottieEffect = false;
                                                        lottieVisible = true;
                                                        var flex = MainAxisAlignment.center;
                                                        return StatefulBuilder(
                                                          builder: (context, setState){
                                                          return Center(
                                                            child: Card(
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(15))
                                                              ),
                                                              child: Container(
                                                                height: 500,
                                                                width: MediaQuery.of(context).size.width * 0.8,
                                                                padding: const EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
                                                                decoration: const BoxDecoration(color: Colors.white60,
                                                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: flex,
                                                                  children: [
                                                                    Visibility(
                                                                      visible: lottieVisible,
                                                                      child: Lottie.asset(
                                                                        "assets/lottie/lock.json",
                                                                        controller: _lottieController,
                                                                        repeat: false,
                                                                        onLoaded: (composition){_lottieController.duration = Duration(seconds: 6);
                                                                          _lottieController.forward().whenComplete(() =>
                                                                          setState((){
                                                                            LottieEffect = true;
                                                                            flex = MainAxisAlignment.spaceBetween;
                                                                            lottieVisible = false;
                                                                          }));
                                                                        }
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: LottieEffect,
                                                                      child: Text("Accounts Fixed",
                                                                        style: TextStyle(
                                                                          color: ColorObject.primary[currColor],
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 18,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: LottieEffect,
                                                                      child: const Text("\nAll affected passwords have been replaced with strong passwords. You can copy the new passwords below and change them in their respective app settings.\n",
                                                                        textAlign: TextAlign.justify,
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 11),),
                                                                    ),
                                                                    Visibility(
                                                                      visible: LottieEffect,
                                                                      child: Expanded(
                                                                        flex: 1,
                                                                        child: ListView.builder(
                                                                            itemCount: _Compromised.Title.length,
                                                                            shrinkWrap: true,
                                                                            itemBuilder: (BuildContext context, int index) {
                                                                              return ListTile(
                                                                                  onTap: () {
                                                                                    showDialog(context: context, builder: (BuildContext context) {
                                                                                          return Center(
                                                                                            child: Card(
                                                                                              shape: const RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.all(Radius.circular(15))
                                                                                              ),
                                                                                              child: Container(
                                                                                                width: MediaQuery.of(context).size.width * 0.7,
                                                                                                height: 100,
                                                                                                padding: const EdgeInsets.only(top: 20, bottom: 20, right: 25, left: 25),
                                                                                                decoration: const BoxDecoration(
                                                                                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                                                                                ),
                                                                                                child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: [
                                                                                                    const Text("Password:"),
                                                                                                    Text(_Compromised.Password[index]),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        });
                                                                                  },
                                                                                  contentPadding: const EdgeInsets.all(0),
                                                                                  leading: Container(
                                                                                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                    child: Image.asset("assets/images/fbIcon.png"),
                                                                                  ),

                                                                                  trailing: IconButton(
                                                                                    onPressed: () {
                                                                                      Clipboard.setData(ClipboardData(text: _Compromised.Password[index]));
                                                                                      Fluttertoast.showToast(msg: "Password Copied!");
                                                                                    },
                                                                                    icon: Image.asset("assets/images/copyicon.png"),
                                                                                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                                                                                  ),
                                                                                  title: Container(
                                                                                    padding: const EdgeInsets.only(left: 10),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        Text(_Compromised.Title[index],
                                                                                          style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 14
                                                                                          ),
                                                                                        ),
                                                                                        AutoSizeText(
                                                                                          _Compromised.Email[index],
                                                                                          //_Emails![index],
                                                                                          style: const TextStyle(
                                                                                              fontSize: 12),
                                                                                          maxLines: 1,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }),
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: LottieEffect,
                                                                      child: ElevatedButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: const Text("Done")),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                          }
                                                        );
                                                      });
                                                },
                                                child: const Text("Fix All"),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  );
                                });
                          },
                          child: const Text("Show Compromised Passwords",
                            style: TextStyle(color: Colors.white),)
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
        context.read<allPassProvider>().Password[_Compromised.pointer[i]] = temp;
      }

      _savePasswords();
    }

    _checkIdentical()async{

      Timer(const Duration(seconds: 1), () async{
        List<String> temp = _AccDetails.Password;
        var removedDupes = temp.toSet().toList();

        setState((){
          _identical = temp.length - removedDupes.length;
        });

      });
    }


  @override
  Widget build(BuildContext context){
      _AccDetails.isShow = true;
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
                  children: [
                      FadeIn(
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 600),
                        child: Text(
                          compromised.toString(),
                          style: const TextStyle(
                              color: Color(0xffFFF9F9),
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
                          color: Color(0xffFFF9F9),
                          fontSize: 18,


                        ),
                      ),
                    ),
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
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                                          duration: const Duration(milliseconds: 500),
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
                                                    color: _catSelected[index] ? ColorObject.accent[currColor] : ColorObject.accent[currColor], width: 1
                                                ),

                                                backgroundColor: _catSelected[index] ? ColorObject.accent[currColor] : const Color(0xffFFF9F9),
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
                              itemCount: _catSelected[0] ? context.watch<allPassProvider>().length : _catSelected[1] ? context.watch<mostUsedProvider>().length : _catSelected[2] ? context.watch<socialProvider>().length : _catSelected[3] ? context.watch<workProvider>().length : context.watch<searchProvider>().length,
                                itemBuilder: (BuildContext context, int index){
                                return Container(
                                    width: MediaQuery.of(context).size.width * 1,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 50,
                                    child: _catSelected[0] ? allList(index: index) : _catSelected[1] ? Text("most used") : _catSelected[2] ? socialListView(index: index) : _catSelected[3] ? Text("Work") : Text("search") //searchListView(index: index)



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
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      height: 275,
                                      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: Column(
                                        children: [
                                        const Text("Add Account", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                          Expanded(
                                            flex: 1,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [

                                                  TextField(
                                                      decoration: const InputDecoration(hintText: "App Name"),
                                                      style: const TextStyle(fontSize: 14),
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
                                                    style: const TextStyle(fontSize: 14),
                                                    controller: _emailCon,
                                                    autofillHints: const [AutofillHints.email],
                                                  ),
                                                  TextField(
                                                    decoration: const InputDecoration(hintText: "Password"),
                                                    onChanged: (val3){
                                                      setState((){
                                                        tempPass = _passCon.text;
                                                      });
                                                    },
                                                    style: const TextStyle(fontSize: 14),
                                                    controller: _passCon,
                                                    autofillHints: const [AutofillHints.password],
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
                                                    context.read<allPassProvider>().addallPass(tempName, _emailCon.text, _passCon.text);
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
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(ColorObject.primary[currColor]),
                                  foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffFFF9F9)),
                                  minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width * 0.8, 50))

                              ),
                              child: const Text("Add Account"),
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
                            SizedBox(
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      _identical.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),
                                    ),
                                    const Text("Identical\nPasswords")
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