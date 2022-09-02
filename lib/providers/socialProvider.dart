
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class socialProvider with ChangeNotifier{
  List<String> Title = [];
  List<String> Email = [];
  List<String> Password = [];
  int length = 0;

  void addSocial(String title, email, password){
    Title.add(title);
    Email.add(email);
    Password.add(password);
    length = Title.length;
    _saveSocial();
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
    _saveSocial();
  }

  void _saveSocial()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("SocialTitle", Title);
    prefs.setStringList("SocialEmail", Email);
    prefs.setStringList("SocialPass", Password);
    notifyListeners();
  }

  void initSocial()async{
    final prefs = await SharedPreferences.getInstance();

    Title = prefs.getStringList('SocialTitle')!;
    Email = prefs.getStringList('SocialEmail')!;
    Password = prefs.getStringList('SocialPass')!;
    length = Title.length;
    notifyListeners();
  }


}