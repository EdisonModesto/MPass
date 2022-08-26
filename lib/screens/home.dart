import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpass/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';


class Home extends StatefulWidget{
  @override
  _homePage createState() => new _homePage();
}

class _homePage extends State<Home>{

  //categories Button and states
  List<String> _category = ["All", "Most Used", "Social", "Work"];
  List _catSelected = [false, false, false, false];

  //passwords
  List<String>? _Titles = [];
  List<String>? _Emails = [];
  List<String>? _Passwords = [];

  int totalPass = 0;


    _getPasswords() async {
      final IconPref = await SharedPreferences.getInstance();
      final TitlePref = await SharedPreferences.getInstance();
      final EmailPref = await SharedPreferences.getInstance();
      final PasswordPref = await SharedPreferences.getInstance();

      setState(() {
        _Titles = TitlePref.getStringList('Titles')!;
        _Emails = EmailPref.getStringList('Emails')!;
        _Passwords = PasswordPref.getStringList('Passwords')!;
      });
    }


  _savePasswords(String tempTitle, String tempEmail, String tempPass) async{

    final IconPref = await SharedPreferences.getInstance();
    final TitlePref = await SharedPreferences.getInstance();
    final EmailPref = await SharedPreferences.getInstance();
    final PasswordPref = await SharedPreferences.getInstance();

    setState((){
      _Titles?.add(tempTitle);
      _Emails?.add(tempEmail);
      _Passwords?.add(tempPass);
      totalPass += 1;
    });

    await TitlePref.setStringList('Titles', _Titles!);
    await EmailPref.setStringList('Emails', _Emails!);
    await PasswordPref.setStringList('Passwords', _Passwords!);
  }




  @override
  Widget build(BuildContext context){

      _getPasswords();
      totalPass = _Titles!.length;
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
                          flex: 18,
                          child: Column(
                            children: [
                              //Text Lbl
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                margin: EdgeInsets.only(bottom: 10),
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
                                  flex: 50,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 60,
                                    child: ListView.builder(
                                      itemCount: _category.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index){
                                        return Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: OutlinedButton(
                                            onPressed: () => {
                                              setState((){
                                                _catSelected[index] = true;
                                                for(int i = 0; i < _category.length; i++){
                                                  if(i != index){
                                                    _catSelected[i] = false;
                                                  }
                                                }
                                              })
                                            },
                                            style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: _catSelected[index] ? Color(0xffA491CD) : Color(0xff8269B8), width: 1
                                                ),

                                                backgroundColor: _catSelected[index] ? Color(0xffA491CD) : Color(0xffFFF9F9),
                                                minimumSize: Size(20, 0.5)

                                            ),
                                            child: Text(
                                              _category[index],
                                              style: TextStyle(
                                                color: _catSelected[index] ? Color(0xffFFF9F9) : Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 5),

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
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: ListView.builder(
                              itemCount: _Titles?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height: 50,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: Container(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: Image.asset("assets/images/fbIcon.png"),
                                    ),

                                    trailing: IconButton(
                                        onPressed: null,
                                        icon: Image.asset("assets/images/copyicon.png"),
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    ),
                                    title: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(

                                            _Titles![index],
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          AutoSizeText(
                                            _Emails![index],
                                            style: TextStyle(fontSize: 14),
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                    )
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
                              onPressed: () async{

                                String tempName = "";
                                String tempMail = "";
                                String tempPass = "";
                                //final TextEditingController _controller = TextEditingController();
                                showDialog(context: context, builder: (_) =>
                                  AlertDialog(
                                    title: const Text(
                                      "Add Account",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),

                                    actions: [
                                      TextButton(
                                          onPressed: (){
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Close"),
                                      ),
                                      TextButton(
                                          onPressed: (){
                                              _savePasswords(tempName, tempMail, tempPass);
                                            Navigator.pop(context, true);
                                          },

                                          child: const Text("Add")
                                      ),
                                    ],

                                    content: Container(
                                      width: MediaQuery.of(context).size.width * 1,
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      child: Column(
                                        children: [
                                          TextField(
                                            decoration: const InputDecoration(hintText: "App Name"),
                                            onChanged: (val) {
                                              setState((){
                                                tempName = val;
                                              });
                                            },
                                          ),
                                          TextField(
                                            decoration: const InputDecoration(hintText: "Email"),
                                            onChanged: (val2){
                                              setState((){
                                                tempMail = val2;
                                              });
                                            },
                                          ),
                                          TextField(
                                            decoration: const InputDecoration(hintText: "Password"),
                                            onChanged: (val3){
                                              setState((){
                                                tempPass = val3;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          totalPass.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                        ),
                                      ),
                                      Text("Total\nPasswords")
                                    ],
                                  ),
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