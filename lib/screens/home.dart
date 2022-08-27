import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/passwords.dart';


class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<Home>{

  //categories Button and states
  List<String> _category = ["All", "Most Used", "Social", "Work"];
  List _catSelected = [false, false, false, false];

  final PasswordPref = SharedPreferences.getInstance();

  //passwords
  accDetails _AccDetails = new accDetails();

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
    }

  _savePasswords() async{


    final PasswordPref = await SharedPreferences.getInstance();

    await PasswordPref.setStringList('Titles', _AccDetails.Title);
    await PasswordPref.setStringList('Emails', _AccDetails.Email);
    await PasswordPref.setStringList('Passwords', _AccDetails.Password);
  }

  @override
  void initState() {
    _getPasswords();
    super.initState();
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
                    children: [
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
                          flex: 63,
                          child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: ListView.builder(
                              itemCount: _AccDetails.Title.length,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                    width: MediaQuery.of(context).size.width * 1,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 50,
                                    child: /* Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Container(
                                              width: MediaQuery.of(context).size.width * .1,
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Image.asset(
                                                  "assets/images/fbIcon.png"),
                                            ),
                                         Container(
                                           width: MediaQuery.of(context).size.width * .56,
                                                  padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Text(

                                                    _AccDetails.Title[index],
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  AutoSizeText(
                                                    _AccDetails.Email[index],
                                                    //_Emails![index],
                                                    style: TextStyle(fontSize: 14),
                                                    maxLines: 1,
                                                  )
                                                ],
                                              ),
                                            ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * .1,
                                            child: IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: _AccDetails.Password[index]));
                                                Fluttertoast.showToast(
                                                    msg: "Password Copied!");
                                              },
                                              icon: Image.asset(
                                                  "assets/images/copyicon.png"),
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                            ),
                                        )
                                      ],
                                    ) */

                                    ListTile(
                                        onTap: (){
                                          setState((){
                                            _AccDetails.Title.removeAt(index);
                                            _AccDetails.Email.removeAt(index);
                                            _AccDetails.Password.removeAt(index);
                                          });
                                          _savePasswords();
                                          Fluttertoast.showToast(msg: "Account Removed");
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
                                                text: _AccDetails.Password[index]));
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

                                                _AccDetails.Title[index],
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                              AutoSizeText(
                                                _AccDetails.Email[index],
                                                //_Emails![index],
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
                              onPressed: () {
                                String tempName = "a";
                                String tempMail = "a";
                                String tempPass = "a";
                                final TextEditingController _titleCon = TextEditingController();
                                final TextEditingController _emailCon = TextEditingController();
                                final TextEditingController _passCon = TextEditingController();
                                showDialog(context: context, builder: (_) =>
                                  AlertDialog (
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
                                            _addPasswords(tempName,_emailCon.text,_passCon.text);
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
                                            controller: _emailCon,
                                          ),
                                          TextField(
                                            decoration: const InputDecoration(hintText: "Password"),
                                            onChanged: (val3){
                                              setState((){
                                                tempPass = _passCon.text;
                                              });
                                            },
                                            controller: _passCon,
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
                                        _AccDetails.Title.length.toString(),
                                        style: const TextStyle(
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