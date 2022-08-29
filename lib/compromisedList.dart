import 'package:flutter/material.dart';
import 'package:mpass/compromised.dart';

class comproList extends StatefulWidget {
  const comproList({Key? key}) : super(key: key);

  @override
  State<comproList> createState() => _comproListState();
}

class _comproListState extends State<comproList> {

  final Compromised _Compromised = Compromised();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.white60,
            child: ListView.builder(
              itemCount: _Compromised.Title.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_Compromised.Title[index]),
                );
              },

            ),
          ),
        )
    );
  }
}
