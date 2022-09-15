import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/providers/searchProvider.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../dialogs/viewPassDialog.dart';
import '../providers/colors.dart';

class searchListView extends StatefulWidget {
  const searchListView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<searchListView> createState() => _searchListViewState();
}

class _searchListViewState extends State<searchListView> {


  //Color Object instance
  AppColors ColorObject = AppColors();
  int currColor = 0;


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
            Clipboard.setData(ClipboardData(text: context.read<searchProvider>().Password[widget.index]));
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

                context.watch<searchProvider>().Title[widget.index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                context.watch<searchProvider>().Email[widget.index],
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
