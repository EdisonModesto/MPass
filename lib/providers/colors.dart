import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class colorProvider with ChangeNotifier{
  int colorIndex = 0;

  int get colIndex => colorIndex;

  void setColor(int index){
    colorIndex = index;
    notifyListeners();
  }

  void initColor()async{
    final prefs = await SharedPreferences.getInstance();
    colorIndex = prefs.getInt("colorIndex")!;
    notifyListeners();
  }
}