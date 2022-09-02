import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/categories/work.dart';
import 'package:mpass/providers/WorkProvider.dart';
import 'package:provider/provider.dart';

class viewWorkDialog extends StatefulWidget {
  const viewWorkDialog({Key? key,required this.index}) : super(key: key);
  final int index;
  @override
  State<viewWorkDialog> createState() => _viewWorkDialogState();
}

class _viewWorkDialogState extends State<viewWorkDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 230,
            decoration: const BoxDecoration(
                color: Color(0xffFFF9F9),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  context.watch<workProvider>().Title[widget.index],
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.email),
                    Expanded(
                      child: AutoSizeText(" : ${context.watch<workProvider>().Email[widget.index]}", maxLines: 1,),
                    ),
                    IconButton(
                        onPressed: (){
                          Clipboard.setData(ClipboardData(text: context.watch<workProvider>().Email[widget.index]));
                          Fluttertoast.showToast(msg: "Email Copied!");
                        },
                        icon: Image.asset("assets/images/copyicon.png", width: 25, height: 25,)
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.password),
                    Expanded(
                      child: Text(" : ${context.watch<workProvider>().Password[widget.index]}"),
                    ),
                    IconButton(
                        onPressed: (){
                          Clipboard.setData(ClipboardData(text: context.watch<workProvider>().Password[widget.index]));
                          Fluttertoast.showToast(msg: "Password Copied");
                        },
                        icon: Image.asset("assets/images/copyicon.png", width: 25, height: 25,))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Account Removed");
                          context.read<workProvider>().deleteAllPass(widget.index);
                          Fluttertoast.showToast(msg: "Account Removed");
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.redAccent
                          ),
                        )
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Close")
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
