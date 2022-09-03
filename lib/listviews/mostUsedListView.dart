import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../dialogs/viewPassDialog.dart';
import '../providers/allPassProvider.dart';

class mostUsedListView extends StatefulWidget {
  const mostUsedListView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<mostUsedListView> createState() => _mostUsedListViewState();
}

class _mostUsedListViewState extends State<mostUsedListView> {
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
            Clipboard.setData(ClipboardData(text: context.read<allPassProvider>().Password[widget.index]));
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

                context.watch<allPassProvider>().Title[widget.index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                context.watch<allPassProvider>().Email[widget.index],
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
