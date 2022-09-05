import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class isFirstLaunch with ChangeNotifier{
  bool isFirst = true;

  changeIsFirst(bool value)async{
    final prefs = await SharedPreferences.getInstance();
    isFirst = value;
    prefs.setBool("isFirst", value);
    notifyListeners();
  }

  initIsFirst()async{
    final prefs = await SharedPreferences.getInstance();
    isFirst = prefs.getBool("isFirst")!;
    notifyListeners();
  }
}