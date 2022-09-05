
import 'package:mpass/providers/isFirstLaunch.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class onBoardScreen extends StatefulWidget {
  const onBoardScreen({Key? key}) : super(key: key);

  @override
  State<onBoardScreen> createState() => _onBoardScreenState();
}

class _onBoardScreenState extends State<onBoardScreen> with TickerProviderStateMixin{

  late final AnimationController _controller;

  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
          done: const Icon(Icons.done, color: Color(0xff8269B8)),
          next: const Icon(Icons.arrow_forward, color: Color(0xff8269B8)),
          back: const Icon(Icons.arrow_back, color: Color(0xff8269B8)),
          showBackButton: true,
          showSkipButton: false,
          onDone: (){
            context.read<isFirstLaunch>().changeIsFirst(false);
          },
          pages: [
            PageViewModel(
              titleWidget: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                width: MediaQuery.of(context).size.width * 1,
                child: const Text(
                  "Hi! Welcome to MPass!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              bodyWidget: const Padding(
                padding:  EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "MPass is a secure way of managing your passwords with ease. Let me show you around!",
                  textAlign: TextAlign.justify,
                ),
              ) ,
              image: Padding(
                padding: const EdgeInsets.all(90),
                child: Lottie.asset(
                    "assets/lottie/logo.json",
                    repeat: true,
                    controller: _controller,
                    onLoaded: (composition){
                      _controller.duration = composition.duration;
                      _controller.forward().whenComplete(() => (){

                      });
                    }
                ),
              ),

            ),
            PageViewModel(
              titleWidget: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                width: MediaQuery.of(context).size.width * 1,
                child: const Text(
                  "Save Passwords",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              bodyWidget: const Padding(
                padding:  EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "Thanks to MPass, you can now store your passwords securely without forgetting. All passwords are stored locally on your device.",
                  textAlign: TextAlign.justify,
                ),
              ) ,
              image: Padding(
                padding: const EdgeInsets.all(70),
                child: Lottie.asset(
                    "assets/lottie/save.json",
                    repeat: true,
                    controller: _controller,
                    onLoaded: (composition){
                      _controller.duration = composition.duration;
                      _controller.forward().whenComplete(() => (){

                      });
                    }
                ),
              ),

            ),
            PageViewModel(
              titleWidget: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                width: MediaQuery.of(context).size.width * 1,
                child: const Text(
                  "Generate Passwords",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              bodyWidget: const Padding(
                padding:  EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "Need strong passwords? No need to worry! MPass helps you generate strong passwords so that you don't have to.",
                  textAlign: TextAlign.justify,
                ),
              ) ,
              image: Padding(
                padding: const EdgeInsets.all(40),
                child: Lottie.asset(
                    "assets/lottie/generate.json",
                    repeat: true,
                    controller: _controller,
                    onLoaded: (composition){
                      _controller.duration = composition.duration;
                      _controller.forward().whenComplete(() => (){

                      });
                    }
                ),
              ),

            ),
            PageViewModel(
              titleWidget: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                width: MediaQuery.of(context).size.width * 1,
                child: const Text(
                  "Be alerted!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              bodyWidget: const Padding(
                padding:  EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "Be alerted when your passwords are found in a data leak! Your passwords are hashed using the SHA-1 algorithm during the scanning process to ensure maximum security. Powered by the haveibeenpwned API.",
                  textAlign: TextAlign.justify,
                ),
              ) ,
              image: Padding(
                padding: const EdgeInsets.all(60),
                child: Lottie.asset(
                    "assets/lottie/warning.json",
                    repeat: true,
                    controller: _controller,
                    onLoaded: (composition){
                      _controller.duration = composition.duration;
                      _controller.forward().whenComplete(() => (){

                      });
                    }
                ),
              ),

            ),
            PageViewModel(
              titleWidget: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                width: MediaQuery.of(context).size.width * 1,
                child: const Text(
                  "Backup your passwords",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              bodyWidget: const Padding(
                padding:  EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "Afraid of losing all your passwords? No need to worry! With MPass, you can backup your passwords locally at anytime you like! You can also setup automatic backups!",
                  textAlign: TextAlign.justify,
                ),
              ) ,
              image: Padding(
                padding: const EdgeInsets.all(60),
                child: Lottie.asset(
                    "assets/lottie/backup.json",
                    repeat: true,
                    controller: _controller,
                    onLoaded: (composition){
                      _controller.duration = composition.duration;
                      _controller.forward().whenComplete(() => (){

                      });
                    }
                ),
              ),

            ),
            PageViewModel(
              titleWidget: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                width: MediaQuery.of(context).size.width * 1,
                child: const Text(
                  "All done!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              bodyWidget: const Padding(
                padding:  EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "You are now ready to use MPass! Please let us now what you think!",
                  textAlign: TextAlign.justify,
                ),
              ) ,
              image: Padding(
                padding: const EdgeInsets.all(40),
                child: Lottie.asset(
                    "assets/lottie/lock.json",
                    repeat: true,
                    controller: _controller,
                    onLoaded: (composition){
                      _controller.duration = composition.duration;
                      _controller.forward().whenComplete(() => (){

                      });
                    }
                ),
              ),

            ),

          ],
        ),
    );
  }
}
