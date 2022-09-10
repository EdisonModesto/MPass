
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mostUsedProvider with ChangeNotifier{
  List<String> Title = [];
  List<String> Email = [];
  List<String> Password = [];
  List<String> pointer = [];
  int length = 0;

  void addallMostUsed(String title, email, password, pt){
    Title.add(title);
    Email.add(email);
    Password.add(password);
    pointer.add(pt);
    length = Title.length;
    _saveMostUsed();
    notifyListeners();
  }

  void _saveMostUsed()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("MostUsedTitle", Title);
    prefs.setStringList("MostUsedEmail", Email);
    prefs.setStringList("MostUsedPass", Password);
    notifyListeners();
  }

  void initMostUsed()async{
    final prefs = await SharedPreferences.getInstance();

    Title = prefs.getStringList('MostUsedTitle')!;
    Email = prefs.getStringList('MostUsedEmail')!;
    Password = prefs.getStringList('MostUsedPass')!;
    notifyListeners();
  }
}