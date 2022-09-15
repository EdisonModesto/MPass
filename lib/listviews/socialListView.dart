import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/dialogs/viewSocialDialog.dart';
import 'package:mpass/providers/socialProvider.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../dialogs/viewPassDialog.dart';
import '../providers/colors.dart';

class socialListView extends StatefulWidget {
  const socialListView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<socialListView> createState() => _socialListViewState();
}

class _socialListViewState extends State<socialListView> {

  //Color Object instance
  AppColors ColorObject = AppColors();
  int currColor = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: (){
          showDialog(context: context, builder: (BuildContext context){
            return viewSocialDialog(index: widget.index);
          });
        },
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          width: 45,
          height: 45,
          //padding: const EdgeInsets.only(top:3, bottom: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: ColorObject.accent[context.watch<colorProvider>().colIndex],
          ),
          child: const Center(
              child: Text(
                "*",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40
                ),
              )
          ),
        ),

        trailing: IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: context.read<socialProvider>().Password[widget.index]));
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
