import 'package:flutter/material.dart';
import 'package:mpass/compromised.dart';

class comproList extends StatefulWidget {
  const comproList({Key? key}) : super(key: key);

  @override
  State<comproList> createState() => _comproListState();
}

class _comproListState extends State<comproList> {

  Compromised _Compromised = new Compromised();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _Compromised.Title.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_Compromised.Title[index]),
        );
      },

    );
  }
}
