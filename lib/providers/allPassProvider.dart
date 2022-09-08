
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class allPassProvider with ChangeNotifier{
  List<String> Title = [];
  List<String> Email = [];
  List<String> Password = [];
  List<String> isSocial = [];
  List<String> isWork = [];
  int length = 0;

  void addSocial(int index){
    isSocial[index] = "1";
    notifyListeners();
  }

  void restore(T, E, P){
    List<String> tStr = List<String>.from(T);
    List<String> eStr = List<String>.from(E);
    List<String> pStr = List<String>.from(P);
    Title.clear();
    Email.clear();
    Password.clear();
    isSocial.clear();
    isWork.clear();
    length = 0;

    Title.addAll(tStr);
    Email.addAll(eStr);
    Password.addAll(pStr);
    isWork = List.filled(Title.length, "0", growable: true);
    isSocial = List.filled(Title.length, "0", growable: true);
    length = Title.length;
    notifyListeners();
    _saveallPass();
    print(tStr);
    print(eStr);
    print(pStr);
    print("Saved");

  }

  void delSocial(int index){
    isSocial[index] = "0";
    notifyListeners();
  }

  void addWork(int index){
    isWork[index] = "1";
    notifyListeners();
  }

  void delWork(int index){
    isWork[index] = "0";
    notifyListeners();
  }

  void addallPass(String title, email, password){
    Title.add(title);
    length = Title.length;
    Email.add(email);
    Password.add(password);
    isSocial.add("0");
    isWork.add("0");
    notifyListeners();
    _saveallPass();
  }

  void _saveallPass()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("Titles", Title);
    prefs.setStringList("Emails", Email);
    prefs.setStringList("Passwords", Password);
    prefs.setStringList("isSocial", isSocial);
    prefs.setStringList("isWork", isWork);
    notifyListeners();
  }

  void deleteAllPass(int index)async{
    await Future.delayed(Duration(milliseconds: 200));
    Title.removeAt(index);
    length = Title.length;
    notifyListeners();
    Email.removeAt(index);
    Password.removeAt(index);
    isWork.removeAt(index);
    isSocial.removeAt(index);
    notifyListeners();
    _saveallPass();
  }

  void initallPass()async{
    final prefs = await SharedPreferences.getInstance();
    Title = prefs.getStringList('Titles')!;
    Email = prefs.getStringList('Emails')!;
    Password = prefs.getStringList('Passwords')!;
    isSocial = prefs.getStringList("isSocial")!;
    isWork = prefs.getStringList("isWork")!;
    length = Title.length;

    notifyListeners();
  }


}