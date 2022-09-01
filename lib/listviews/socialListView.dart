import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/providers/socialProvider.dart';
import 'package:provider/provider.dart';

import '../dialogs/viewPassDialog.dart';

class socialListView extends StatefulWidget {
  const socialListView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<socialListView> createState() => _socialListViewState();
}

class _socialListViewState extends State<socialListView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: (){
          showDialog(context: context, builder: (BuildContext context){
            return viewPassDialog(index: widget.index);
          });
        },
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Image.asset("assets/images/fbIcon.png"),
        ),

        trailing: IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: context.watch<socialProvider>().Password[widget.index]));
            Fluttertoast.showToast(msg: "Password Copied!");
          },
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

                context.watch<socialProvider>().Title[widget.index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                context.watch<socialProvider>().Email[widget.index],
                //_Emails![index],
                style: const TextStyle(fontSize: 14),
                maxLines: 1,
              )
            ],
          ),
        )
    );
  }
}
