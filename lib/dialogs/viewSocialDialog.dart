import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/categories/social.dart';
import 'package:mpass/providers/socialProvider.dart';
import 'package:provider/provider.dart';

class viewSocialDialog extends StatefulWidget {
  const viewSocialDialog({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<viewSocialDialog> createState() => _viewSocialDialogState();
}

class _viewSocialDialogState extends State<viewSocialDialog> {
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
                  context.watch<socialProvider>().Title[widget.index],
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
                      child: AutoSizeText(" : ${context.watch<socialProvider>().Email[widget.index]}", maxLines: 1, minFontSize: 6,),
                    ),
                    IconButton(
                        onPressed: (){
                          Clipboard.setData(ClipboardData(text: context.read<socialProvider>().Email[widget.index]));
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
                      child: AutoSizeText(" : ${context.watch<socialProvider>().Password[widget.index]}", minFontSize: 6, maxLines: 1,),
                    ),
                    IconButton(
                        onPressed: (){
                          Clipboard.setData(ClipboardData(text: context.read<socialProvider>().Password[widget.index]));
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
                          context.read<socialProvider>().deleteAllPass(widget.index);
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
