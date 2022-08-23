import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff8269B8), //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MPass',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xff8269B8)
      ),

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: PageView(
        children: [
          //Home
          SafeArea(
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
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 5),

                                children: <Widget>[
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Color(0xffD9D9D9),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Facebook",
                                            ),
                                            Text("sample@email.com")
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Color(0xffD9D9D9),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Facebook",
                                            ),
                                            Text("sample@email.com")
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Color(0xffD9D9D9),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Facebook",
                                            ),
                                            Text("sample@email.com")
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Color(0xffD9D9D9),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Facebook",
                                            ),
                                            Text("sample@email.com")
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Color(0xffD9D9D9),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Facebook",
                                            ),
                                            Text("sample@email.com")
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Color(0xffD9D9D9),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Facebook",
                                            ),
                                            Text("sample@email.com")
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
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
          ),
          
          //Generate
          SafeArea(
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
                            flex: 7,
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
                            flex: 60,
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 5),

                                children: <Widget>[
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffBAABDA),
                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          height: 50,
                                          width: 20,
                                        ),

                                        Container(
                                          child: const Text(
                                              "48213VuS7m!S",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffBAABDA),
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          height: 50,
                                          width: 20,
                                        ),

                                        Container(
                                          child: const Text(
                                            "48213VuS7m!S",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffBAABDA),
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          height: 50,
                                          width: 20,
                                        ),

                                        Container(
                                          child: const Text(
                                            "48213VuS7m!S",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffBAABDA),
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          height: 50,
                                          width: 20,
                                        ),

                                        Container(
                                          child: const Text(
                                            "48213VuS7m!S",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffBAABDA),
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          height: 50,
                                          width: 20,
                                        ),

                                        Container(
                                          child: const Text(
                                            "48213VuS7m!S",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //color: Color(0xffBAABDA),
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffBAABDA),
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          height: 50,
                                          width: 20,
                                        ),

                                        Container(
                                          child: const Text(
                                            "48213VuS7m!S",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/copyicon.png"),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
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
                                child: Text("Generate"),
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
          ),
        ],
      )


    );
  }
}
