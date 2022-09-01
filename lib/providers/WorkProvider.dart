
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class workProvider with ChangeNotifier{
  List<String> Title = [];
  List<String> Email = [];
  List<String> Password = [];
  int length = 0;

  void addWork(String title, email, password){
    Title.add(title);
    Email.add(email);
    Password.add(password);
    _saveWork();
    notifyListeners();
  }

  void _saveWork()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("WorkTitle", Title);
    prefs.setStringList("WorkEmail", Email);
    prefs.setStringList("WorkPass", Password);
    notifyListeners();
  }

  void initWork()async{
    final prefs = await SharedPreferences.getInstance();

    Title = prefs.getStringList('WorkTitle')!;
    Email = prefs.getStringList('WorkEmail')!;
    Password = prefs.getStringList('WorkPass')!;
    notifyListeners();
  }


}