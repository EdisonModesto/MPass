
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class searchProvider with ChangeNotifier{
  List<String> Title = [];
  List<String> Email = [];
  List<String> Password = [];
  int length = 0;
  int pointer = 0;

  void searchPass(String title, email, password){
    Title.add(title);
    Email.add(email);
    Password.add(password);
    notifyListeners();
  }


  void addSearchPass(String title, email, password, int point){
    Title.add(title);
    length = Title.length;
    Email.add(email);
    Password.add(password);
    pointer = point;
    notifyListeners();
  }

  void clearSearch(){
    Title.clear();
    Email.clear();
    Password.clear();
    length = Title.length;
    notifyListeners();
  }


  void initSearch()async{
    final prefs = await SharedPreferences.getInstance();

    Title = prefs.getStringList('SearchTitle')!;
    Email = prefs.getStringList('SearchEmail')!;
    Password = prefs.getStringList('SearchPass')!;
    notifyListeners();
  }


}