
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class workProvider with ChangeNotifier{
  List<String> Title = [];
  List<String> Email = [];
  List<String> Password = [];
  List<String> pointer = [];
  int length = 0;

  void addWork(String title, email, password, pt){
    Title.add(title);
    Email.add(email);
    Password.add(password);
    pointer.add(pt);
    length = Title.length;
    _saveWork();
    notifyListeners();
  }

  void deleteAllPass(int index)async{
    await Future.delayed(const Duration(milliseconds: 200));
    Title.removeAt(index);
    length = Title.length;
    notifyListeners();
    Email.removeAt(index);
    Password.removeAt(index);
    pointer.removeAt(index);
    _saveWork();
    notifyListeners();
  }

  void restore(){
    Title.clear();
    Email.clear();
    Password.clear();
    pointer.clear();
    length = 0;
    _saveWork();
  }

  void _saveWork()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("WorkTitle", Title);
    prefs.setStringList("WorkEmail", Email);
    prefs.setStringList("WorkPass", Password);
    prefs.setStringList("isWork", pointer);
    notifyListeners();
  }

  void initWork()async{
    final prefs = await SharedPreferences.getInstance();

    Title = prefs.getStringList('WorkTitle')!;
    Email = prefs.getStringList('WorkEmail')!;
    Password = prefs.getStringList('WorkPass')!;
    pointer = prefs.getStringList("isWork")!;
    length = Title.length;
    notifyListeners();
  }


}