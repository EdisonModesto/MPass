import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin{

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Lottie.asset(
            "assets/lottie/loader.json",
            controller: _controller,
            onLoaded: (composition){
             _controller.duration = composition.duration;
             _controller.forward().whenComplete(() => {
               Navigator.pop(context),
             });
            }
          )
        ),
      ),
    );
  }
}
