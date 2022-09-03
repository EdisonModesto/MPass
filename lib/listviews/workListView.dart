import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/categories/work.dart';
import 'package:mpass/dialogs/viewWorkDialog.dart';
import 'package:mpass/providers/WorkProvider.dart';
import 'package:provider/provider.dart';

import '../dialogs/viewSocialDialog.dart';

class workListView extends StatefulWidget {
  const workListView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<workListView> createState() => _workListViewState();
}

class _workListViewState extends State<workListView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: (){
          showDialog(context: context, builder: (BuildContext context){
            return viewWorkDialog(index: widget.index);
          });
        },
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Image.asset("assets/images/fbIcon.png"),
        ),

        trailing: IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: context.read<workProvider>().Password[widget.index]));
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

                context.watch<workProvider>().Title[widget.index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                context.watch<workProvider>().Email[widget.index],
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
