
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class allPassProvider with ChangeNotifier{
  List<String> Title = [];
  List<String> Email = [];
  List<String> Password = [];
  int length = 0;

  void addallPass(String title, email, password){
    Title.add(title);
    length = Title.length;
    Email.add(email);
    Password.add(password);
    notifyListeners();
    _saveallPass();
  }

  void _saveallPass()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("Titles", Title);
    prefs.setStringList("Emails", Email);
    prefs.setStringList("Passwords", Password);
    notifyListeners();
  }

  void deleteAllPass(int index)async{
    await Future.delayed(Duration(milliseconds: 200));
    Title.removeAt(index);
    length = Title.length;
    notifyListeners();
    Email.removeAt(index);
    Password.removeAt(index);
    notifyListeners();
    _saveallPass();
  }

  void initallPass()async{
    final prefs = await SharedPreferences.getInstance();

    Title = prefs.getStringList('Titles')!;
    Email = prefs.getStringList('Emails')!;
    Password = prefs.getStringList('Passwords')!;
    length = Title.length;
    notifyListeners();
  }


}