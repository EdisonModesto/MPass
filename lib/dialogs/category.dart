import 'package:flutter/material.dart';
import 'package:mpass/categories/social.dart';
import 'package:mpass/colors/AppColors.dart';
import 'package:mpass/dialogs/socialDialog.dart';
import 'package:mpass/dialogs/workDialog.dart';
import 'package:mpass/providers/colors.dart';
import 'package:provider/provider.dart';

class catDialog extends StatefulWidget {
  const catDialog({Key? key}) : super(key: key);

  @override
  State<catDialog> createState() => _catDialogState();
}

class _catDialogState extends State<catDialog> {

  final AppColors _appColors = AppColors();
  int currColor = 0;


  @override
  Widget build(BuildContext context) {
    currColor = context.watch<colorProvider>().colorIndex;
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                height: 55,
                child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    showDialog(context: context, builder: (BuildContext context){
                      return socialDialog();
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: _appColors.primary[currColor],
                  ),
                  child: const Text("Social", style: TextStyle(color: Color(0xffFFF9F9)),),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                height: 55,
                child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    showDialog(context: context, builder: (BuildContext context){
                      return workDialog();
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: _appColors.primary[currColor],
                  ),
                  child: const Text("Work", style: TextStyle(color: Color(0xffFFF9F9)),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
