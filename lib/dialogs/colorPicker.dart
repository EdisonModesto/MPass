import 'dart:async';
import 'package:mpass/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/colors/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/colors.dart';

class customColorPicker extends StatefulWidget {
  const customColorPicker({Key? key}) : super(key: key);

  @override
  State<customColorPicker> createState() => _customColorPickerState();
}

class _customColorPickerState extends State<customColorPicker> {

    AppColors ColorObject = AppColors();

    int chosenColor = 0;

    _getsharedPref()async{
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();

    }

    _writePref(int index)async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("colorIndex", index);
      _getsharedPref();

    }

    @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 8.0,
            children: List.generate(ColorObject.primary.length, (index){
              return Container(
                decoration: BoxDecoration(
                  color: ColorObject.primary[index],
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                
                child: TextButton(
                  onPressed: () {
                    _writePref(index);
                    context.read<colorProvider>().setColor(index);
                    //Fluttertoast.showToast(msg: index.toString() + " $chosenColor");

                  },
                  child: Text("", style: TextStyle(color: Colors.white),),
                ),
              );
            })
          ),
          

        ),
      ),
    );
  }
}
